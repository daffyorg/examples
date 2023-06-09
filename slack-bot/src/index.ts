import { App } from "@slack/bolt";
import { config } from "dotenv";
import { DaffyClient } from "./daffy";

config();

const token = process.env.SLACK_BOT_TOKEN;
if (!token) throw new Error("SLACK_BOT_TOKEN is not set.");

const appToken = process.env.SLACK_APP_TOKEN;
if (!appToken) throw new Error("SLACK_APP_TOKEN is not set.");

const app = new App({
  token,
  appToken,
  socketMode: true,
});

const DAFFY_API_KEY = process.env.DAFFY_API_KEY;
if (!DAFFY_API_KEY) throw new Error("DAFFY_API_KEY is not set.");
const daffyClient = new DaffyClient(DAFFY_API_KEY);

const SLACK_USERS_ALLOWED_TO_MANAGE_DAFFY_FUND =
  process.env.SLACK_USERS_ALLOWED_TO_MANAGE_DAFFY_FUND;
if (!SLACK_USERS_ALLOWED_TO_MANAGE_DAFFY_FUND)
  throw new Error("SLACK_USERS_ALLOWED_TO_MANAGE_DAFFY_FUND is not set.");
const daffyUsers = SLACK_USERS_ALLOWED_TO_MANAGE_DAFFY_FUND.split(",");

console.log(
  `Slack users authorized to perform Daffy fund actions: ${daffyUsers}`
);

// Listen for /daffy slash commands
app.command("/daffy", async ({ command, ack, respond }) => {
  console.log(
    `Received /daffy command: ${command.text} from ${command.user_name}`
  );
  await ack();

  const [action, amount, user] = command.text.split(" ");

  // Gift action
  if (action === "gift" && daffyUsers.includes(command.user_name)) {
    const giftAmount = parseInt(amount.replace("$", ""), 10);
    if (isNaN(giftAmount)) {
      await respond("Invalid gift amount. Please enter a valid number.");
      return;
    }

    try {
      const gift = await daffyClient.sendGift(user, giftAmount);
      await respond(
        `Daffy gift of $${giftAmount} sent to ${user}. Claim it here ${gift.url}`
      );
    } catch (error) {
      console.error("Error sending Daffy gift:", error);
      await respond("An error occurred while sending the Daffy gift.");
    }
  } else {
    console.error("You are not authorized to send Daffy gifts.", user);
    await respond(`You are not authorized to send Daffy gifts. ${user}`);
  }
});

// Listen for app mentions
app.event("app_mention", async ({ event, client }) => {
  console.log("Received app_mention event:", event.text);
  const mentionText = event.text.toLowerCase();
  const words = mentionText.split(" ");

  if (words.length < 2) return;

  const command = words[1];
  console.log("Command:", command);

  // Check if the command is a valid command,
  // If not, send a message to the user saying that the command is invalid.
  switch (command) {
    case "search": {
      if (words.length < 2) {
        console.log("No query provided.");
        await client.chat.postMessage({
          channel: event.channel,
          text: "Please provide a query to search for non-profits.",
        });
        return;
      }

      const query = words.slice(2).join(" ");
      console.log("Searching for non-profits with query:", query);
      const nonProfits = await daffyClient.searchNonProfits(query);

      if (nonProfits.length === 0) {
        await client.chat.postMessage({
          channel: event.channel,
          text: `No non-profits found related to '${query}'.`,
        });
      } else {
        await client.chat.postMessage({
          channel: event.channel,
          text: `Here are the non-profits related to '${query}':\n${nonProfits
            .map((nonProfit) => `• ${nonProfit.name} (${nonProfit.public_url})`)
            .join("\n")}`,
        });
      }
      break;
    }

    // Add more cases for other commands here

    default: {
      await client.chat.postMessage({
        channel: event.channel,
        text: "Unknown command. Please try again.",
      });
    }
  }
});

(async () => {
  await app.start(process.env.PORT || 3000);
  console.log("⚡️ :Daffy Slack bot is running!");
})();
