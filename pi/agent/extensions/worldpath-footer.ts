import type {ExtensionAPI, ExtensionContext} from '@mariozechner/pi-coding-agent';
import type {AssistantMessage} from '@mariozechner/pi-ai';
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

          // Compute token stats from session history
          let totalInput = 0,
            totalOutput = 0,
            totalCost = 0;
          for (const e of ctx.sessionManager.getBranch()) {
            if (e.type === 'message' && e.message.role === 'assistant') {
              const m = e.message as AssistantMessage;
              totalInput += m.usage.input;
              totalOutput += m.usage.output;
              totalCost += m.usage.cost.total;
            }
          }

          const fmt = (n: number) => (n < 1000 ? `${n}` : `${(n / 1000).toFixed(1)}k`);
          const totalTokens = totalInput + totalOutput;

          const ctxUsage = ctx.getContextUsage();
          const ctxPct =
            ctxUsage?.percent != null
              ? `${Math.round(ctxUsage.percent)}%`
              : null;

          const statuses = [...footerData.getExtensionStatuses().values()].filter(Boolean);
          const rightParts = [
            ...statuses,
            ctxPct,
            totalTokens > 0 ? fmt(totalTokens) : null,
            totalCost > 0 ? `$${totalCost.toFixed(3)}` : null,
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
