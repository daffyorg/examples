import type { DataFunctionArgs } from "@remix-run/node";
import { auth } from "~/auth.server";
import { ENV } from "~/env.server";

export async function action({ request }: DataFunctionArgs) {
  let redirectTo = new URL("https://dev-frs26tq5.us.auth0.com/v2/logout");
  redirectTo.searchParams.set("returnTo", "http://localhost:3000");
  redirectTo.searchParams.set("client_id", ENV.DAFFY_CLIENT_ID);

  return await auth.logout(request, { redirectTo: redirectTo.toString() });
}
