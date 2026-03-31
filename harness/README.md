# harness/

Thin glue layer between Loam's stable sources of truth and the current agent harness (Moltis + TSK).

## What Loam owns (harness-agnostic)

- **The issue** — Linear is the unit of work
- **The context stack** — substrate → spec → plan → issue → code, resolved to `/tmp/loam-context-{issue-id}.md`
- **The backpressure gates** — `make verify` (`cargo fmt`, `clippy`, `check`, `test`)
- **The PR** — a git branch on `loam-runbook` is the output contract
- **Identity** — `soul/` expresses Loam's values, not the harness config

## What the harness owns (lives here)

- How Moltis understands its delegation role (`moltis/`)
- How TSK is configured for this repo (`tsk/`)
- Nothing else

## Connection points

| Input | Format | Owner |
|---|---|---|
| Unit of work | Linear issue ID | Loam |
| Context brief | `/tmp/loam-context-{id}.md` | Loam (Pyramid assembly) |
| Gate sequence | `make verify` | Loam |
| Output | PR on `loam-runbook` | Loam |

When the harness changes, only this directory changes.
