# Third-party notices

The root MIT license covers original work contributed to this repository.
It does not relicense third-party material. Copies and adaptations in `codex/`,
`claude/`, and `OpenCode/` retain the licenses and attribution of their sources.
Preserve each skill's license and notice files when copying it independently.

## Impeccable design skills — Apache-2.0

Source: [pbakaus/impeccable](https://github.com/pbakaus/impeccable).
Copyright 2025 Paul Bakaus. The `frontend-design` skill also derives from
[Anthropic's frontend-design skill](https://github.com/anthropics/skills/tree/main/skills/frontend-design),
copyright 2025 Anthropic, PBC.

Applies to `adapt`, `animate`, `arrange`, `audit`, `bolder`, `clarify`, `colorize`,
`critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`,
`onboard`, `optimize`, `overdrive`, `polish`, `quieter`, `teach-impeccable`, and
`typeset`, including their supporting resources, in all three distributions.

Each folder includes `LICENSE.txt` and `NOTICE.md`. The upstream notice and
license were recovered from revision
`e45d6cde1a974d039d52fa7c65910824fd3b2d6c`, the latest upstream revision before
the recorded laptop installation on 2026-03-17. This identifies the notice
source, not a claim that every adapted file matches that revision.

Local adaptations adjust invocation metadata, question tools, project context,
skill references, and resource paths for Codex, Claude Code, and OpenCode.

## GitHub workflow skills — Apache-2.0

`gh-address-comments` and `gh-fix-ci` derive from
[OpenAI's skills](https://github.com/openai/skills).
Their `LICENSE.txt` files are restored from this repository's existing history
and included in all three distributions. Local changes simplify workflows and
adapt tool invocation and helper paths. See each folder's `NOTICE.md`.

## Skill discovery — MIT

`find-skills` comes from [vercel-labs/skills](https://github.com/vercel-labs/skills).
Its upstream `LICENSE.txt` preserves copyright 2026 Vercel, Inc. Local changes
select the target agent explicitly and clarify installation scope.

## Other retained third-party material

- The four `notion-*` skills retain their MIT license files, copyright 2025
  Notion Labs, Inc.
- `code-simplifier` retains its Apache-2.0 license and existing modification
  notice.
- The Codex `.system` snapshot contains upstream Codex material. It is excluded
  from the root MIT license; preserve its bundled licenses and upstream terms.
  It is not part of the Claude or OpenCode skill distributions.

Adding a root license does not establish new redistribution rights for any
third-party material whose upstream terms are not recorded here.
