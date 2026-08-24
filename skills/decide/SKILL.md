---
name: decide
description: Close open decision axes (architecture, performance, database, api, security, test) with one AskUserQuestion per genuinely open axis, then lock decisions as ADRs and quality-contract thresholds. Use after a decision report lists open choices, when locking QUALITY-CONTRACT.md, or when another skill needs a decision recorded.
---

# Decide

Turn a Decision Report's open choices into locked decisions — fast for the human, traceable for the future.

## Axes checklist

Six axes, checked per decision point — **architecture · performance · database · api · security · test**. The checklist is a sweep, not a questionnaire: an axis gets a question only when a *genuine choice* is still open on it. Otherwise record one line — "database: settled by ADR-0004" — and move on. Asking about a settled axis spends the human's focus, which is the resource this whole skill set protects.

## Method

1. **Collect open axes** from the Decision Report's "Open choices" section. Drop any axis whose choice is already locked (existing ADR, `QUALITY-CONTRACT.md` threshold, standing decision). For each dropped axis, the one-liner above goes in the output so the sweep is visible.

2. **One AskUserQuestion per open axis.** Batch up to four questions in one call (the tool's limit) — the human answers in one pass, clicking, not typing.
   - Each option carries its trade-off inline, one line, pulled from the Decision Report — the choice and its price visible together.
   - Where an option's performance case rests on a number, the number appears in the option text *with its ladder label* (🟢/🟡/🔴/⚫). An option pitching "fast" on ⚫ evidence says so.
   - Recommended option first, marked "(Recommended)", when research actually supports one; when the evidence is ⚫ across the board, present the options honestly unranked and say why.

3. **Record each closed decision.**
   - Hard to reverse, surprising later, real trade-off → an ADR in `docs/adr/` (`domain-modeling` skill's format: scan for the highest number, increment).
   - Numeric threshold → the matching line in `QUALITY-CONTRACT.md`.
   - Everything else → one line in the ticket or research doc it belongs to. Most decisions are this kind; ADRs stay rare on purpose.

## Quality Contract

When `QUALITY-CONTRACT.md` doesn't exist yet in the target repo: seed it from the per-stack template (`${CLAUDE_SKILL_DIR}/../../references/quality-contract-template.md` in this repo), fill concrete thresholds from *labeled* benchmark evidence, then lock it with the human in one AskUserQuestion pass during Deep-Plan. One lock, then the contract judges — during research the thresholds are proposals, and a proposal may never present itself as a verdict.
