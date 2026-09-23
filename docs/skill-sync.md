# Skill and agent adaptation

## Source policy

The laptop snapshot dated 2026-09-15 is the baseline. Codex compatibility improvements are also applied to the matching laptop skills. `~/.agents/skills` supplies the shared personal skills; `~/.codex/skills` supplies `code-simplifier` and the current system bundle. The latter wins duplicate skill paths, including `skill-creator` and `skill-installer`, without retaining obsolete helpers from the former.

The five Codex agent profiles are `backend-architect`, `platform-architect`, `debugger`, `researcher`, and `reviewer`. The laptop's `AGENTS.md` supplies personal branch naming, worktree rules, response style, and review comment style. Retired repository-only skills, old expert profiles, and the old Claude system-skill copies are removed from active directories.

## Native mappings

- **Skills:** Keep domain standards and repeatable workflows available in the main conversation. Both target tools retain scripts, licenses, examples, and references. Codex UI metadata (`agents/openai.yaml`) is omitted from the native distributions.
- **Codex metadata:** Keep portable frontmatter in `SKILL.md`. Put explicit-only invocation policy in `agents/openai.yaml`; `plan` sets `allow_implicit_invocation: false`. Keep argument guidance in the skill body. Use `$skill-name` for explicit skill references and `AGENTS.md` for persistent project instructions.
- **Claude metadata:** Translate `user-invokable` to `user-invocable`, and argument declarations to `argument-hint` plus documented inputs. Keep automatic discovery except where the source explicitly forbids it. `plan` gets `disable-model-invocation: true`. Rename `plan` to `implementation-plan` and `code-review` to `engineering-review` to avoid built-in command/skill names. Invocation syntax follows the native names.
- **OpenCode commands:** Put the explicit `plan` workflow in `commands/`, with `subtask: false`. The `permission.skill` rules in `opencode/opencode.jsonc` hide any copies discovered in shared `.agents` or `.claude` directories. Merge those rules during installation. Other skills load through OpenCode's `skill` tool.
- **Agent roles:** Convert the five TOML role bodies into native Markdown profiles, remove the Codex harness preamble, and preserve their read-only responsibility. All profiles inherit the configured model instead of pinning a provider or model.
- **Delegated writers:** Backend, platform, and IaC agents are thin entry points to the same skills. Claude preloads the appropriate skill with `skills`; OpenCode explicitly loads it through `skill`. Their descriptions require explicit user delegation. No duplicated implementation playbooks. Writing has no agent: it depends on conversation context a subagent lacks, so the `writer` skill runs in the main session.
- **Review:** The reviewer loads the current `code-review` workflow (`engineering-review` in Claude) for scope, severity, evidence, and output rules. The older general role guidance still covers architecture and design reviews. The lead session owns multi-agent coordination; delegated reviewers do not recursively spawn agents.
- **Interactive work:** Interviews, planning, approvals, and conversation-dependent tasks remain in the main session. Skills do not unconditionally fork or change agent roles.
- **Native integration:** Replace Codex Notion connection instructions with Claude's MCP setup or OpenCode's remote-server configuration and OAuth commands. Treat example Notion tool names as operations to resolve against the actual connection. OpenCode uses `question` and `AGENTS.md`; Claude uses `AskUserQuestion` and `CLAUDE.md`. Codex uses the question mechanism available in the current session. All three fall back to chat when a question tool is unavailable and reuse answers already provided. Codex MCP setup uses current `codex mcp` commands without the retired `rmcp_client` flag.

## Read-only behavior

Claude’s five advisory profiles allow file reading, search, web research, and skill loading; they explicitly exclude shell execution, edits, and nested agents. OpenCode starts with a deny-all tool rule and allows the corresponding inspection tools. Its skill permission map retains the deny rule for shared `plan` skills, and external file access requires permission.

Command execution and live MCP queries belong to the parent session. Advisory agents return the exact commands or queries needed; the parent can collect the evidence within the user’s authorized scope and pass it back. This sacrifices independent shell diagnostics to enforce the advisory role without relying on a parent permission mode. Codex’s original agent profiles retain their native read-only sandbox.

## Codex-only bundle

`imagegen`, `openai-docs`, `plugin-creator`, `review-agent`, `skill-creator`, and `skill-installer` remain complete snapshots under `codex/skills/.system`. They depend on Codex-specific tool contracts, installation paths, packaging, or runtime behavior. They are not blindly exposed to other tools. Their archived scripts and assets are preserved for Codex; no plugin cache is imported.

## Workflow details

- `arrange` and `typeset` link to the shared references in `frontend-design`.
- Design workflows reuse context from the current conversation before starting an onboarding interview.
- `commit` distinguishes a branch-summary message from a message for the exact staged changes in a new commit. Branch inspection includes staged, unstaged, and relevant untracked changes.
- GitHub helper examples use Python 3; Claude resolves bundled helpers with `${CLAUDE_SKILL_DIR}`.
- `find-skills` targets the current agent explicitly and respects project versus user installation scope.
- `create-worktree` exists only for Claude Code and OpenCode. The Codex app and CLI manage their own worktrees, and a skill that creates sibling worktrees conflicts with their sandbox and their review, commit, and PR features. Codex gets the branch naming and worktree rules through `AGENTS.md` instead.

## Maintenance checks

After a manual update, compare the Codex snapshot with the source directories, including supporting files and executable bits. Check that each personal skill has a corresponding native skill or command, that renamed skills are referenced correctly by agent profiles, and that retired definitions have been removed.

Validate changed YAML and TOML metadata, relative resource links, invocation rules, and tool-specific integration instructions. File checks do not establish that live MCP connections or model workflows function correctly.

## Official references

The native format decisions were checked against these pages on 2026-09-15:

- [Codex skills](https://developers.openai.com/codex/skills/)
- [Claude Code skills](https://code.claude.com/docs/en/skills)
- [Claude Code built-in commands](https://code.claude.com/docs/en/commands)
- [Claude Code subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code MCP](https://code.claude.com/docs/en/mcp)
- [OpenCode skills](https://opencode.ai/docs/skills/)
- [OpenCode agents](https://opencode.ai/docs/agents/)
- [OpenCode permissions](https://opencode.ai/docs/permissions/)
- [Skills CLI agent targeting](https://github.com/vercel-labs/skills)
- [OpenCode commands](https://opencode.ai/docs/commands/)
- [OpenCode MCP servers](https://opencode.ai/docs/mcp-servers/)
