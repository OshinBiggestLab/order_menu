# OrderMenu

## Contents
  * Main File :  `lib/order_menu_web/live/order_menu_live.ex`
  * Data: `priv/static/data.json`
  * UI Design: `about-project/design`

## What I use + Document recommendations
  * Web Design: [`Frontend Mentor`](https://www.frontendmentor.io/challenges/product-list-with-cart-5MmqLVAp_d)
  * Web Framework: [`Phoenix LiveView`](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)
  * Language: [`Elixir`](https://hexdocs.pm/elixir/Kernel.html#content)
  * CSS Library: [`TailwindCSS`](https://tailwindcss.com/)

## Articles
  * [`Import, Alias, Require, and Use in Elixir`](https://gabriel.perales.me/blog/import-alias-require-and-use)

## Notes
  * State Naming: `snake_case` only. E.g. ->  is_clicked
  * ERB tag (Embedded Ruby tag): `<%= ... %>`
  * handle_event/3
        * We can have as many handle_event/3 functions as you need, there's no strict limit.
          ⚠️ BUT put specific ones first and catch-all patterns last to avoid conflicts—Elixir matches from top to bottom.
        * Each one should match on a different event name (or different pattern).
        * Elixir uses pattern matching, so when a LiveView receives an event,
          it tries each handle_event/3 function until it finds one that matches the event name.


## README Default

Run server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

Learn more:

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
