import {createCookie, createCookieSessionStorage} from "@remix-run/node";


export let sessionCookie = createCookie("session", {
  httpOnly: true,
  sameSite: "lax",
  path: "/",
  maxAge: 60 * 60 * 24 * 7, // 1 week
});

export let sessionStorage = createCookieSessionStorage({ cookie: sessionCookie });

export async function getSession(request: Request) {
  return await sessionStorage.getSession(request.headers.get("Cookie"));
}

export let { commitSession, destroySession } = sessionStorage;
