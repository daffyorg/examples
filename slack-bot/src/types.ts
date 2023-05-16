/**
 * Represents a non-profit organization.
 */
export interface NonProfit {
  id: number;
  ein: string;
  name: string;
  logo?: string;
  website?: string;
  city?: string;
  state?: string;
  latitude?: number;
  longitude?: number;
  public_path: string;
  public_url: string;
  causes: Cause[];
  primary_cause?: Cause;
}

/**
 * Represents a cause supported by a non-profit.
 */
export interface Cause {
  id: number;
  name: string;
  color?: string;
  image_url?: string;
  image_url_dark?: string;
  logo?: string;
}

/**
 * Represents a gift made to a non-profit.
 */
export interface Gift {
  amount: number;
  claimed: boolean;
  code: string;
  created_at: string;
  ein?: string;
  message?: string;
  name: string;
  seen: boolean;
  status: string;
  updated_at: string;
  url: string;
}