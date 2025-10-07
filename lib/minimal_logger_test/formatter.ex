defmodule MinimalLoggerTest.Formatter do
  def format(level, message, _timestamp, metadata) do
    Jason.encode!(%{
      level: level,
      message: to_string(message),
      metadata: stringify_metadata(metadata)
    }) <> "\n"
  end

  defp stringify_metadata(metadata) do
    Map.new(metadata, fn {k, v} -> {k, inspect(v)} end)
  end
end
