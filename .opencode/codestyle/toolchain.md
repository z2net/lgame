# Toolchain

- Runtime and package manager is bun, exclusively.
- Rust: edition 2024, formatted with `cargo fmt`.
- TypeScript: `strict`, `noUnusedLocals`, `noUnusedParameters` (tsconfig.json, enforced).
- Linter: oxlint is a devDependency, not yet wired to a script. Do not invent lint commands.
- Checks that exist: `bun run build` (vue-tsc --noEmit + vite build), `cargo check` / `cargo test` in src-tauri/.
- No test runner is configured yet. Do not claim tests exist.
