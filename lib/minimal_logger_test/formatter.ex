defmodule MinimalLoggerTest.Formatter do
  def format(log_event, _config) do
    %{level: level, msg: msg, meta: meta} = log_event

    Jason.encode!(%{
      level: level,
      message: format_msg(msg),
      metadata: stringify_metadata(meta)
    }) <> "\n"
  end

  defp format_msg({:string, chardata}), do: IO.chardata_to_string(chardata)
  defp format_msg({:report, report}), do: inspect(report)
  defp format_msg(msg), do: to_string(msg)

  defp stringify_metadata(meta) do
    Map.new(meta, fn {k, v} -> {k, inspect(v)} end)
  end
end
