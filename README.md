# Wobbly Server [![Build Status](https://github.com/Wobbly-App/wobbly-server/workflows/Test/badge.svg?branch=master)](https://github.com/Wobbly-App/wobbly-server/actions?query=workflow%3ATest+branch%3Amaster) [![codecov](https://codecov.io/gh/Wobbly-App/wobbly-server/branch/master/graph/badge.svg)](https://codecov.io/gh/Wobbly-App/wobbly-server) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

The backend server for [Wobbly](https://wobbly.app), written in Elixir.
Runs [ejabberd](https://www.ejabberd.im/), the XMPP server, with custom extensions.

* [Code of conduct](https://github.com/Wobbly-App/wobbly-frontend/blob/develop/CODE-OF-CONDUCT.md)
* [Contributing guide](https://github.com/Wobbly-App/wobbly-frontend/blob/develop/CONTRIBUTING.md)

## 💻 Up and running

We recommend using VS Code (this repo comes with a few recommended extensions), but it's optional.

### Prerequisites - MacOS
* `brew install elixir gd libyaml
* (when getting dependencies you may have to prefix the `mix` command with `env LDFLAGS="-L$(brew --prefix openssl)/lib" CFLAGS="-I$(brew --prefix openssl)/include" `

### Install and run

* Install dependencies with `mix deps.get`
* Start the server with `iex -S mix`

Now you can connect with an XMPP client.

## 🔥 Testing
TODO.
Just run `mix test`. Make sure you have a Postgres database running.

## 🛠️ Contributing
All CI checks must pass for PRs to be merged. These checks are a lot more likely to succeed if you run `mix format` (to auto-format code), `mix credo` (to check code style), and `mix test` before pushing.

## 🐛 Debugging
Running into issues with the VS Code debugger? Try deleting the `.elixir_ls`, `deps`, and `_build` folders and restarting VS Code.

🖤 🐈
