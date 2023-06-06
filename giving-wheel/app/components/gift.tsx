import { Transition, Dialog } from "@headlessui/react";
import React, {Fragment} from "react";
import {useFetcher} from "@remix-run/react";
import Loading from "~/components/loading";

export default function Gift({onClose = () => {}}) {
    let fetcher = useFetcher();

    return (
        <Transition appear show as={Fragment}>
            <Dialog
                as="div"
                className="fixed inset-0 z-50 bg-neutral-800 bg-opacity-60 min-h-screen min-h-screen-ios overflow-y-auto overflow-x-hidden"
                onClose={onClose}
            >
                <div className="flex min-h-full items-baseline justify-center -md:items-end">
                    <Transition.Child
                        as={Fragment}
                        enter="ease-out duration-300"
                        enterFrom="opacity-0 scale-95"
                        enterTo="opacity-100 scale-100"
                        leave="ease-in duration-200"
                        leaveFrom="opacity-100 scale-100"
                        leaveTo="opacity-0 scale-95"
                    >
                        <Dialog.Panel>
                            <fetcher.Form method="POST" className="space-y-4 flex flex-col mt-10 md:my-20 -md:w-full bg-white md:w-[568px] md:rounded-xl px-5 pt-6 pb-8 md:p-[60px] md:pt-12 rounded-t-lg transition-all transform overflow-hidden">
                                <h2 className="text-3xl font-medium">The Gift of Giving</h2>
                                <input hidden defaultValue="gift" name="_action"/>
                                <div className="flex items-center gap-2">
                                    <p>Name</p>
                                    <input name="name" className="border p-2 rounded-md"/>
                                </div><div className="flex items-center gap-2">
                                    <p>Amount $</p>
                                    <input name="amount" className="border p-2 rounded-md" defaultValue={20} type="number" min="18"/>
                                </div>
                                <div className="flex items-center gap-3">
                                    <button className="p-2 border rounded-md flex-1" onClick={onClose}>Cancel</button>
                                    <button type="submit" className="p-2 border text-white rounded-md flex-1 bg-green-dark">Gift</button>
                                </div>
                                {fetcher.state !== "idle" && <Loading/>}
                                {!!fetcher?.data?.url &&
                                    <div>
                                        <p>Share your gift</p>
                                        <p className="select-all whitespace-nowrap overflow-hidden text-ellipsis">{fetcher.data.url}</p>
                                    </div>
                                }
                            </fetcher.Form>
                        </Dialog.Panel>
                    </Transition.Child>
                </div>
            </Dialog>
        </Transition>
    );
}