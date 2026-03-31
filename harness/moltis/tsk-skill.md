# Skill: tsk

Delegate a build task to TSK.

## When to use
When the operator assigns a Linear issue for implementation.

## Invocation
```bash
tsk run --context /tmp/loam-context-{issue-id}.md
```

## Contract
- Input: context brief at `/tmp/loam-context-{issue-id}.md`
- Output: a git branch on `loam-runbook` with a draft PR
- Gates: `make verify` must pass before the PR is opened
- Network: restricted to approved hosts only (see `tsk/tsk.toml`)
