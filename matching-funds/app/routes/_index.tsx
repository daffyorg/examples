import type { DataFunctionArgs, V2_MetaFunction } from "@remix-run/node";
import { json, redirect } from "@remix-run/node";
import { Form, useLoaderData } from "@remix-run/react";
import { z } from "zod";
import { auth, sessionStorage } from "~/auth.server";
import { DaffyClient } from "~/daffy.server";
import { ENV } from "~/env.server";

export const meta: V2_MetaFunction = () => {
  return [{ title: "Matching Campaign" }];
};

export async function loader({ request }: DataFunctionArgs) {
  let client = new DaffyClient(ENV.DAFFY_API_KEY);
  let balance = await client.fetchBalance();
  let nonProfit = await client.fetchNonProfit(ENV.EIN);

  let session = await sessionStorage.getSession(request.headers.get("Cookie"));

  let { success, error } = z
    .object({
      success: z.number().optional(),
      error: z.string().optional(),
    })
    .parse({
      success: session.get("success"),
      error: session.get("error"),
    });

  return json({ balance, nonProfit, success, error });
}

export async function action({ request }: DataFunctionArgs) {
  let myClient = new DaffyClient(ENV.DAFFY_API_KEY);
  let balance = await myClient.fetchBalance();

  let token = await auth.isAuthenticated(request);

  let formData = await request.formData();

  let amount = z.coerce
    .number()
    .min(18)
    .max(balance)
    .parse(formData.get("amount"));

  let session = await sessionStorage.getSession(request.headers.get("Cookie"));

  if (!token) {
    session.flash("amount", amount);
    return redirect("/auth", {
      headers: { "Set-Cookie": await sessionStorage.commitSession(session) },
    });
  }

  let userClient = new DaffyClient(token);

  try {
    await Promise.all([
      userClient.donate(ENV.EIN, amount),
      myClient.donate(ENV.EIN, amount),
    ]);

    session.flash("success", amount * 2);
  } catch (error) {
    if (error instanceof Error) session.flash("error", error.message);
    console.error(error);
  }

  return redirect("/", {
    headers: { "Set-Cookie": await sessionStorage.commitSession(session) },
  });
}

export default function Index() {
  let { nonProfit, balance, success, error } = useLoaderData<typeof loader>();

  return (
    <div style={{ fontFamily: "system-ui, sans-serif", lineHeight: "1.4" }}>
      <h1>Matching campaign</h1>

      <p>
        For every donation to {nonProfit.name} I'll donate the same amount until
        I get out of funds in my Daffy account.
      </p>

      <p>
        {balance.toLocaleString("en-US", {
          style: "currency",
          currency: "USD",
        })}{" "}
        left in my Daffy account.
      </p>

      <Form method="post">
        {success && (
          <p>
            Thanks to you {nonProfit.name} will now receive{" "}
            {success.toLocaleString("en-US", {
              style: "currency",
              currency: "USD",
            })}
          </p>
        )}

        {error && <p>{error}</p>}
        <label htmlFor="amount">How much do you want to give?</label>
        <input
          id="amount"
          type="number"
          name="amount"
          placeholder="Amount"
          min={18}
          defaultValue={25}
          step={1}
          max={balance}
        />
        <button>Donate</button>
      </Form>
    </div>
  );
}
