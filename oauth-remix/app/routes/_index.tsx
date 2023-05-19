import type { DataFunctionArgs, V2_MetaFunction } from "@remix-run/node";
import { json } from "@remix-run/node";
import { Form, Link, useLoaderData } from "@remix-run/react";
import { auth } from "~/auth.server";
import { fetchUser } from "~/daffy.server";

export const meta: V2_MetaFunction = () => {
  return [{ title: "Login with Daffy + Remix example" }];
};

export async function loader({ request }: DataFunctionArgs) {
  let token = await auth.isAuthenticated(request);
  if (!token) return json({ user: null });

  let user = await fetchUser(token);
  return json({ user });
}

export default function Index() {
  let { user } = useLoaderData<typeof loader>();

  return (
    <div style={{ fontFamily: "system-ui, sans-serif", lineHeight: "1.4" }}>
      <h1>Welcome, {user?.name ?? "buddy!"}</h1>
      {user ? (
        <Form method="post" action="/logout">
          <button>Leave</button>
        </Form>
      ) : (
        <Link to="auth" reloadDocument>
          Login with Daffy
        </Link>
      )}
    </div>
  );
}
