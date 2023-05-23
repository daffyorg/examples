import React, { useEffect, useState } from "react";
import { DaffyAPI } from "../daffy";
import { ReadyState } from "./Committed";
import { Configure } from "./Configure";

let ApiKeyStorage = {
  storeKey: async function (key: string) {
    await chrome.storage.local.set({ apiKey: key });
    console.log("API Key is set to " + key);
    return key;
  },

  readKey: async function (): Promise<string | undefined> {
    return new Promise((resolve) => {
      chrome.storage.local.get(["apiKey"], (result) => {
        console.log("API Key currently is " + result.apiKey);
        resolve(result.apiKey);
      });
    });
  },

  clearKey: async function () {
    await chrome.storage.local.set({ apiKey: "" });
    console.log("API Key is cleared");
  },
};

export const Home = () => {
  type Status = "loading" | "configure" | "ready";
  const [status, setStatus] = useState<Status>("loading");
  const [committedAmount, setCommittedAmount] = useState<number | undefined>();

  useEffect(() => {
    // load api key if stored
    ApiKeyStorage.readKey().then((key) => {
      if (key) {
        setStatus("ready");
        // Fetch the committed amount
        DaffyAPI.getCommittedAmount(key).then((data) => {
          console.log("Data loaded", data);
          setCommittedAmount(data.committed_amount);
        });
      } else {
        setStatus("configure");
      }
    });
  }, []);

  switch (status) {
    case "loading":
      return <p>Loading...</p>;
    case "configure":
      return <Configure />;
    case "ready":
      return <ReadyState committedAmount={committedAmount} />;
  }
};
