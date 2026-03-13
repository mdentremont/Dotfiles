import type {ExtensionAPI, ExtensionContext} from '@mariozechner/pi-coding-agent';
import {truncateToWidth, visibleWidth} from '@mariozechner/pi-tui';

export default function (pi: ExtensionAPI) {
  let worldPath = '';
  let worldBranch = '';
  let rerender: (() => void) | undefined;

  async function refresh(ctx: ExtensionContext) {
    try {
      const [pathResult, branchResult] = await Promise.all([
        pi.exec('worldpath', ['-s'], {timeout: 1000}),
        pi.exec('worldpath', ['-s', '--branch'], {timeout: 1000}),
      ]);

      if (pathResult.code === 0 && pathResult.stdout.trim()) {
        worldPath = pathResult.stdout.trim();
      } else {
        worldPath = ctx.cwd;
      }

      if (branchResult.code === 0 && branchResult.stdout.trim()) {
        worldBranch = branchResult.stdout.trim();
      }

      ctx.ui.setTitle(`pi ${worldPath}${worldBranch ? ` (${worldBranch})` : ''}`);
      rerender?.();
    } catch {
      worldPath = ctx.cwd;
      rerender?.();
    }
  }

  function setFooter(ctx: ExtensionContext) {
    ctx.ui.setFooter((tui, theme, footerData) => {
      rerender = () => tui.requestRender();
      const unsubscribe = footerData.onBranchChange(() => {
        refresh(ctx);
      });

      return {
        dispose: unsubscribe,
        invalidate() {},
        render(width: number): string[] {
          const left = theme.fg('dim', worldPath || ctx.cwd);

          const statuses = [...footerData.getExtensionStatuses().values()].filter(Boolean);
          const rightParts = [
            ...statuses,
            ctx.model?.id || 'no-model',
            worldBranch ? `(${worldBranch})` : '',
          ].filter(Boolean);
          const right = theme.fg('dim', rightParts.join('  '));

          const pad = ' '.repeat(Math.max(1, width - visibleWidth(left) - visibleWidth(right)));
          return [truncateToWidth(left + pad + right, width)];
        },
      };
    });
  }

  pi.on('session_start', async (_event, ctx) => {
    setFooter(ctx);
    await refresh(ctx);
  });

  pi.on('turn_end', async (_event, ctx) => {
    await refresh(ctx);
  });

  pi.on('model_select', async (_event, ctx) => {
    rerender?.();
    await refresh(ctx);
  });
}
