import Config

config :ejabberd,
  file: "config/ejabberd.yml",
  log_path: 'logs/ejabberd.log'

# Customize Mnesia directory:
config :mnesia,
  dir: 'mnesiadb/'

config :logger,
  backends: [LoggerLagerBackend],
  handle_otp_reports: false,
  level: :debug
