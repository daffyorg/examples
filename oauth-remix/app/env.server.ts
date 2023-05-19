import { z } from "zod";

export const ENV = z
  .object({
    DAFFY_CLIENT_ID: z.string(),
    DAFFY_CLIENT_SECRET: z.string(),
  })
  .parse(process.env);
