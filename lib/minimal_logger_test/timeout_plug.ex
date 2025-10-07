defmodule MinimalLoggerTest.TimeoutPlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    send_resp(conn, 200, "OK")
  end
end
