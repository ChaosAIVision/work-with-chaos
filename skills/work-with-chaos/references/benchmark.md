# Benchmark

Produce **labeled evidence** for performance claims. A claim without a label is not evidence — it is a pitch.

## Evidence ladder

Every performance number that leaves this skill carries exactly one label:

- 🟢 **Measured** — run on the real environment, real data, real scale. Method + conditions stated.
- 🟡 **Sandbox** — micro-benchmark in local/docker with synthesized data at realistic scale. Method + conditions stated.
- 🔴 **Cited** — from a primary source (official docs, paper, first-party blog with methodology). Link + applicability conditions stated.
- ⚫ **Unverified** — reasoning only. May back a hunch, never a recommendation.

Two rules bind everything below:

1. **Climb as high as the stakes.** The higher the ladder rung, the more expensive to produce and the more it proves. Match rung to consequence: a one-off script can live on 🔴; a database choice feeding `QUALITY-CONTRACT.md` needs 🟡 minimum, 🟢 where an environment exists.
2. **State conditions or discard the claim.** Numbers travel with their conditions (dataset size, hardware, versions, warm/cold, concurrency) or they do not travel at all.

## Method

### 1. Fix the question

Write the comparison as a measurable question before touching anything: *"Does option A stay under the 100ms query threshold at 1M rows, where option B does not?"* A question that cannot be measured cannot be benchmarked — restate it until it can.

### 2. Choose the rung

Pick the cheapest rung that can answer the question at the stakes it carries (rule 1 above). If only 🔴 is reachable, say so and stop — do not dress a citation up as a measurement.

### 3. Run

**🟡 Sandbox** — the default for pre-decision comparisons:

- Spin up the target stack locally (docker compose, sqlite file, in-process service).
- Synthesize data at realistic scale — the scale at which the contract must hold, not a toy sample. 1M rows when the question is about 1M rows.
- Warm up before timing. Measure cold separately if cold matters, and label which.
- Repeat ≥ 5 runs, report median and spread, not a single run.
- Track what the question asks: wall time, p95, RSS, CPU, cost per 1k calls. Record all conditions.

**🟢 Measured** — same discipline, on the real environment. Note in the output that credentials/environment access was required (the [input-gate guide](input-gate.md) should have confirmed it first).

**🔴 Cited** — only primary sources. Vendor marketing numbers without methodology are ⚫. Record the applicability conditions verbatim: their Postgres 16 on their hardware is not your Postgres 16 on yours until you say both.

### 4. Report

One table per question. Columns: option, result, label, conditions. Under the table, one line per option: the trade-off the number reveals. No unlabeled number anywhere — a number found without a label during review is a defect, treat it like a failing test.
