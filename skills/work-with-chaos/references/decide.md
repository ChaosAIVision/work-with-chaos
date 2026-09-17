# Decide

Turn a Decision Report's open choices into locked decisions — fast for the human, traceable for the future.

## Axes checklist

Six axes, checked per decision point — **architecture · performance · database · api · security · test**. The checklist is a sweep, not a questionnaire: an axis gets a question only when a *genuine choice* is still open on it. Otherwise record one line — "database: settled by ADR-0004" — and move on. Asking about a settled axis spends the human's focus, which is the resource this whole skill set protects.

## Method

1. **Collect open axes** from the Decision Report's "Open choices" section. Drop any axis whose choice is already locked (existing ADR, `QUALITY-CONTRACT.md` threshold, standing decision). For each dropped axis, the one-liner above goes in the output so the sweep is visible.

2. **Ask only material open questions.** Use the host's question tool when available and respect its actual limits; otherwise ask plainly. Combine related choices when one answer resolves them. Read repository facts before asking and avoid reopening settled requirements. This decision step is distinct from execution approval.
   - Each option carries its trade-off inline, one line, pulled from the Decision Report — the choice and its price visible together.
   - Where an option's performance case rests on a number, the number appears in the option text *with its ladder label* (🟢/🟡/🔴/⚫). An option pitching "fast" on ⚫ evidence says so.
   - Recommended option first, marked "(Recommended)", when research actually supports one; when the evidence is ⚫ across the board, present the options honestly unranked and say why.

3. **Record each closed decision.**
   - Hard to reverse, surprising later, real trade-off → an ADR in `docs/adr/` (`domain-modeling` skill's format: scan for the highest number, increment).
   - Numeric threshold → the matching line in `QUALITY-CONTRACT.md`.
   - Everything else → one line in the ticket or research doc it belongs to. Most decisions are this kind; ADRs stay rare on purpose.

## Quality Contract

Preserve an existing `QUALITY-CONTRACT.md` and apply its relevant thresholds. If the work needs a new measurable performance contract, use the [quality contract template](quality-contract-template.md), ground proposed thresholds in labeled evidence or explicit user requirements, and include them in the plan package for acceptance. Never infer an SLA from a generic stack template. If performance is outside the requested change, record that no new threshold applies; functional acceptance remains mandatory. During research, proposed thresholds cannot present themselves as verdicts.
