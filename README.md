# work-with-chaos

> One pipeline for every task. Evidence on every claim. No session left waiting.

A personal Claude Code skill set for working with AI across many projects without losing focus. Born from a real failure mode: hopping between project tabs, answering "yes, continue" one question at a time, watching sessions die on a missing password — and losing the deep-work zone every time.

The fix isn't more discipline. It's a protocol: the human manages, the AI works a fixed pipeline. Every task, every size, every project — the same shape.

## Why

| The failure | The fix |
|---|---|
| AI finishes Q1, asks permission for Q2, waits | Pipeline phases advance on `STATUS.md`, not on permission |
| Session dies mid-task on a missing credential | Input gate checks *before* work starts; stalled tasks park, sessions move on |
| "AI recommended a query" — 5s, one index away from 400ms | Every performance claim carries an evidence label; unlabeled numbers are defects |
| Requirements unclear → build → feedback → rebuild | Decisions close up front: six-axis sweep, one click per open question |
| Agent slides from research into unrequested code edits | Phase discipline: edits only in phase 5 on the frontier ticket; other phases file Candidate Findings ([ADR-0003](docs/adr/0003-plan-first-no-edits-outside-implement.md)) |
| Plans go stale before implementation | Two-layer planning: thin breadth-plan for the day, deep-plan per project right before its block |

## The pipeline

```
0 Orient    → read STATUS.md, resume where the repo left off
1 Plan      → breadth-plan the day's blocks; deep-plan per project
2 Research  → codebase scan + primary sources, in parallel; benchmark what compares
3 Decide    → six-axis sweep (architecture · performance · database · api · security · test),
              one question per genuinely open axis; lock the Quality Contract
4 Tickets   → tracer-bullet slices with Input / Output / Quality gate / Domino note
5 Implement → input gate → TDD, background edge-case hunt → checkpoint per ticket
6 Review    → standards + spec + performance-vs-contract, in parallel
7 Report    → delivery report: end-to-end flow + per-module IO table + unverified-claims list
```

## Install

This repo is its own plugin marketplace (`"source": "./"`). After pushing to your git host:

```bash
claude plugin marketplace add ChaosAIVision/work-with-chaos
claude plugin install work-with-chaos@work-with-chaos --scope user
```

Update after pushing changes: `claude plugin marketplace update work-with-chaos`.

**Fallback — flat skill names** (`/benchmark` instead of `/work-with-chaos:benchmark`):

```bash
git clone https://github.com/ChaosAIVision/work-with-chaos.git
./work-with-chaos/scripts/setup-symlinks.sh
```

The script is idempotent — re-run after every pull. It never touches a real folder that happens to share a skill's name.

## The skills

| Skill | What it does |
|---|---|
| `work-with-chaos` | The orchestrator: seven phases, `STATUS.md` routing, two-layer planning, phase discipline (code edits only in phase 5; everything else files Candidate Findings) |
| `benchmark` | The evidence ladder — 🟢 measured · 🟡 sandbox · 🔴 cited · ⚫ unverified — and the sandbox method behind 🟡 |
| `decide` | Six-axis sweep; one AskUserQuestion per open axis; ADRs and the Quality Contract lock |
| `input-gate` | Credentials/data/env/access/decisions verified *by doing* before work starts; `BLOCKED.md` + wizard for what only a human can clear |
| `report` | Decision reports (options, trade-offs, labeled evidence) and delivery reports (flow + per-module table) |

## The evidence ladder

Every performance number that leaves this skill set carries exactly one label:

- 🟢 **Measured** — real environment, real data, real scale
- 🟡 **Sandbox** — local/docker micro-benchmark at realistic scale, conditions stated
- 🔴 **Cited** — primary source with methodology, applicability stated
- ⚫ **Unverified** — reasoning only; may back a hunch, never a recommendation

A number found without a label is a defect, treated like a failing test.

## Design rules

1. **Every task, no fast lane** — uniformity is the point; lane assignment is the judgement call this set exists to remove ([ADR-0001](docs/adr/0001-full-pipeline-for-every-task.md))
2. **Wrap, never edit** — matt-pocock skills are called as-is; wrappers add behavior ([ADR-0002](docs/adr/0002-orchestrator-plus-wrappers.md))
3. **Markdown is the source of truth** — HTML is a view; the moment it drifts, it's lying
4. **Stalled tasks park, sessions don't wait** — a failed gate costs one line in a file, not a block of time
5. **Decisions arrive as clicks** — batched AskUserQuestion, trade-offs inline, evidence labels on every number

## Repository layout

```
.claude-plugin/marketplace.json              this repo is its own marketplace
.claude-plugin/plugin.json                   plugin identity
skills/work-with-chaos/SKILL.md              the orchestrator
skills/work-with-chaos/domino-checklist.md   ticket ordering (CHIA–CHỌN–CHUỖI, timvu.vn/fast)
skills/work-with-chaos/quality-contract-template.md  per-stack threshold seeds
skills/benchmark/SKILL.md                    evidence ladder + sandbox method
skills/decide/SKILL.md                       six-axis sweep, contract lock, ADRs
skills/input-gate/SKILL.md                   the anti-stall gate
skills/report/SKILL.md                       decision + delivery report forms
scripts/setup-symlinks.sh                    fallback installer
CONTEXT.md                                   the vocabulary
docs/adr/                                    decisions worth remembering
```

## Vocabulary

`Work Block` · `Stalled Task` · `Input Gate` · `Checkpoint` · `Breadth-Plan` · `Deep-Plan` · `Domino Note` · `Quality Contract` · `Evidence Ladder` · `Decision Report` · `Delivery Report` — defined in [CONTEXT.md](CONTEXT.md).

---

*Built from a grilling session, 2026-08-24. The ADRs remember why.*
