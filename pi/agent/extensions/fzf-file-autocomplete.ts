/**
 * FZF File Autocomplete
 *
 * Replaces pi's built-in @ file autocomplete with fd + fzf --filter
 * for proper fuzzy file finding. Respects .fdignore and .gitignore.
 *
 * Important: this extension does NOT replace the editor component.
 * It only wraps Editor#setAutocompleteProvider, so vim-mode remains in full control.
 *
 * Requirements: fd and fzf must be installed and on PATH.
 */

import type {ExtensionAPI} from '@mariozechner/pi-coding-agent';
import {
  Editor,
  type AutocompleteItem,
  type AutocompleteProvider,
} from '@mariozechner/pi-tui';
import {spawnSync} from 'node:child_process';
import {basename, join, statSync} from 'node:path';

const PATH_DELIMITERS = new Set([' ', '\t', '"', "'", '=']);

const PATCH_APPLIED = Symbol.for(
  'shopify.fzf-file-autocomplete.editor-patch-applied',
);
const ORIGINAL_SET_AUTOCOMPLETE_PROVIDER = Symbol.for(
  'shopify.fzf-file-autocomplete.original-set-autocomplete-provider',
);

type SetAutocompleteProviderFn = (
  this: Editor,
  provider: AutocompleteProvider,
) => void;

type EditorPrototypeWithPatchState = {
  setAutocompleteProvider: SetAutocompleteProviderFn;
  [PATCH_APPLIED]?: boolean;
  [ORIGINAL_SET_AUTOCOMPLETE_PROVIDER]?: SetAutocompleteProviderFn;
};

function findLastDelimiter(text: string): number {
  for (let i = text.length - 1; i >= 0; i--) {
    if (PATH_DELIMITERS.has(text[i]!)) return i;
  }
  return -1;
}

function findUnclosedQuoteStart(text: string): number | null {
  let inQuotes = false;
  let quoteStart = -1;
  for (let i = 0; i < text.length; i++) {
    if (text[i] === '"') {
      inQuotes = !inQuotes;
      if (inQuotes) quoteStart = i;
    }
  }
  return inQuotes ? quoteStart : null;
}

function isTokenStart(text: string, index: number): boolean {
  return index === 0 || PATH_DELIMITERS.has(text[index - 1]!);
}

function extractAtPrefix(text: string): string | null {
  const quoteStart = findUnclosedQuoteStart(text);
  if (quoteStart !== null && quoteStart > 0 && text[quoteStart - 1] === '@') {
    if (!isTokenStart(text, quoteStart - 1)) return null;
    return text.slice(quoteStart - 1);
  }

  const lastDelimiterIndex = findLastDelimiter(text);
  const tokenStart = lastDelimiterIndex === -1 ? 0 : lastDelimiterIndex + 1;
  if (text[tokenStart] === '@') return text.slice(tokenStart);
  return null;
}

function parseAtPrefix(
  prefix: string,
): {rawQuery: string; isQuotedPrefix: boolean} {
  if (prefix.startsWith('@"'))
    return {rawQuery: prefix.slice(2), isQuotedPrefix: true};
  if (prefix.startsWith('@'))
    return {rawQuery: prefix.slice(1), isQuotedPrefix: false};
  return {rawQuery: prefix, isQuotedPrefix: false};
}

function buildCompletionValue(
  path: string,
  options: {isDirectory: boolean; isQuotedPrefix: boolean},
): string {
  const needsQuotes = options.isQuotedPrefix || path.includes(' ');
  if (!needsQuotes) return `@${path}`;
  return `@"${path}"`;
}

function resolveScopedQuery(
  rawQuery: string,
  basePath: string,
): {baseDir: string; query: string; displayBase: string} | null {
  const slashIndex = rawQuery.lastIndexOf('/');
  if (slashIndex === -1) return null;

  const displayBase = rawQuery.slice(0, slashIndex + 1);
  const query = rawQuery.slice(slashIndex + 1);

  let baseDir: string;
  if (displayBase.startsWith('/')) {
    baseDir = displayBase;
  } else {
    baseDir = join(basePath, displayBase);
  }

  try {
    if (!statSync(baseDir).isDirectory()) return null;
  } catch {
    return null;
  }

  return {baseDir, query, displayBase};
}

function fzfFuzzyFileSuggestions(
  rawQuery: string,
  basePath: string,
  fdPath: string,
  fzfPath: string,
  isQuotedPrefix: boolean,
): AutocompleteItem[] {
  const scoped = resolveScopedQuery(rawQuery, basePath);
  const fdBaseDir = scoped?.baseDir ?? basePath;
  const fzfQuery = scoped?.query ?? rawQuery;

  const fdArgs = [
    '--base-directory',
    fdBaseDir,
    '--type',
    'f',
    '--type',
    'd',
    '--hidden',
    '--exclude',
    '.git',
    '--color',
    'never',
  ];

  const fdResult = spawnSync(fdPath, fdArgs, {
    encoding: 'utf-8',
    stdio: ['pipe', 'pipe', 'pipe'],
    maxBuffer: 10 * 1024 * 1024,
  });

  if (fdResult.status !== 0 || !fdResult.stdout) return [];

  const fdOutput = fdResult.stdout;

  let fzfOutput: string;
  if (fzfQuery) {
    const fzfResult = spawnSync(fzfPath, ['--filter', fzfQuery], {
      input: fdOutput,
      encoding: 'utf-8',
      stdio: ['pipe', 'pipe', 'pipe'],
      maxBuffer: 10 * 1024 * 1024,
    });

    if (!fzfResult.stdout) return [];
    fzfOutput = fzfResult.stdout;
  } else {
    fzfOutput = fdOutput;
  }

  const lines = fzfOutput.trim().split('\n').filter(Boolean).slice(0, 20);
  const suggestions: AutocompleteItem[] = [];

  for (const line of lines) {
    const isDirectory = line.endsWith('/');
    const normalizedPath = isDirectory ? line.slice(0, -1) : line;
    const entryName = basename(normalizedPath);

    const displayPath = scoped
      ? scoped.displayBase === '/'
        ? `/${normalizedPath}`
        : `${scoped.displayBase}${normalizedPath}`
      : normalizedPath;

    const completionPath = isDirectory ? `${displayPath}/` : displayPath;
    const value = buildCompletionValue(completionPath, {
      isDirectory,
      isQuotedPrefix,
    });

    suggestions.push({
      value,
      label: entryName + (isDirectory ? '/' : ''),
      description: displayPath,
    });
  }

  return suggestions;
}

