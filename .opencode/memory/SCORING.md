# Proposal scoring: RICE + NABC

Single source of truth for evaluating reviewer-memory proposals
(new skill, new/edit agent, codestyle change).
Sources: RICE (Intercom); NABC (SRI International).

## RICE score

Score = (Reach x Impact x Confidence) / Effort. Higher score = higher priority.

- **Reach**: future sessions affected per month. Count similar past cases in
  history.jsonl. Never guess.
- **Impact** per occurrence: 3 massive / 2 high / 1 medium / 0.5 low / 0.25 minimal
  (time saved, errors prevented).
- **Confidence**: 100% high (metrics + evidence) / 80% medium (partial evidence) /
  50% low (mostly estimate). Below 50% = unjustified risk, do not propose.
- **Effort**: builder sessions required, min 0.5.
- Minimum score threshold: TBD by user. Below threshold = do not propose.
- Compute with .opencode/scripts/edit-score.sh. The script output is one signal,
  never the verdict.

## NABC checklist

Every proposal must pass all four letters. Fail on any letter = reject or downgrade.

- **N — Need**: what real, evidenced pain does this close? Cite memory entries.
  Judge the user's actual need, not what is fun to build.
- **A — Approach**: the concrete change (which builder implements it, what file
  changes). Must be actionable step by step.
- **B — Benefits per costs**: concrete savings (time, errors) versus cost of
  implementation and maintenance. Must be measurable.
- **C — Competition**: alternatives (status quo, existing skill, manual habit).
  Why does this proposal beat them? State the advantage explicitly.
