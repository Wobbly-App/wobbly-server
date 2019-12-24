# Wobbly: Elixir backend [![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2FWobbly-App%2Felixir-backend%2Fbadge%3Fref%3Ddevelop&style=flat)](https://actions-badge.atrox.dev/Wobbly-App/elixir-backend/goto?ref=develop) [![codecov](https://codecov.io/gh/Wobbly-App/elixir-backend/branch/develop/graph/badge.svg)](https://codecov.io/gh/Wobbly-App/elixir-backend) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

The backend server for [Wobbly](https://wobbly.app), written in the Phoenix framework.

This serves a REST API. [A TypeScript client](https://www.npmjs.com/package/@wobbly/api-client) is automatically generated and published to NPM on new releases.

* [Code of conduct](https://github.com/Wobbly-App/wobbly-frontend/blob/develop/CODE-OF-CONDUCT.md)
* [Contributing guide](https://github.com/Wobbly-App/wobbly-frontend/blob/develop/CONTRIBUTING.md)

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Contributing
### Pull requests

- All CI checks must pass for PRs to be merged.
- One of these checks makes sure that a new entry was added to `CHANGELOG.md`. If you don't think your PR requires a changelog entry, use the string `#trivial` somewhere in your PR title or body. Then you'll override this check.

### Debugging
Running into issues with the VS Code debugger? Try deleting the `.elixir_ls`, `deps`, and `_build` folders and restarting VS Code.

## Phoenix resources

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
