const main = () => {
  console.log("[content.ts] Main");

  window.addEventListener("load", (event) => {
    // Get the elements by class name
    const amazonTotalElement =
      document.getElementsByClassName("grand-total-price")[0];
    if (amazonTotalElement != null) {
      // Extract and format the amount
      const amazonTotalElement = document.getElementsByClassName(
        "grand-total-price"
      )[0] as HTMLElement;

      if (amazonTotalElement != null) {
        // Extract and format the amount
        let amazonTotal = amazonTotalElement.innerText.trim().substring(1);
        chrome.runtime.sendMessage({ msg: "add-amount", data: amazonTotal });
        console.log("amazonTotal:", amazonTotal);
      }
    }

    const daffyApiKeyElement = document.getElementById(
      "daffy-extension-api-key"
    );

    if (daffyApiKeyElement != null) {
      let daffyApiKey = (daffyApiKeyElement as HTMLInputElement).value;
      chrome.runtime.sendMessage({ msg: "store-api-key", data: daffyApiKey });

      // show a message to the user that the extension is propertly configured now.
      let configureButton = document.getElementById(
        "configuration-pending"
      ) as HTMLElement;
      configureButton.style.display = "none";

      let successfullyConfiguredButton = document.getElementById(
        "configuration-successfull"
      ) as HTMLElement;
      successfullyConfiguredButton.style.display = "block";
    }
  });

  // Listen for messages
  chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.msg) {
      console.log("[content.ts] onMessage", request.msg);
    }
  });
};

main();

export {};
