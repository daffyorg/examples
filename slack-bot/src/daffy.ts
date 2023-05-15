import axios, { AxiosResponse } from "axios";
import { NonProfit } from "./types";

// Learn more at https://docs.daffy.org
const apiBaseUrl = "https://api.daffy.org/public/api/v1";

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
      const response: AxiosResponse = await axios.get(
        `${apiBaseUrl}/non_profits`,
        {
          headers: { "X-Api-Key": this.apiKey },
          params: { query },
        }
      );

      return response.data.items;
    } catch (error) {
      console.error("Error searching for non-profits:", error);
      throw error;
    }
  }

  /**
   * Send a Daffy gift to a user by name.
   * @param {string} name - The name of the recipient.
   * @param {number} amount - The amount of the gift.
   * @returns {Promise<any>} The response data from the API.
   */
  async sendGift(name: string, amount: number): Promise<any> {
    try {
      const response: AxiosResponse = await axios.post(
        `${apiBaseUrl}/gifts`,
        {
          name,
          amount,
        },
        {
          headers: { "X-Api-Key": this.apiKey },
        }
      );

      return response.data;
    } catch (error) {
      console.error("Error sending Daffy gift:", error);
      throw error;
    }
  }
}
