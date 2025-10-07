import Config

config :logger,
  backends: [{LoggerFileBackend, :file}]

config :logger, :file,
  path: "/tmp/bandit_test.log",
  format: {MinimalLoggerTest.Formatter, :format},
  metadata: [:request_id],
  level: :error
