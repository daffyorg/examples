import axios from "axios";
import { Gift, NonProfit, NonProfitResponse } from "./types";

// Learn more at https://docs.daffy.org
const apiBaseUrl = "https://public.daffy.org/v1";

export class DaffyClient {
  private apiKey: string;

  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }

  /**
   * Search for non-profit organizations by query.
   * @param {string} query - The search query.
   * @returns {Promise<NonProfit[]>} An array of NonProfit objects.
   */
  async searchNonProfits(query: string): Promise<NonProfit[]> {
    try {
      const response = await axios.get<NonProfitResponse>(
        `${apiBaseUrl}/non_profits`,
        {
          headers: { "X-Api-Key": this.apiKey },
          params: { query },
        }
      );

      // Return the first page of non-profits
      const nonProfits = response.data.items;
      return nonProfits;
    } catch (error) {
      console.error("Error searching for non-profits:", error);
      throw error;
    }
  }

  /**
   * Send a Daffy gift to a user by name.
   * @param {string} name - The name of the recipient.
   * @param {number} amount - The amount of the gift.
   * @returns {Promise<Gift>} The response data from the API.
   */
  async sendGift(name: string, amount: number): Promise<Gift> {
    try {
      const response = await axios.post<Gift>(
        `${apiBaseUrl}/gifts`,
        {
          name,
          amount,
        },
        {
          headers: {
            "X-Api-Key": this.apiKey,
            "Content-Type": "application/json",
          },
        }
      );

      const gift = response.data;
      return gift;
    } catch (error) {
      console.error("Error sending Daffy gift:", error);
      throw error;
    }
  }
}
