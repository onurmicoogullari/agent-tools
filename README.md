# agent-tools

A personal collection of reusable skills, specialist agent profiles, and configuration for **Codex**, **Claude Code**, and **OpenCode**. It covers everyday development workflows, backend and platform engineering, interface design, and documentation.

Codex is the source of truth. Claude Code and OpenCode receive adaptations that use each tool's native skill, command, and agent formats.

## Repository structure

```text
.
├── codex/                     # Canonical skills and Codex configuration
│   ├── AGENTS.md              # Personal working instructions
│   ├── agents/                # Five specialist profiles in TOML
│   ├── skills/                # Personal skills and their supporting files
│   │   └── .system/           # Archived Codex system skills; skip installation
│   └── scripts/               # Launchers that select a local Kubernetes configuration
├── claude/                    # Claude Code adaptations
│   ├── CLAUDE.md              # Personal working instructions
│   ├── agents/                # Eight native agent profiles
│   ├── skills/                # Skills with Claude-specific metadata
│   └── settings.json          # Optional settings and plugin preferences
├── OpenCode/                  # OpenCode adaptations (directory name is case-sensitive)
│   ├── AGENTS.md              # Personal working instructions
│   ├── agents/                # Eight native agent profiles
│   ├── skills/                # Skills loaded through OpenCode's skill tool
│   ├── commands/              # Explicit /plan workflow
│   ├── plugin/                # Local Kubernetes configuration plugin
│   ├── opencode.jsonc         # Skill permissions and plugin configuration
│   └── tui*.jsonc             # Terminal interface preferences
├── docs/skill-sync.md         # Adaptation decisions and maintenance guidance
├── LICENSE                   # MIT license for original work
└── THIRD_PARTY.md             # Upstream licenses and attribution
```

Each skill is a directory containing a `SKILL.md` entry point. Some include references, examples, helper scripts, evaluation fixtures, or assets. Copy the whole directory, including any license and notice files.

## What's included

- **Development workflows:** code review, simplification, commits, pull requests, worktrees, CI troubleshooting, and explanations of unfamiliar code.
- **Engineering:** backend services, Go, Rust, Kubernetes/OpenShift, infrastructure as code, developer platforms, security, observability, and reliability.
- **Interface design:** frontend design plus focused workflows for accessibility audits, layout, typography, animation, responsiveness, performance, and polish.
- **Planning and documentation:** implementation plans, design interviews, writing for docs, emails, and messages, diagrams, Azure DevOps work items, and Notion workflows.

Some skills reflect personal team conventions. In particular, review the project and team defaults in `azure-devops-author` before adopting it elsewhere. Integration skills need their corresponding CLI, service connection, or local dependencies; copying a skill does not configure those services.

## Skills and agent profiles

**Skills** provide reusable instructions for a task in the current conversation. **Agent profiles** define a specialist role for delegated work. Interactive planning and questions stay in the main conversation; advisory agents provide focused research, architecture, debugging, or review.

## What goes where

| Capability | Codex | Claude Code | OpenCode |
|---|---|---|---|
| Reusable workflows and subject expertise | Skills | Skills | Skills |
| Explicit `plan` workflow | Skill with source activation rules | `/implementation-plan`, explicit only | `/plan` command |
| Architecture, investigation, research, review | 5 TOML agent profiles | 5 native agent profiles | 5 native subagent profiles |
| Delegated backend, platform, and IaC work | Main-session skills | 3 thin agents preloading the corresponding skills | 3 thin agents loading the corresponding skills |
| Personal instructions | `AGENTS.md` | `CLAUDE.md` | `AGENTS.md` |
| Bundled Codex system skills | Archived under `skills/.system` | Not registered | Not registered |

The current snapshot has **54 Codex skills** (48 personal + 6 system), **48 Claude skills**, and **47 OpenCode skills + 1 command**. Claude and OpenCode each have eight agent profiles. See [adaptation details](docs/skill-sync.md).

