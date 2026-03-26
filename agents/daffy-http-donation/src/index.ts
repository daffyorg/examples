import { DaffyClient } from "./daffy.js";

const apiKey = process.env.DAFFY_API_KEY;
if (!apiKey) {
  console.error(
    "DAFFY_API_KEY is required.\n\n" +
      "Set it as an environment variable:\n" +
      '  export DAFFY_API_KEY="your-key"\n\n' +
      "Or save it to ~/.daffy/credentials:\n" +
      "  DAFFY_API_KEY=your-key\n\n" +
      "Get your API key at https://www.daffy.org/settings/developers",
  );
  process.exit(1);
}

const client = new DaffyClient(apiKey);

async function donateByName(name: string, amount: number) {
  // 1. Search for the non-profit
  console.log(`Searching for "${name}"...`);
  const results = await client.searchNonProfits(name);

  if (results.items.length === 0) {
    console.log("No non-profits found.");
    return;
  }

  const match = results.items[0]!;
  console.log(`Found: ${match.name} (EIN: ${match.ein}) — ${match.city}, ${match.state}`);

  // 2. Check balance
  const balance = await client.getBalance();
  console.log(`Available balance: $${balance.available_balance}`);

  if (balance.available_balance < amount) {
    console.log(`Insufficient funds for a $${amount} donation.`);
    return;
  }

  // 3. Create the donation
  console.log(`Donating $${amount} to ${match.name}...`);
  const donation = await client.donate(match.ein, amount);
  console.log(`Donation created — id: ${donation.id}, status: ${donation.status}`);
}

const query = process.argv[2] || "khan academy";
const amount = Number(process.argv[3]) || 10;

donateByName(query, amount).catch((err) => {
  console.error(err);
  process.exit(1);
});
