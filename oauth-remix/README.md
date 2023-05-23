# Login with Daffy + Remix example

This is a sample Remix application using the Login with Daffy to get an access token for an end-user and then use that token to make API calls to Daffy.

This example application uses Remix Auth with the Auth0Strategy to handle the OAuth2 flow.

Once the user is authenticated it uses does a single `fetch` to Daffy's public API to get the user's name.

## Prerequisites

1. Node.js (v14.0 or higher)
2. NPM (v6.0 or higher)
3. A Daffy client ID and secret

> **Note** to get a client ID and secret contact us at partner@daffy.org

## Setup

1. Clone the repository and navigate to the project folder.
2. Install the dependencies with `npm install`.
3. Rename the `.env.template` to `.env` and put your client ID and secret
4. Run the application with `npm run dev`
