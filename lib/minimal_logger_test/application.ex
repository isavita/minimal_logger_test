defmodule MinimalLoggerTest.Application do
  use Application

  @impl true
  def start(_type, _args) do
    # Add file handler for logging
    :logger.add_handler(:file_log, :logger_std_h, %{
      config: %{
        file: ~c"/tmp/bandit_test.log",
        filesync_repeat_interval: 5000,
        file_check: 5000,
        max_no_bytes: 10_000_000,
        max_no_files: 5
      },
      formatter: {:logger_formatter, %{
        template: [:msg, "\n"]
      }},
      level: :error,
      filters: []
    })

    children = [
      {Bandit,
       plug: MinimalLoggerTest.TimeoutPlug,
       scheme: :http,
       port: 4000,
       thousand_island_options: [
         read_timeout: 20
       ],
       http_options: [compress: false]}
    ]

    opts = [strategy: :one_for_one, name: MinimalLoggerTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
