# prompt-library

A personal collection of reusable Claude Code prompt shortcuts for common engineering workflows.

## Prompts

| Command | Purpose |
|---------|---------|
| `/p1` | **Split a New Ticket** — Break down a ticket into well-scoped sub-tasks |
| `/p2` | **Simplify Current Solution** — Analyze a solution and suggest simplifications |
| `/p3` | **Criticize the Solution** — Review a ticket or solution with constructive critique and a score |
| `/p4` | **Solution Architect: Overall Risk Analysis** — Analyze architectural risks and trade-offs |
| `/p5` | **Write Functions Step by Step** — Implement functions methodically with clear steps |

## Install

### Global (recommended)

Makes all prompts available in every project on your machine:

```bash
git clone https://github.com/taotao19950405/prompt-library.git ~/prompt-library
~/prompt-library/install.sh --global
```

### Per-project

Adds prompts only to the current project (creates `.claude/commands/`):

```bash
~/prompt-library/install.sh
```

### Remove

```bash
# Remove from current project
~/prompt-library/install.sh --remove

# Remove from global
~/prompt-library/install.sh --remove --global
```

## Usage

Inside any Claude Code session, just type the slash command:

```
/p1
/p2
/p3
```

Claude will load the prompt and wait for your input.

## Pipeline usage

For non-interactive / CI use with `--print` mode:

```bash
claude -p "/p1 <ticket text>"
claude -p "/p4 <solution to analyze>"
```

## Adding new prompts

1. Create a `.md` file in this directory, e.g. `p6.md`
2. Start the file with a heading: `# P6 — Your Prompt Name`
3. Write the prompt body
4. Update `promptls.md` to include the new entry
5. Re-run `install.sh` if using per-project mode (global picks it up automatically via symlink)
