# Rust (src-tauri/)

- `?` over `unwrap()` and `expect()` in library code. Binary entry points may `expect` with a message.
- New Tauri commands: `#[tauri::command]`, serializable args and return, registered in `generate_handler!`.
- `// SAFETY:` above every `unsafe` block. No `unsafe` without a real reason.
- Errors cross to the UI as values the UI can display. No silent drops (`let _ =` on a Result is forbidden).
