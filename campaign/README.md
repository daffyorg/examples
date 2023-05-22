# Campaign App

This is a Remix example application that uses a combination of Daffy's personal API keys and OAuth2 client to create a campaign to get funds for a specific non profit.

The campaing uses an EIN defined as an environment variable to fetch the non profit information from the Daffy's API using the personal API key.

Then uses OAuth2 to allow end-users to authenticate and create a $18 donations to that specific non profit.

## Prerequisites

1. Node.js (v14.0 or higher)
2. NPM (v6.0 or higher)
3. A Daffy client ID and secret (https://www.daffy.org/settings/oauth)
4. A Daffy personal API key (https://www.daffy.org/settings/api)

## Setup

1. Clone the repository and navigate to the project folder.
2. Install the dependencies with `npm install`.
3. Rename the `.env.template` to `.env` and put your client ID and secret, your personal API key and a non profit EIN.
4. Run the application with `npm run dev`
