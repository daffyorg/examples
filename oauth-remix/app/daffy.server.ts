import { z } from "zod";

export async function fetchUser(token: string) {
  let response = await fetch("https://api.daffy.org/public/api/v1/users/me", {
    headers: { Authorization: token },
  });

  if (!response.ok) return null;

  let body = await response.json();

  return z.object({ name: z.string() }).parse(body);
}
