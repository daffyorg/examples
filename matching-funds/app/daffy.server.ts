import { z } from "zod";

let BASE_URL = new URL("http://localhost:3000/");

export class DaffyClient {
  private token: string;
  private type: "oauth" | "api-key";

  constructor(token: string) {
    this.token = token;
    if (token.startsWith("daffy_production_")) {
      this.type = "api-key";
    } else {
      this.type = "oauth";
    }
  }

  private get headers() {
    let headers = new Headers({
      Accept: "application/json",
      "Content-Type": "application/json",
    });

    if (this.type === "oauth") headers.set("Authorization", this.token);
    else headers.set("X-Api-Key", this.token);

    return headers;
  }

  async fetchBalance() {
    let response = await fetch(new URL("/v1/users/me/balance", BASE_URL), {
      headers: this.headers,
    });

    if (!response.ok) throw new Error("Failed to fetch balance.");

    let body = await response.json();

    return z.object({ available_balance: z.number() }).parse(body)
      .available_balance;
  }

  async fetchCurrentUser() {
    let response = await fetch(new URL("/v1/users/me", BASE_URL), {
      headers: this.headers,
    });

    if (!response.ok) return null;

    let body = await response.json();

    return z.object({ id: z.number(), name: z.string() }).parse(body);
  }

  async fetchNonProfit(ein: string) {
    let response = await fetch(new URL(`/v1/non_profits/${ein}`, BASE_URL), {
      headers: this.headers,
    });

    if (!response.ok) throw new Error("Charity not found");

    let body = await response.json();

    return z.object({ name: z.string() }).parse(body);
  }

  async donate(ein: string, amount: number) {
    let user = await this.fetchCurrentUser();
    if (!user) throw new Error("User not found");

    let response = await fetch(
      new URL(`/v1/users/${user.id}/donations`, BASE_URL),
      {
        method: "POST",
        headers: this.headers,
        body: JSON.stringify({ amount, ein }),
      }
    );

    if (!response.ok) throw new Error("Failed to donate");

    let body = await response.json();

    return z
      .object({ id: z.number(), amount: z.number(), status: z.string() })
      .parse(body);
  }
}
