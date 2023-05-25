# Matching Funds

This application lets users create a matching fund campaign for their favorite charity.

The campaign uses an EIN defined as an environment variable to fetch the non-profit information from Daffy's API using the personal API key.

Then uses OAuth2 to allow end-users to authenticate and create donations to that specific non-profit. The amount the user chooses will also be used to create a donation with their personal API key.

## Prerequisites

1. Node.js (v14.0 or higher)
2. NPM (v6.0 or higher)
3. A Daffy client ID and secret
4. A Daffy personal API key (https://www.daffy.org/settings/api)
5. The EIN of the non profit you want to support (https://www.daffy.org/charities)

> **Note** to get a client ID and secret contact us at partner@daffy.org

## Setup

1. Clone the repository and navigate to the project folder.
2. Install the dependencies with `npm install`.
3. Rename the `.env.template` to `.env` and put your client ID and secret, your personal API key and a non profit EIN.
4. Run the application with `npm run dev`
