import React from "react";
import { DaffyAPI } from "../daffy";

export const Configure = () => {
  const redirectToSettings = () => {
    chrome.tabs.create({
      url: DaffyAPI.settingsUrl,
    });
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Head to Daffy to configure the extension</h1>
        <button onClick={redirectToSettings}>Configure</button>
      </header>
    </div>
  );
};
