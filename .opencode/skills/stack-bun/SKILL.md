---
name: stack-bun
description: Правила проекта на bun: node-экосистема запрещена по умолчанию, escape-hatch по прямой фразе пользователя. Читать если есть bun.lock и нет package.json.
compatibility: opencode
---

# Bun: без node-экосистемы

Проект работает на bun. Node — не абсолютный запрет, а запрет **по умолчанию**.

## Правило по умолчанию

Bun — основной рантайм. Не используй и не предлагай:

- `node:` префикс — `node:fs`, `node:path`, `node:os`, `node:crypto`, `node:util`
- `require()` — CommonJS. Только ESM
- `npm`, `npx`, `yarn`, `pnpm`
- `node_modules` как путь импорта
- `__dirname`, `__filename` — нет в ESM. В bun: `import.meta.dir`
- `.cjs` с `module.exports`

## Escape hatch

Если пользователь **прямо говорит**, что npm/node можно — используй. Например:
«здесь можно npm» или «добавь пакет через npm».

Это разрешение действует в рамках текущей задачи. Не переноси его
на следующие задачи молча — если node снова понадобится, спроси заново.

Если разрешения не было и неясно — **спроси**. Не угадывай и не надейся
на то, что «вряд ли это запрещено».

## Что использовать вместо

| Нужно | Node | Bun |
|-------|------|-----|
| Файлы | `node:fs/promises` | `Bun.file`, `Bun.write` |
| Пути | `node:path` | `Bun.path`, `import.meta.dir` |
| Env | `node:process` | `Bun.env` |
| Сеть | `node:http` | `Bun.serve`, `fetch` |
| Субпроцесс | `node:child_process` | `Bun.spawn` |
| Shell | `child_process.exec` | `Bun.$` |
| Crypto | `node:crypto` | `Bun.CryptoHasher`, WebCrypto |
| Тесты | `node --test` | `bun test` |

Перед тем как взять node-API, проверь: у bun есть свой. Обычно есть.

## Инструменты

- `bun install` вместо `npm install`
- `bunx` вместо `npx`
- `bun run <script>` вместо `npm run <script>`
- `bun test` вместо `node --test`
- `bun --bun` если запускаешь инструмент, иначе возьмёт node

## node_modules и target

Не читай вручную и не правь. Типы, сборка и тесты работают через
команды (`bun run typecheck`, `bun test`) — это разрешено. Запрещено
полезть руками в `node_modules/`, чтобы найти сигнатуру.

## Проверка

Перед коммитом убедись, что в diff нет `node:`, `require(`, `npm `, `npx ` —
если только пользователь явно не разрешил.
