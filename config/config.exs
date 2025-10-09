import Config

config :logger,
  backends: []

config :logger, :default_handler,
  level: :error

config :logger, :default_formatter,
  format: {MinimalLoggerTest.Formatter, :format},
  metadata: :all

config :logger, :file_handler,
  level: :error,
  config: %{
    file: ~c"/tmp/bandit_test.log",
    type: :standard_io
  },
  formatter: {MinimalLoggerTest.Formatter, :format},
  metadata: :all
