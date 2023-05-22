import { z } from "zod";

export const ENV = z
  .object({
    DAFFY_API_KEY: z.string(),
    DAFFY_CLIENT_ID: z.string(),
    DAFFY_CLIENT_SECRET: z.string(),
    EIN: z.string().min(9).max(9),
  })
  .parse(process.env);
