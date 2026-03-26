---
name: daffy-api
description: >-
  Use this skill when users ask to operate their Daffy account via daffy-cli:
  search non-profits, look up EIN details, check balances, list
  donations/contributions/gifts, create or cancel donations, or create gifts.
  Require explicit user confirmation before mutating commands (donate, cancel,
  gift create).
---

Use this skill to run Daffy Public API workflows through `daffy-cli`.

## Required environment

- **API key** — users can generate one at https://www.daffy.org/settings/developers
  - Option A (recommended): save to `~/.daffy/credentials` as `DAFFY_API_KEY=your-key`
  - Option B: set `DAFFY_API_KEY` environment variable (takes precedence over credentials file)
- `npx daffy-cli` (or `daffy-cli` if installed globally)

## Required command flags

- Always use `--json` so output is machine-readable.
- Use `--yes` / `-y` only after explicit user confirmation for mutating commands.

## Execution protocol

1. Determine intent first: read-only request vs mutating request.
2. For non-profit names, run `search` first and confirm the exact match before proceeding.
3. Never guess identifiers (`ein`, donation id, gift code, username).
4. For donations:
   - Enforce `amount >= 10`.
   - If amount is omitted, default to `10` and state that default before execution.
5. For gifts:
   - Enforce `amount >= 18`.
   - Do not default a missing gift amount; ask the user.
6. Before mutating commands (`donate`, `cancel`, `gift create`):
   - Get explicit user confirmation.
   - Then run with `--yes --json`.
7. After a mutating command, return the key result fields:
   - `donate`: `id`, `status`, `amount`, `non_profit`, `created_at`
   - `cancel`: `id`, `cancelled`
   - `gift create`: `code`, `status`, `amount`, `url`
8. If the user asks "how much can I donate?" or asks to verify funds, run `balance` and report `available_balance`.

## Pagination

Paginated commands (`donations`, `contributions`, `gifts`, `search`) accept `--page N`.
JSON responses include `meta.count`, `meta.page`, and `meta.last`.
If the user asks for "more" or "all", continue paging until `page == last`.

---

## Commands

### Users

**Get your profile**
```bash
npx daffy-cli me --json
```

**Get user profile by username**
```bash
npx daffy-cli user <USERNAME> --json
```

---

### Balance

**Get your fund balance**
```bash
npx daffy-cli balance --json
```
Use `available_balance` for donation capacity.

---

### Non-Profits

**Search non-profits by name**
```bash
npx daffy-cli search "<SEARCH_TERM>" --json
```
Optional: `--cause <ID>`, `--page <N>`. Returns paginated results with `ein`, `name`, `city`, `state`, `cause`.

Always use this when the user refers to a non-profit by name rather than EIN.

**Get non-profit by EIN**
```bash
npx daffy-cli nonprofit <EIN> --json
```
Returns: `ein`, `name`, `website`, `city`, `state`, `logo`, `cause`, `causes`.

---

### Donations

**List your donations**
```bash
npx daffy-cli donations --json
```
Optional: `--page <N>`. Each item includes `id`, `amount`, `status`, `note`, `visibility`, `created_at`, `non_profit`, `fund`, `user`.

Donation statuses: `scheduled`, `waiting_for_funds`, `approved`, `rejected`, `completed`, `not_completed`, `check_mailed`.

**Create a donation** (requires user confirmation)
```bash
npx daffy-cli donate --ein <EIN> --amount <AMOUNT> --note "<OPTIONAL_NOTE>" --yes --json
```
Required: `--ein`, `--amount` (>= 10). Optional: `--note`.

**Cancel a donation** (requires user confirmation)
```bash
npx daffy-cli cancel <DONATION_ID> --yes --json
```
Only works for donations that haven't been accepted or rejected yet.

---

### Contributions

**List your contributions (deposits)**
```bash
npx daffy-cli contributions --json
```
Optional: `--page <N>`. Each item includes `units`, `type`, `status`, `valuation`, `currency`, `created_at`, `received_at`, `completed_at`.

---

### Causes

**Get causes for your account**
```bash
npx daffy-cli causes --json
```
Returns array of `{ id, name }`. Use `id` as `--cause` filter when searching non-profits.

---

### Gifts

**List your gifts**
```bash
npx daffy-cli gifts --json
```
Optional: `--page <N>`. Each item includes `name`, `amount`, `message`, `code`, `status`, `url`.

**Get gift by code**
```bash
npx daffy-cli gift <CODE> --json
```

**Create a gift** (requires user confirmation)
```bash
npx daffy-cli gift create --name "<RECIPIENT_NAME>" --amount <AMOUNT> --yes --json
```
Required: `--name`, `--amount` (>= 18). Returns the gift with a shareable `url`.

---

## Common workflows

### "Donate to [non-profit name]"
1. `npx daffy-cli search "<name>" --json` to find candidates.
2. Confirm the exact EIN with the user (especially if multiple matches).
3. Optionally check funds: `npx daffy-cli balance --json`.
4. After explicit user confirmation, run:
   `npx daffy-cli donate --ein <EIN> --amount <AMOUNT> --yes --json`.

### "Show my recent donations"
1. Run `npx daffy-cli donations --json`.
2. Summarize by `id`, `amount`, `status`, `non_profit`, `created_at`.

### "Send a gift to [person]"
1. Confirm recipient name and gift amount (`>= 18`).
2. After explicit user confirmation, run:
   `npx daffy-cli gift create --name "<NAME>" --amount <AMOUNT> --yes --json`.
3. Return `code`, `status`, and shareable `url`.

### "How much can I donate?"
1. Run `npx daffy-cli balance --json`.
2. Report `available_balance` directly.

## Disambiguation rules

- If `search` returns multiple plausible non-profits, present up to 5 with `ein`, `name`, `city`, `state` and ask the user to pick one.
- If no results are returned, ask for a refined search term or EIN.
- If the user provides an EIN, skip `search` and use `nonprofit <EIN> --json` to verify details before donation.

## Troubleshooting

- Missing API key:
  - Symptom: `DAFFY_API_KEY is required`.
  - Action: ask user to save their key to `~/.daffy/credentials` (`DAFFY_API_KEY=your-key`) or set the `DAFFY_API_KEY` env var. They can generate a key at https://www.daffy.org/settings/developers.
- API auth or request failures:
  - Symptom: `API Error (<status>): ...`.
  - Action: surface status/body to user and suggest corrective input (identifier, amount, permissions).
- Donation or gift amount rejected:
  - Ensure donation amount is `>= 10`.
  - Ensure gift amount is `>= 18`.
- Insufficient funds or uncertain funds:
  - Run `npx daffy-cli balance --json` and compare against `available_balance`.
