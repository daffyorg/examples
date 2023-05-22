import { z } from "zod";

const BASE_URL = new URL("https://public.daffy.org/");

export async function fetchUser(token: string) {
  let response = await fetch(new URL("/public/api/v1/users/me", BASE_URL), {
    headers: { Authorization: token },
  });

  if (!response.ok) return null;

  let body = await response.json();

  return z.object({ name: z.string() }).parse(body);
}
