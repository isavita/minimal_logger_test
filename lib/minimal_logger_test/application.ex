defmodule MinimalLoggerTest.Application do
  use Application

  @impl true
  def start(_type, _args) do
    # Remove the default handler to avoid formatter conflicts
    :logger.remove_handler(:default)

    # Add file handler with JSON formatter and metadata filtering
    :logger.add_handler(:file_log, :logger_std_h, %{
      config: %{file: ~c"/tmp/bandit_test.log"},
      level: :error,
      formatter: {MinimalLoggerTest.Formatter, %{}},
      filter_default: :log,
      filters: [
        {:remove_crash_reason, {&filter_crash_reason/2, []}}
      ]
    })

    children = [
      {Bandit,
       plug: MinimalLoggerTest.TimeoutPlug,
       scheme: :http,
       port: 4000,
       thousand_island_options: [read_timeout: 20],
       http_options: [compress: false]}
    ]

    opts = [strategy: :one_for_one, name: MinimalLoggerTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp filter_crash_reason(log_event, _extra) do
    %{meta: meta} = log_event
    %{log_event | meta: Map.delete(meta, :crash_reason)}
  end
end
