export let DaffyAPI = {
  settingsUrl: "https://www.daffy.org/settings/browser-extension",

  getCommittedAmount: function (apiKey: string) {
    return fetch("https://public.daffy.org/v1/users/me/committed_amount", {
      method: "GET",
      headers: {
        "X-Api-Key": apiKey,
        "Content-Type": "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        return data;
      });
  },

  addCommittedAmount: function (apiKey: string, amount: number) {
    return fetch("https://public.daffy.org/v1/users/me/add_committed_amount", {
      method: "POST",
      headers: {
        "X-Api-Key": apiKey,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ committed_amount: amount }),
    })
      .then((response) => response.json())
      .then((data) => {
        return data;
      });
  },
};
