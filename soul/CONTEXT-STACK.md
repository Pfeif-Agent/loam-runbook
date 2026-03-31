# Context Stack

The authority order for all Loam work:

**substrate → spec → plan → issue → code**

Each layer governs the ones below it. When layers conflict, the higher layer wins.

---

| Layer | What lives here |
|---|---|
| **substrate** | The item graph, storage model, and local-first architecture. The foundation everything else builds on. |
| **spec** | Canonical documents defining what things are — Models, Schemas, Topologies, Protocols. |
| **plan** | Scoped build guidance for a milestone or module. How to build a specific slice. |
| **issue** | Bounded work to do. Concrete, action-oriented, implementation-facing. |
| **code** | The implementation. Governed by everything above it. |

Project and milestone are scoping frames, not authority layers.

---

When resolving a conflict or ambiguity, go up the stack. The higher layer wins. If the substrate and a plan disagree, the substrate wins. If a spec and an issue disagree, the spec wins.
