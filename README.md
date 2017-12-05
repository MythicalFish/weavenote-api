# WEAVENOTE API (& Billing)

This Rails app serves as the API for the React-based frontend for Weavenote.

## Some things to note:

* Using [Figaro](https://github.com/laserlemon/figaro) for the ENV vars
* Auth is handled by [Auth0](https://auth0.com/)
  * The access token is passed in each request's header, and validated against
    Auth0's API (although I added a 30 minute cache so it doesn't overload
    Auth0).
* If the port is `3001`, or the subdomain is `api`, then only the API routes are
  exposed.
* Conversely, port `3002` and subdomain `billing` expose an Organization's
  billing admin.
  * In this case, the Auth0 access token is initially sent as a param and just
    stored as a cookie.
  * Payment are handled by [Stripe](https://stripe.com/).
  * Ideally the UI should be kept in React, and this API should just use
    Stripe's webhooks to update subscriptions, etc., but there wasn't time.
* Mail outbound (and inbound parsing) is done by
  [SendGrid](https://sendgrid.com/).
