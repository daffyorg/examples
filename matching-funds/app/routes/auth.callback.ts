import type { DataFunctionArgs } from "@remix-run/node";
import { redirect } from "@remix-run/node";
import { auth, sessionStorage } from "~/auth.server";
import { DaffyClient } from "~/daffy.server";
import { ENV } from "~/env.server";

export async function loader({ request }: DataFunctionArgs) {
  let token = await auth.authenticate("daffy", request, {
    failureRedirect: "/",
  });

  let session = await sessionStorage.getSession(request.headers.get("Cookie"));

  session.set(auth.sessionKey, token);

  let amount = session.get("amount");
  if (amount) {
    let myClient = new DaffyClient(ENV.DAFFY_API_KEY);
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
  }

  return redirect("/", {
    headers: { "Set-Cookie": await sessionStorage.commitSession(session) },
  });
}
