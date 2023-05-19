import { createCookieSessionStorage } from "@remix-run/node";
import { Authenticator } from "remix-auth";
import { Auth0Strategy } from "remix-auth-auth0";
import { ENV } from "./env.server";
import { z } from "zod";

export const sessionStorage = createCookieSessionStorage({
  cookie: {
    name: "session",
    httpOnly: true,
    sameSite: "lax",
    path: "/",
    secrets: ["s3cr3t"],
    secure: process.env.NODE_ENV === "production",
    maxAge: 60 * 60 * 24 * 30, // 30 days
  },
});

export const auth = new Authenticator<string>(sessionStorage, {
  sessionKey: "token",
  throwOnError: true,
});

auth.use(
  new Auth0Strategy(
    {
      clientID: ENV.DAFFY_CLIENT_ID,
      clientSecret: ENV.DAFFY_CLIENT_SECRET,
      domain: "auth.daffy.org",
      callbackURL: "http://localhost:3000/auth/callback",
    },
    async ({ extraParams }) => {
      let token = z.string().parse(extraParams.id_token);
      return `${ENV.DAFFY_CLIENT_ID} ${token}`;
    }
  ),
  "daffy"
);
