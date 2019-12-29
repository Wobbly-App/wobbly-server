# Wobbly Server [![Build Status](https://github.com/Wobbly-App/elixir-backend/workflows/Test/badge.svg?branch=master)](https://github.com/Wobbly-App/elixir-backend/actions?query=workflow%3ATest+branch%3Amaster) [![codecov](https://codecov.io/gh/Wobbly-App/elixir-backend/branch/master/graph/badge.svg)](https://codecov.io/gh/Wobbly-App/elixir-backend) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

The backend server for [Wobbly](https://wobbly.app), written in Elixir and the [Phoenix framework](http://www.phoenixframework.org/).

This serves a REST API. [A TypeScript client](https://www.npmjs.com/package/@wobbly/api-client) is automatically generated and published to NPM on new releases.

* [Code of conduct](https://github.com/Wobbly-App/wobbly-frontend/blob/develop/CODE-OF-CONDUCT.md)
* [Contributing guide](https://github.com/Wobbly-App/wobbly-frontend/blob/develop/CONTRIBUTING.md)

To start your Phoenix server:

  * Make sure you have a Postgres server running. The easiest way to do this is with `docker-compose up` (if you have Docker installed).
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Contributing
### Pull requests

- All CI checks must pass for PRs to be merged.

### Debugging
Running into issues with the VS Code debugger? Try deleting the `.elixir_ls`, `deps`, and `_build` folders and restarting VS Code.