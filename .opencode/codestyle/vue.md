# Vue (src/)

- `<script setup lang="ts">`, Composition API. No Options API in new code.
- Match existing style: 2-space indent, double quotes, semicolons.
- One component per file. `<template>`, `<script>`, scoped `<style>`; global styles only in app/.
- Layers: app / pages / widgets / features / shared. Imports point down only
  (shared knows nothing of features, features nothing of pages). Never import upward.
- State in pinia stores (features or shared). No prop drilling past two levels.
- Tauri calls via `invoke` from @tauri-apps/api with typed args and return.
