# lgame

Launcher: Tauri v2 (Rust) + Vue 3 + TypeScript. Runtime and package manager is bun, exclusively.

## Structure

```
src/                  # Vue client, layers top to bottom
  app/                # App.vue, main.ts, router, styles
  pages/ widgets/ features/ shared/
src-tauri/            # Rust backend (crate lgame_lib, edition 2024)
  src/ capabilities/ tauri.conf.json
.opencode/
  agents/             # 23 subagents, entry point is orchestrator
  skills/             # project skills (vue, pinia, tauri-v2, antislop family, ...)
  memory/             # index/history/note.jsonl + qas.jsonl (FAQ, outranks note)
  codestyle/          # codestyle split by file
  scripts/edit-score.sh  # RICE calculator, signal only, never a verdict
```

## Rules

1. Bun only. No Node/npm ecosystem in this project.
2. Imports in `src/` point down the layers only: app → pages → widgets → features → shared. Never upward.
3. `src-tauri/` is touched by app agents only, `src/` by client agents only. Contract checks are tester-api.
4. Skills live only in `.opencode/skills/`. The skills CLI drops installs into `.agents/skills/` — move them to `.opencode/skills/` immediately and delete `.agents/`. Never keep two copies. `skills-lock.json` stays at root because the CLI requires it there.

## Subagents

This file is the project mini-map. Every subagent reads it at session start,
then follows `.opencode/codestyle/` for code rules. Core rules for all subagents:

1. Never fabricate, never guess. Unsure means ask up and stop.
2. Unknown API means query context7 first (resolve-library-id, then query-docs).
3. One subagent, one task. Never leave the area of responsibility.
4. Malformed task goes back up with NEED-CLARIFICATION, then the agent stops. No improvising.
5. Use `.opencode/memory` when needed. Schema in `.opencode/memory/SCHEMA.md`.
6. No sycophancy. Report facts, including bad news.
7. English only, even if the task is Russian.
8. Memory writes are English only.

## Git

- `main` is protected. No direct commits, only merges from `dev/main`.
- Integration branch is `dev/main` (current working branch).
- Features branch off `dev/main` as `dev/<feature-name>` and merge back into `dev/main` first.
- Only `dev/main` merges into `main`.

Commits (`type(scope): description`, imperative, max 72 chars):

```bash
feat(api): add greet command validation
```

- One commit is one intent. Refactor and feature never mix.
- Body explains why, never what. `git diff` already shows what.
- Before commit: `git diff --staged` contains only the task, project checks are green,
  no debug logs, no commented-out code, never `.env` or secrets.
- Forbidden: `--no-verify` on failing hooks, `git commit -a`, rewriting someone else's history
  (`push --force` only on your own branch, with `--force-with-lease`).
- Before push: green checks, commits ordered refactor-before-feature, messages read as history.

## Commands

```bash
bun run dev       # vite dev server
bun run build     # vue-tsc --noEmit && vite build
bun run preview   # vite preview
bun run tauri     # tauri cli
cargo check       # from src-tauri/
cargo test        # from src-tauri/
```

## Decisions

| Topic         | Decision                               | Why                                      |
| ------------- | -------------------------------------- | ---------------------------------------- |
| Runtime       | bun, exclusively                       | owner decision                           |
| TS            | strict + noUnusedLocals/Parameters     | enforced by tsconfig.json                |
| Rust          | edition 2024, `?` over unwrap in lib   | checked with cargo                       |
| Client layers | FSD: app/pages/widgets/features/shared | layer isolation, dependencies point down |
| FAQ           | qas.jsonl outranks note.jsonl          | owner decision                           |
| Idea scoring  | RICE + NABC (SCORING.md)               | owner decision                           |

## Do not touch

- `node_modules/`, `src-tauri/target/`, `dist/`, `build/`, `.env`
