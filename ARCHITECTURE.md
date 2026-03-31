# Architecture

This document orients a reader — human or agent — to what Loam is, what it's built on, and how the pieces relate. Read `soul/` for the philosophy behind these decisions.

---

## What Loam is

Loam is a substrate for personal computing in the age of AI.

The substrate is an item graph: every note, task, document, or idea is an item with identity, history, and connections to other items. The Operator owns this graph on their own machine. The Agent works inside it.

This is the vision articulated by Obenauer's itemized OS research and built on the local-first infrastructure pioneered by Ink & Switch — a persistent, structured environment where AI has something real to be situated in, not just a prompt and a response.

---

## The stack

```
Atmosphere (ATProto)
──────────────────────────────
Loam substrate (Rust)
  ├── Automerge   — item storage, history, sync
  └── Keyhive     — end-to-end encryption for the graph
──────────────────────────────
Cosmic DE (Pop_OS)
Open source hardware (Raspberry Pi 4B)
```

### Automerge

Automerge is a CRDT-based storage and sync library. Every change to every item is recorded — no deletes, full history. This gives the substrate branching, diffing, and time-travel for free, without a central server. Concurrent edits on different devices merge correctly by design.

Loam builds its item graph on Automerge documents. The substrate is the soil; Automerge is what makes the soil persistent and alive across devices.

### Keyhive

Keyhive is end-to-end encryption for the item graph. Not just for messages — for everything. Think of it as Signal, but instead of exchanging messages, the Operator and Agent exchange ideas. Capabilities are cryptographic: read and write access to any part of the graph is granted or revoked without a central authority.

The Operator owns the keys. The Agent works within the boundaries the Operator defines.

### Cosmic DE / Pop_OS

Loam runs on open source hardware and a Linux desktop environment. The Operator's machine is the substrate's home — not a cloud server, not a rented instance. Pop_OS with the Cosmic desktop is the chosen environment: local, owned, extensible.

---

## The atmosphere

Loam uses ATProto lexicons as the shared vocabulary between the substrate and the public web. An item in the substrate and a record in the atmosphere are the same thing described the same way.

Publishing is one-way and lossy by design. The substrate holds the full living item — its history, connections, and changesets. The atmosphere receives a snapshot. Like a mushroom fruiting above the surface: real and useful, but a projection of something richer underneath.

The Agent does not cross the boundary. It works in the substrate, on the Operator's items. When something needs to become public, the Operator publishes. That crossing is a deliberate act.

---

## The agent model

The roles in Loam are **Operator** and **Agent**.

The Operator owns and controls the system. They compose, configure, and govern. The Agent translates the Operator's intent into specs, tests, and implementation — architect and builder in one.

In this repo, the Agent receives work as Linear issues, assembles context using the context stack (`soul/CONTEXT-STACK.md`), delegates implementation to TSK, and reports back. See `harness/` for the delegation mechanics.

---

## Repository layout

| Path | What lives here |
|---|---|
| `soul/` | Foundational documents — philosophy, identity, vocabulary, context stack. Read these first. |
| `harness/` | Thin glue layer between Loam's stable contracts and the current agent harness (Moltis + TSK). |
| `harness/moltis/` | How Moltis understands its delegation role. |
| `harness/tsk/` | TSK sandbox and gate configuration. |
| `Makefile` | Backpressure gates — `make verify` runs before any PR opens. |
| `README.md` | Operations guide for running Loam on the Pi. |

---

## Source

Loam source code is hosted on [Tangled](https://tangled.org/) — a self-hostable, AT Protocol-native code forge. The intent is for Tangled to be the canonical home for all Loam repositories.

<!-- TODO: Add direct repo links once Tangled home is established -->
