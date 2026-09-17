# Quality Contract template (per-stack)

Use this template only when a performance contract applies. Preserve existing accepted thresholds. New thresholds need an explicit user requirement or labeled supporting evidence (🟢 or 🟡 preferred; 🔴 with applicability conditions); mark proposals until accepted. Do not create targets merely to fill this template. After locking, thresholds judge — they are no longer proposals.

Delete the rows that don't apply to the stack; add rows the stack needs. A row without a number is not a contract, it's a wish.

```md
# Quality Contract

Stack: <e.g. Node 22 + Postgres 16 + Redis 7>
Locked: <date> · Review: when <trigger: new module / scale change>

## API
- p95 latency: <ms> at <concurrency> on <conditions>  (evidence: <label + source>)
- Error rate: <%> over <window>

## Database
- Query p95: <ms> at <N> rows
- Write p95: <ms> at <N> concurrent writers
- Index discipline: every query in a hot path has an index the plan actually uses

## Memory / CPU
- RSS ceiling: <MB> per <process>
- CPU at rest: <%> idle-loop budget

## Cost
- <per 1k calls / per job / per month>: <amount>

## Enforcement
- Where these are checked: <benchmark command / CI job / report table>
```

## Per-stack seeds

Replace thresholds with project numbers — these are shapes, not defaults:

- **Web API (Node/Go/Python + Postgres)** — API p95, query p95 at N rows, RSS ceiling, cost per 1k calls.
- **Batch/job pipeline** — job wall-time at N items, memory ceiling during peak batch, cost per job.
- **LLLM/agent feature** — p95 end-to-end, tokens per request (cost proxy), failure/fallback rate, cache-hit rate.
- **Frontend** — bundle ceiling, first-paint budget, interaction latency for key actions.
