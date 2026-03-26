# Daffy HTTP Donation Example

A minimal TypeScript example that calls the [Daffy API](https://docs.daffy.org) directly via HTTP to search non-profits, check your balance, and create a donation.

## Prerequisites

- Node.js v18+ (uses built-in `fetch`)
- A Daffy API key from [daffy.org/settings/developers](https://www.daffy.org/settings/developers)

## Setup

1. Install dependencies:

   ```bash
   npm install
   ```

2. Set your API key:

   ```bash
   export DAFFY_API_KEY="your-key"
   ```

3. Run the example:

   ```bash
   npm start
   ```

   This runs the "donate by name" workflow: searches for a non-profit, checks your balance, and creates a $10 donation.

   You can pass a custom search query and amount:

   ```bash
   npm start -- "doctors without borders" 25
   ```

## What's in the box

- **`src/daffy.ts`** — Thin API client wrapping `fetch` with typed methods for search, balance, donate, cancel, and list donations.
- **`src/index.ts`** — Demo script that runs a search-then-donate workflow.

## API endpoints used

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/v1/non_profits?query=` | Search non-profits |
| GET | `/v1/non_profits/:ein` | Get non-profit by EIN |
| GET | `/v1/users/me/balance` | Check fund balance |
| GET | `/v1/donations?page=` | List donations |
| POST | `/v1/donations` | Create a donation |
| DELETE | `/v1/donations/:id` | Cancel a donation |

All requests use `X-Api-Key` header for authentication. Base URL: `https://public.daffy.org`.

See the [agents documentation](https://docs.daffy.org/agents) for more details and the companion [skill file](../../skills/daffy-donation/).
