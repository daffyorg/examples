import { z } from "zod";

let BASE_URL = new URL("https://public.daffy.org/");

export async function fetchUser(token: string) {
  let response = await fetch(new URL("/public/api/v1/users/me", BASE_URL), {
    headers: { Authorization: token },
  });

  if (!response.ok) return null;

  let body = await response.json();

  return z.object({ id: z.number(), name: z.string() }).parse(body);
}

export async function fetchCharity(token: string, ein: string) {
  let response = await fetch(
    new URL(`/public/api/v1/non_profits/${ein}`, BASE_URL),
    { headers: { "X-Api-Key": token } }
  );

  if (!response.ok) throw new Error("Charity not found");

  let body = await response.json();

  return z.object({ name: z.string() }).parse(body);
}

export async function fetchDonate(token: string, ein: string, amount: number) {
  let user = await fetchUser(token);
  if (!user) throw new Error("User not found");

  let response = await fetch(
    new URL(`/public/api/v1/users/${user.id}/donations`, BASE_URL),
    {
      method: "POST",
      headers: { "Content-Type": "application/json", Authorization: token },
      body: JSON.stringify({ amount, ein }),
    }
  );

  if (!response.ok) throw new Error("Failed to donate");

  let body = await response.json();

  return z
    .object({ id: z.number(), amount: z.number(), status: z.string() })
    .parse(body);
}
