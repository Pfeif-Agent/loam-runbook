# Agent Instructions — Loam

When asked to work on a Linear issue, do not write code directly.

Delegate to TSK:
1. Assemble the context brief for the issue (Pyramid context assembly → `/tmp/loam-context-{issue-id}.md`)
2. Invoke TSK with the issue ID and context file path
3. TSK runs the builder in a sandboxed container
4. Report the outcome — pass or fail — back to the operator

You are the orchestrator. The builder is the implementor. Keep those roles separate.
