const BASE_URL = "https://public.daffy.org";

export class ApiError extends Error {
  constructor(
    public status: number,
    public body: string,
  ) {
    super(`API error ${status}: ${body}`);
    this.name = "ApiError";
  }
}

export interface NonProfit {
  ein: string;
  name: string;
  website: string;
  city: string;
  state: string;
  logo: string;
  cause: { id: number; name: string };
}

export interface Balance {
  amount: number;
  pending_deposit_balance: number;
  portfolio_balance: number;
  available_balance: number;
}

export interface Donation {
  id: number;
  amount: number;
  status: string;
  note: string;
  created_at: string;
  non_profit: { ein: string; name: string };
}

export interface PaginatedResponse<T> {
  items: T[];
  meta: { count: number; page: number; last: number };
}

export class DaffyClient {
  private apiKey: string;

  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }

  private async request(
    method: string,
    path: string,
    body?: Record<string, unknown>,
  ): Promise<unknown> {
    const headers: Record<string, string> = {
      "X-Api-Key": this.apiKey,
      Accept: "application/json",
    };

    const init: RequestInit = { method, headers };

    if (body) {
      headers["Content-Type"] = "application/json";
      init.body = JSON.stringify(body);
    }

    const res = await fetch(`${BASE_URL}${path}`, init);

    if (!res.ok) {
      const text = await res.text();
      throw new ApiError(res.status, text);
    }

    const text = await res.text();
    if (!text) return {};
    return JSON.parse(text);
  }

  async searchNonProfits(
    query: string,
    page = 1,
  ): Promise<PaginatedResponse<NonProfit>> {
    const params = new URLSearchParams({ query, page: String(page) });
    return this.request("GET", `/v1/non_profits?${params}`) as Promise<
      PaginatedResponse<NonProfit>
    >;
  }

  async getNonProfit(ein: string): Promise<NonProfit> {
    return this.request("GET", `/v1/non_profits/${ein}`) as Promise<NonProfit>;
  }

  async getBalance(): Promise<Balance> {
    return this.request("GET", "/v1/users/me/balance") as Promise<Balance>;
  }

  async donate(
    ein: string,
    amount: number,
    note?: string,
  ): Promise<Donation> {
    const body: Record<string, unknown> = { ein, amount };
    if (note) body.note = note;
    return this.request("POST", "/v1/donations", body) as Promise<Donation>;
  }

  async cancelDonation(id: number): Promise<unknown> {
    return this.request("DELETE", `/v1/donations/${id}`);
  }

  async listDonations(
    page = 1,
  ): Promise<PaginatedResponse<Donation>> {
    return this.request("GET", `/v1/donations?page=${page}`) as Promise<
      PaginatedResponse<Donation>
    >;
  }
}