Claude's `code-review` skill is named **`engineering-review`** to avoid its bundled `/code-review`; `plan` becomes **`implementation-plan`** to avoid the built-in `/plan` mode command. The workflow content still comes from Codex.

Only create delegated writers when the user explicitly requests subagents. Interactive workflows stay in the main session. Language, Kubernetes, security, reliability, and observability expertise stays in skills so it can help during implementation as well as review.

## Install on another machine

Run the commands for the tools you use from the repository root. They require a POSIX shell and `rsync`, and will overwrite files at matching destinations. **Back up or merge existing skills, profiles, and instruction files first.** Unrelated destination files are not removed.

```sh
# Codex personal skills; leave bundled .system skills to the Codex installation.
mkdir -p ~/.agents/skills ~/.codex/agents
rsync -a --exclude='.system' codex/skills/ ~/.agents/skills/
rsync -a codex/agents/ ~/.codex/agents/
cp codex/AGENTS.md ~/.codex/AGENTS.md

# Claude Code
mkdir -p ~/.claude/skills ~/.claude/agents
rsync -a claude/skills/ ~/.claude/skills/
rsync -a claude/agents/ ~/.claude/agents/
cp claude/CLAUDE.md ~/.claude/CLAUDE.md

# OpenCode (honor XDG_CONFIG_HOME if set)
opencode_dir="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
mkdir -p "$opencode_dir/skills" "$opencode_dir/agents" "$opencode_dir/commands"
rsync -a OpenCode/skills/ "$opencode_dir/skills/"
rsync -a OpenCode/agents/ "$opencode_dir/agents/"
rsync -a OpenCode/commands/ "$opencode_dir/commands/"
cp OpenCode/AGENTS.md "$opencode_dir/AGENTS.md"
```

On an existing installation, review obsolete skills/profiles and duplicate names across discovery paths; additive copies alone cannot remove retired definitions. Preview a specific owned directory with `rsync -an --delete SOURCE/ DEST/` before deciding which local files to retire. OpenCode can also discover `.agents` and `.claude` skills, so check which definition it actually loads when several copies exist.

For OpenCode, also merge these rules from `OpenCode/opencode.jsonc` into the active configuration, preserving its other permissions. They hide shared copies of the explicit-only `plan` skill while leaving the `/plan` command available:

```json
{"permission": {"skill": {"plan": "deny"}}}
```

Keep agent registration in the local Codex configuration consistent with these five profiles. Review settings and plugin dependencies separately before installing them. Configure any additional machine-specific OpenCode plugins locally.

The commands above install skills, agent profiles, commands, and personal instructions. Settings, TUI preferences, plugins, and launch scripts are optional and need separate review. Kubernetes helpers refer to local kubeconfig files; those credentials are not included.

## Source and maintenance

The Codex snapshot combines `~/.agents/skills` and `~/.codex/skills`. Where both contain the same skill, the **whole skill directory from `~/.codex/skills` wins**, including hidden `.system` skills. The agent profiles and personal instructions come from `~/.codex/agents` and `~/.codex/AGENTS.md`. Codex skill compatibility improvements are applied both here and to the matching laptop copies.

Maintenance is manual; there are no synchronization scripts:

1. Update the canonical Codex content and its matching laptop copy.
2. Apply the shared changes to Claude Code and OpenCode, preserving native metadata, commands, and agent behavior.
3. Preserve supporting resources, executable permissions, licenses, and attribution. Remove obsolete definitions deliberately.
4. Check metadata, resource links, skill references, and installation paths. Keep credentials, machine-specific configuration, sessions, caches, and Python bytecode out of the repository.

See [skill and agent adaptation](docs/skill-sync.md) for the exact mappings, permission choices, and official references.

## License

Original work in this repository is licensed under the [MIT License](LICENSE).
Third-party skills and bundled resources retain their upstream licenses and
attribution; the root MIT license does not replace those terms. See
[third-party notices](THIRD_PARTY.md) and the license files in each skill folder.
