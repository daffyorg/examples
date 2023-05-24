import type { DataFunctionArgs } from "@remix-run/node";
import { auth } from "~/auth.server";

export async function loader({ request }: DataFunctionArgs) {
  return await auth.authenticate("daffy", request, {
    successRedirect: "/",
    failureRedirect: "/",
  });
}