class FzfAutocompleteProvider implements AutocompleteProvider {
  private builtinProvider: AutocompleteProvider;
  private basePath: string;
  private fdPath: string;
  private fzfPath: string;

  constructor(
    builtinProvider: AutocompleteProvider,
    basePath: string,
    fdPath: string,
    fzfPath: string,
  ) {
    this.builtinProvider = builtinProvider;
    this.basePath = basePath;
    this.fdPath = fdPath;
    this.fzfPath = fzfPath;
  }

  getSuggestions(
    lines: string[],
    cursorLine: number,
    cursorCol: number,
  ): {items: AutocompleteItem[]; prefix: string} | null {
    const currentLine = lines[cursorLine] || '';
    const textBeforeCursor = currentLine.slice(0, cursorCol);

    const atPrefix = extractAtPrefix(textBeforeCursor);
    if (atPrefix) {
      const {rawQuery, isQuotedPrefix} = parseAtPrefix(atPrefix);
      const suggestions = fzfFuzzyFileSuggestions(
        rawQuery,
        this.basePath,
        this.fdPath,
        this.fzfPath,
        isQuotedPrefix,
      );
      if (suggestions.length === 0) return null;
      return {items: suggestions, prefix: atPrefix};
    }

    return this.builtinProvider.getSuggestions(lines, cursorLine, cursorCol);
  }

  applyCompletion(
    lines: string[],
    cursorLine: number,
    cursorCol: number,
    item: AutocompleteItem,
    prefix: string,
  ): {lines: string[]; cursorLine: number; cursorCol: number} {
    if (prefix.startsWith('@')) {
      const currentLine = lines[cursorLine] || '';
      const beforePrefix = currentLine.slice(0, cursorCol - prefix.length);
      const afterCursor = currentLine.slice(cursorCol);

      const isQuotedPrefix = prefix.startsWith('@"');
      const hasLeadingQuoteAfterCursor = afterCursor.startsWith('"');
      const hasTrailingQuoteInItem = item.value.endsWith('"');
      const adjustedAfterCursor =
        isQuotedPrefix && hasTrailingQuoteInItem && hasLeadingQuoteAfterCursor
          ? afterCursor.slice(1)
          : afterCursor;

      const isDirectory = item.label.endsWith('/');
      const suffix = isDirectory ? '' : ' ';
      const newLine = `${beforePrefix}${item.value}${suffix}${adjustedAfterCursor}`;
      const newLines = [...lines];
      newLines[cursorLine] = newLine;

      const hasTrailingQuote = item.value.endsWith('"');
      const cursorOffset =
        isDirectory && hasTrailingQuote ? item.value.length - 1 : item.value.length;

      return {
        lines: newLines,
        cursorLine,
        cursorCol: beforePrefix.length + cursorOffset + suffix.length,
      };
    }

    return this.builtinProvider.applyCompletion(
      lines,
      cursorLine,
      cursorCol,
      item,
      prefix,
    );
  }
}

function patchEditorAutocomplete(fdPath: string, fzfPath: string): boolean {
  const editorPrototype =
    Editor.prototype as unknown as EditorPrototypeWithPatchState;

  if (editorPrototype[PATCH_APPLIED]) {
    return false;
  }

  const originalSetAutocompleteProvider = editorPrototype.setAutocompleteProvider;
  editorPrototype[ORIGINAL_SET_AUTOCOMPLETE_PROVIDER] =
    originalSetAutocompleteProvider;

  editorPrototype.setAutocompleteProvider = function (
    this: Editor,
    provider: AutocompleteProvider,
  ): void {
    const wrappedProvider = new FzfAutocompleteProvider(
      provider,
      process.cwd(),
      fdPath,
      fzfPath,
    );

    originalSetAutocompleteProvider.call(this, wrappedProvider);
  };

  editorPrototype[PATCH_APPLIED] = true;
  return true;
}

function findExecutable(name: string): string | null {
  const result = spawnSync('which', [name], {
    encoding: 'utf-8',
    stdio: ['pipe', 'pipe', 'pipe'],
  });
  return result.status === 0 ? result.stdout.trim() : null;
}

export default function (pi: ExtensionAPI) {
  const fdPath = findExecutable('fd');
  const fzfPath = findExecutable('fzf');

  if (!fdPath || !fzfPath) {
    pi.on('session_start', (_event, ctx) => {
      const missing = [!fdPath && 'fd', !fzfPath && 'fzf']
        .filter(Boolean)
        .join(' and ');
      ctx.ui.notify(
        `fzf-file-autocomplete: ${missing} not found, using built-in autocomplete`,
        'warning',
      );
    });
    return;
  }

  patchEditorAutocomplete(fdPath, fzfPath);
}
