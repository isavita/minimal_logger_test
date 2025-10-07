defmodule MinimalLoggerTest.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Bandit,
       plug: MinimalLoggerTest.TimeoutPlug,
       scheme: :http,
       port: 4000,
       thousand_island_options: [
         # 20ms timeout
         read_timeout: 20
       ],
       http_options: [compress: false]}
    ]

    opts = [strategy: :one_for_one, name: MinimalLoggerTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
