# Daffy Donation Skill

A [Claude Code skill](https://code.claude.com/docs/en/skills) that teaches AI agents how to operate a Daffy account through `daffy-cli`.

## What it does

Drop `SKILL.md` into your agent's workspace and it will know how to:

- Search non-profits and look up EIN details
- Check fund balances
- Create and cancel donations
- Send gifts
- Handle pagination, disambiguation, and error recovery

## Setup

1. Get an API key from [daffy.org/settings/developers](https://www.daffy.org/settings/developers).

2. Save your key:

   ```bash
   mkdir -p ~/.daffy && echo 'DAFFY_API_KEY=your-key' > ~/.daffy/credentials
   ```

3. Copy `SKILL.md` into your project root (or any directory your agent can see).

## Usage

The skill activates automatically when a user asks to interact with their Daffy account. All commands run through `npx daffy-cli` — no additional dependencies required.

See the [agents documentation](https://docs.daffy.org/agents) for more details.
