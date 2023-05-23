import { DaffyAPI } from "../daffy";
import { DaffyRequest } from "../types";

export {};
/** Fired when the extension is first installed,
 *  when the extension is updated to a new version,
 *  and when Chrome is updated to a new version. */
chrome.runtime.onInstalled.addListener((details) => {
  console.log("[background.js] onInstalled", details);
});

chrome.runtime.onConnect.addListener((port) => {
  console.log("[background.js] onConnect", port);
});

chrome.runtime.onStartup.addListener(() => {
  console.log("[background.js] onStartup");
});

/**
 *  Sent to the event page just before it is unloaded.
 *  This gives the extension opportunity to do some clean up.
 *  Note that since the page is unloading,
 *  any asynchronous operations started while handling this event
 *  are not guaranteed to complete.
 *  If more activity for the event page occurs before it gets
 *  unloaded the onSuspendCanceled event will
 *  be sent and the page won't be unloaded. */
chrome.runtime.onSuspend.addListener(() => {
  console.log("[background.js] onSuspend");
});

let ApiKeyStorage = {
  storeKey: function (key: string): Promise<string> {
    return new Promise((resolve, reject) => {
      chrome.storage.local.set({ apiKey: key }, () => {
        if (chrome.runtime.lastError) {
          console.error(chrome.runtime.lastError.message);
          reject(chrome.runtime.lastError);
        } else {
          console.log("API Key is set to " + key);
          resolve(key);
        }
      });
    });
  },

  readKey: function (): Promise<string | undefined> {
    return new Promise((resolve) => {
      chrome.storage.local.get(["apiKey"], (result) => {
        console.log("API Key currently is " + result.apiKey);
        resolve(result.apiKey);
      });
    });
  },

  clearKey: function (): Promise<void> {
    return new Promise((resolve, reject) => {
      chrome.storage.local.set({ apiKey: "" }, () => {
        if (chrome.runtime.lastError) {
          console.error(chrome.runtime.lastError.message);
          reject(chrome.runtime.lastError);
        } else {
          console.log("API Key is cleared");
          resolve();
        }
      });
    });
  },
};

const storeApiKey = async (
  sender: chrome.runtime.MessageSender,
  apiKey: string
) => {
  const tabId = sender.tab?.id;

  let storedKey = await ApiKeyStorage.storeKey(apiKey);

  // Send a message to the content script
  if (tabId) {
    chrome.tabs.sendMessage(tabId, {
      msg: "API Key stored",
      total: storedKey,
    });
  }
};

const sendAmount = async (
  sender: chrome.runtime.MessageSender,
  amount: string
) => {
  // Parse the new amount from the request data
  let newAmount = parseFloat(amount);

  // Send this to the committed Daffy endpoint API
  console.log("New amount is " + newAmount);

  // Send a message to the content script
  let storedKey = await ApiKeyStorage.readKey();
  if (storedKey) {
    let response = await DaffyAPI.addCommittedAmount(storedKey, newAmount);
    console.log("Response from Daffy API", response);
  }
};

chrome.runtime.onMessage.addListener(
  (
    request: DaffyRequest,
    sender: chrome.runtime.MessageSender,
    sendResponse: (response?: any) => void
  ) => {
    console.log("[background.js] onMessage", request);

    switch (request.msg) {
      case "add-amount":
        sendAmount(sender, request.data);
        break;
      case "store-api-key":
        storeApiKey(sender, request.data);
        break;
      default:
        console.log("Worker received unknown message:", request.msg);
    }
  }
);
