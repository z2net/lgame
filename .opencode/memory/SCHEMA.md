# Memory schemas (.opencode/memory/)

Append-only JSONL. One JSON object per line. English only.

## index.jsonl — durable facts and decisions
{"ts":"<ISO8601>","session":"<id>","kind":"decision|fact|pattern","key":"<short-key>","value":"<text>"}

## history.jsonl — what was done (orchestrator writes this)
{"ts":"<ISO8601>","session":"<id>","actor":"<agent-id>","action":"<subtask>","result":"done|failed|need-clarification","detail":"<one line>"}

## note.jsonl — free-form observations
{"ts":"<ISO8601>","session":"<id>","note":"<text>"}

## qas.jsonl — FAQ, important information (outranks note.jsonl)
{"ts":"<ISO8601>","session":"<id>","faq":"<important fact or rule>"}
May duplicate note.jsonl content. On conflict, FAQ wins. Readers check FAQ before notes.

Rules: never rewrite history lines, only append. Keep values short.
