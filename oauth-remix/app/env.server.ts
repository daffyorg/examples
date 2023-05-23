import { z } from "zod";

export const ENV = z
  .object({
    DAFFY_CLIENT_ID: z.string(),
    DAFFY_CLIENT_SECRET: z.string(),
    PUBLIC_HOST: z.string().url(),
  })
  .parse(process.env);
