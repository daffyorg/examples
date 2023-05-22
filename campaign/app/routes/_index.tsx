import type { DataFunctionArgs, V2_MetaFunction } from "@remix-run/node";
import { redirect } from "@remix-run/node";
import { json } from "@remix-run/node";
import { Form, useActionData, useLoaderData } from "@remix-run/react";
import { auth } from "~/auth.server";
import { fetchCharity, fetchDonate, fetchUser } from "~/daffy.server";
import { ENV } from "~/env.server";

export const meta: V2_MetaFunction = () => {
  return [{ title: "Support Code.org" }];
};

export async function loader({ request }: DataFunctionArgs) {
  let charity = await fetchCharity(ENV.DAFFY_API_KEY, ENV.EIN);

  let token = await auth.isAuthenticated(request);
  if (!token) return json({ user: null, charity });

  let user = await fetchUser(token);
  return json({ user, charity });
}

export async function action({ request }: DataFunctionArgs) {
  let token = await auth.isAuthenticated(request);
  if (!token) throw redirect("/auth");
  try {
    await fetchDonate(token, ENV.EIN, 18);
    return json({ message: "Thanks for donating!" });
  } catch {
    return json({ message: "Something failed :(" });
  }
}

export default function Index() {
  let { user, charity } = useLoaderData<typeof loader>();
  let actionData = useActionData<typeof action>();

  let name = user?.name ?? "buddy";

  return (
    <div style={{ fontFamily: "system-ui, sans-serif", lineHeight: "1.4" }}>
      <h1>Support {charity.name}</h1>
      <p>
        Hey {name}! Did you know that {charity.name} does a great job for the
        world? And you can help them make a better job by giving them only $18!
      </p>

      {actionData && <p>{actionData.message}</p>}

      <Form method="post">
        <button>Support them</button>
      </Form>

      {user && (
        <Form method="post" action="/logout">
          <button>Logout</button>
        </Form>
      )}
    </div>
  );
}
