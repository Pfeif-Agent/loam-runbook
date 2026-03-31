# Vocabulary

Canonical terms for Loam. Every term passes four tests:

1. Survives in every context
2. Works in a spoken sentence
3. Works in a ticket title
4. Works in a prompt

---

## Core nouns

**Item** — The primary thing with identity and properties. The unit of the substrate. Not "document", not "record" — Item.

**Snapshot** — A saved, flattened state of an item. The structured form used for projection, transport, and runtime handling. Derived from the item.

**Public Record** — The ATProto-published form of an item. Derived from the item for public presence. Lossy by design — a projection of the full item, not a replacement.

**Graph** — The underlying history-bearing authoring structure of an item. Available for inspection. Not the primary everyday noun.

**Substrate** — The local, Operator-owned environment where items live. Persistent, structured, history-bearing. The soil.

**Atmosphere** — The public web layer. ATProto / the network. Where Public Records go when the Operator publishes.

**Mycelium** — The AI layer. Works in the substrate, on the Operator's items. Does not cross the boundary to the atmosphere without explicit Operator action.

---

## Roles

**Operator** — The architect. Owns and controls the system.

**Mycelium** — The agent. Translates intent into implementation within the substrate.

**Context Engineer** — Linear. Manages the spec and scope.

**Builder** — TSK. The sandboxed implementor.

---

## Schema identity

Schema identity is based on ATProto NSIDs, not a parallel product-specific type grammar.

- Native Loam record types: `garden.pfeif.loam.*` (e.g. `garden.pfeif.loam.snapshot`)
- External standards used directly where sufficient: e.g. `site.standard.document` for public document-shaped records

Do not use slash-form names (e.g. `loam/markdown_note`) as canonical schema IDs.

---

## What not to say

| Avoid | Use instead |
|---|---|
| document (as the default Loam noun) | Item |
| working record / publication record | Snapshot / Public Record |
| user | Operator |
| AI / assistant | Mycelium |
