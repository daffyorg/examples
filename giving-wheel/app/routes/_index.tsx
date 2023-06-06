import type {ActionFunction, LoaderFunction} from "@remix-run/node";
import SpinningWheel from "~/components/spinning-wheel";
import {json} from "@remix-run/node";
import type {ShouldReloadFunction} from "@remix-run/react";
import { Listbox } from '@headlessui/react'
import { useFetcher, useLoaderData} from "@remix-run/react";
import {commitSession, getSession} from "~/services/session.server";

// todo: user should authenticate
export let loader: LoaderFunction = async ({ request }) => {
    let causesResponse = await fetch(`https://public.daffy.org/public/api/v1/users/${process.env.USER_ID}/causes`, {
        method: "GET",
        headers: {
            "X-Api-Key": process.env.API_KEY,
            "Content-Type": "application/json"
        }
    });
    let session = await getSession(request);
    let cause = Number(session.get("cause") || "");

    let causes = await causesResponse.json();
    if (causes.error) {
        causes = []
    }
    return json({causes: causes, defaultCauseId: cause});
};


export let shouldRevalidate: ShouldReloadFunction = () => {
    return false;
};

export let action: ActionFunction = async ({ request }) => {
    // todo: handle api failures
    let session = await getSession(request);
    let formData = await request.formData();
    switch (formData.get("_action")) {
        case "set-cause":
            let formCause = formData.get("cause")

            session.set("cause", formCause);

            return json(null, {
                headers: { "Set-Cookie": await commitSession(session) },
            });
        case "get-non-profit":
            let cause = session.get("cause");
            let npResponse = await fetch(`https://public.daffy.org/public/api/v1/non_profits?cause_id=${cause || 1}`, {
                method: "GET",
                headers: {
                    "X-Api-Key": process.env.API_KEY,
                    "Content-Type": "application/json"
                }
            });
            let nonProfits = await npResponse.json();
            if (nonProfits.items) {
                let randomIdx = Math.floor(Math.random() * nonProfits.items.length);
                let nonProfit = nonProfits.items[randomIdx]
                return json({nonProfit});
            }
            return json(null);
        case "get-last-donation":
            // for now only handle the case with only 1 page of results
            let donationsResponse = await fetch(`https://public.daffy.org/public/api/v1/users/${process.env.USER_ID}/donations`, {
                method: "GET",
                headers: {
                    "X-Api-Key": process.env.API_KEY,
                    "Content-Type": "application/json"
                }
            });
            let donations = await donationsResponse.json();
            if (donations.items) {
                let lastDonation = donations.items[donations.items.length - 1]
                return json({nonProfit: lastDonation.non_profit, amount: lastDonation.amount});
            }
            return json(null);
        case "donate":
        case "prize-donate":
            let ein = formData.get("ein")
            let amount = formData.get("amount")
            if (!amount || !ein) {
                return json({error: "Amount/EIN cannot be empty"})
            }
            let response = await fetch(`https://public.daffy.org/public/api/v1/users/${process.env.USER_ID}/donations`, {
                method: "POST",
                headers: {
                    "X-Api-Key": process.env.API_KEY,
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    ein,
                    amount
                })
            });
            let donation = await response.json()
            let searchParams = new URLSearchParams({
                charity: donation.non_profit.id,
                step: "confirm",
                amount: donation.amount,
                visibility: "public",
                frequency: "one_time",
            });
            return json({ shareUrl: `https://www.daffy.org/donate?${searchParams}`});
        case "get-donate-url":
            let paramAmount = formData.get("amount")
            let paramNP = formData.get("id")

            let params = new URLSearchParams({
                charity: paramNP,
                step: "confirm",
                amount: paramAmount,
                visibility: "public",
                frequency: "one_time",
            });
            return json({ shareUrl: `https://www.daffy.org/donate?${params}`});
        case "prize-gift":
        case "gift":
            let name = formData.get("name")
            let amountGift = formData.get("amount")
            let giftResponse = await fetch(`https://public.daffy.org/public/api/v1/gifts`, {
                method: "POST",
                headers: {
                    "X-Api-Key": process.env.API_KEY,
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    name,
                    amount: amountGift
                })
            });
            let gift = await giftResponse.json()
            return json({url: gift.url});
        case "get-user":
            let userResponse = await fetch(`https://public.daffy.org/public/api/v1/users/me`, {
                method: "GET",
                headers: {
                    "X-Api-Key": process.env.API_KEY,
                    "Content-Type": "application/json"
                },
            });
            let user = await userResponse.json()
            return json({name: user.name});
        default:
            return json(null);
    }
}

function ListBoxArrow() {
    return (
        <svg width="16" height="12" viewBox="0 0 16 12" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M9.46911 10.4096C8.67726 11.2668 7.32274 11.2668 6.53089 10.4096L0.708853 4.1071C-0.474447 2.82614 0.434096 0.75 2.17796 0.75L13.822 0.750001C15.5659 0.750002 16.4744 2.82614 15.2911 4.1071L9.46911 10.4096Z" fill="#307560"/>
        </svg>
    )
}

export default function Index() {
   let {causes, defaultCauseId} = useLoaderData();
    let fetcher = useFetcher();
    let defaultCause = causes.find(c => c.id === defaultCauseId)

    function updateCause(cause) {
        fetcher.submit(
            { cause: cause.id, _action: "set-cause" },
            {
                method: "POST",
            }
        );
    }

    return (
    <div
        style={{ fontFamily: "system-ui, sans-serif", lineHeight: "1.4", background: "linear-gradient(54deg, rgba(219,234,130,1) 0%, rgba(209,231,224,1) 35%, rgba(255,255,255,1) 100%)" }}
         className="flex min-h-screen gap-20 justify-center items-center py-5 text-neutral-dark"
    >
        <div className="flex flex-col gap-6">
            <div className="max-w-sm space-y-2">
            <h2 className="text-neutral-dark text-sm">Choose a cause</h2>
            <Listbox name="cause" onChange={updateCause} defaultValue={defaultCause}>
                <div className="relative">
                    <Listbox.Button
                        className="flex w-full cursor-default text-left focus:outline-none focus-visible:border-indigo-500 focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75 focus-visible:ring-offset-2 focus-visible:ring-offset-orange-300 text-lg"
                    >
                        {({value}) =>
                            <>
                                <span className="flex-1 truncate bg-green-dark py-2 pl-3 pr-10 text-white rounded-l-2xl">{value.name}</span>
                                <span className="max-w-fit pointer-events-none rounded-r-2xl border-2 border-green-dark py-[14px] px-4">
                                    <ListBoxArrow/>
                                </span>
                            </>
                        }
                    </Listbox.Button>
                    <Listbox.Options className="absolute mt-1 w-full overflow-auto rounded-md bg-white py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                        {causes.map((cause) => (
                            <Listbox.Option key={cause.id} value={cause} className={({ active }) =>
                                `relative cursor-default select-none py-2 pl-3 ${
                                    active ? 'bg-green-light/40 text-green-dark' : 'text-neutral-regular'
                                }`
                            }>
                                {({ selected }) => (
                                    <span
                                        className={`block truncate ${
                                            selected ? 'font-medium' : 'font-normal'
                                        }`}
                                    >
                                    {cause.name}
                                  </span>
                                )}
                            </Listbox.Option>
                        ))}
                    </Listbox.Options>
                </div>
            </Listbox>
            </div>
            <h1 className="text-5xl font-bold text-green-darker">The Giving Wheel</h1>
        </div>
        <SpinningWheel />
    </div>
  );
}
