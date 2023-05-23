import React from "react";
import { DaffyAPI } from "../daffy";

type ReadyStateProps = {
  committedAmount: number | undefined;
};

export const ReadyState: React.FC<ReadyStateProps> = ({ committedAmount }) => {
  const formattedAmount = new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD",
  }).format(committedAmount || 0);

  const redirectToSettings = () => {
    chrome.tabs.create({
      url: DaffyAPI.settingsUrl,
    });
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Committed to charity: {formattedAmount}</h1>
        <button onClick={redirectToSettings}>Open Daffy</button>
      </header>
    </div>
  );
};
