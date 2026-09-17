# chaos-skill

A personal collection of two skills for working with AI.

| Skill | Purpose |
| --- | --- |
| [work-with-chaos](skills/work-with-chaos/SKILL.md) | Run a structured workflow from planning and research through decisions, implementation, review, and reporting. |
| [diagnose-linux-disk](skills/diagnose-linux-disk/SKILL.md) | Reconcile Linux disk usage: df versus du, Docker storage, open deleted files, covered mounts, and filesystem accounting. |

## The two skills

### work-with-chaos

Turn requirements into deliverable tasks with stable IDs, code anchors, real dependencies, and observable completion evidence. A canonical plan records scope and acceptance; STATUS.md records the active phase, revision, approval, and next action. The workflow preserves ordered steps, revalidates affected tasks when requirements change, and keeps implementation behind explicit plan approval.

Read the [planning guide](skills/work-with-chaos/references/planning.md), [plan template](skills/work-with-chaos/references/plan-template.md), [workflow overview](docs/work-with-chaos.md), or [design decisions](docs/adr/). Benchmark, decide, input-gate, and report remain internal guides. External matt-pocock integrations can be used when installed; the bundled procedures also work without them.

### diagnose-linux-disk

Find where Linux disk space is allocated and state how much remains unexplained. The skill distinguishes physical allocation from logical file size, avoids counting Docker data or open file descriptors twice, and identifies coverage gaps before suggesting cleanup.

Read the [entrypoint](skills/diagnose-linux-disk/SKILL.md) and [storage-layer guide](skills/diagnose-linux-disk/references/storage-layers.md). This skill works independently of the work-with-chaos pipeline.

## Installation

The Claude plugin and marketplace are named chaos-skill. The commands below use the current GitHub repository URL; the requested repository rename to chaos-skill is a separate Settings action.

### Claude Code plugin

```bash
claude plugin marketplace add ChaosAIVision/work-with-chaos
claude plugin install chaos-skill@chaos-skill --scope user
```

Invoke either skill:

```text
/chaos-skill:work-with-chaos
/chaos-skill:diagnose-linux-disk
```

### Flat skill names

```bash
git clone https://github.com/ChaosAIVision/work-with-chaos.git chaos-skill
./chaos-skill/scripts/setup-symlinks.sh
```

The installer creates /work-with-chaos and /diagnose-linux-disk. It preserves real directories, can be rerun after pulling changes, and removes obsolete helper symlinks only when they point into this checkout. Set CHAOS_SKILLS_TARGET_DIR to choose a different installation directory.

Each folder under skills/ contains its own SKILL.md and resources and can also be used with a compatible skill loader.

## Upgrading from the previous layout

The old collection exposed benchmark, decide, input-gate, and report as separate skills. Their instructions now live under work-with-chaos/references/; request those modes through work-with-chaos.

For a previous plugin installation, switch from work-with-chaos@work-with-chaos to chaos-skill@chaos-skill. For the symlink installation, rerun scripts/setup-symlinks.sh from the updated checkout. See [ADR-0005](docs/adr/0005-two-top-level-skills.md) for the packaging decision.

## Layout

| Path | Contents |
| --- | --- |
| skills/work-with-chaos/ | Workflow entrypoint, internal guides, and templates |
| skills/diagnose-linux-disk/ | Disk diagnosis entrypoint, storage guide, and UI metadata |
| .claude-plugin/ | Collection plugin and marketplace metadata |
| scripts/setup-symlinks.sh | Installer for the two top-level skills |
| docs/ | Workflow overview and design decisions |
