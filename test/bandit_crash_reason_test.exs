defmodule BanditCrashReasonTest do
  use ExUnit.Case, async: false

  @log_file "/tmp/bandit_test.log"

  setup do
    File.rm(@log_file)
    :ok
  end

  test "with metadata :all, crash_reason appears in logs" do
    {:ok, socket} = :gen_tcp.connect(~c"localhost", 4000, [:binary, active: false])
    :gen_tcp.send(socket, "GET / HTTP/1.1\r\nHost: localhost\r\n")
    Process.sleep(100)
    :gen_tcp.close(socket)

    Logger.flush()
    Process.sleep(100)

    log = File.read!(@log_file)

    IO.puts("\n=== LOG OUTPUT (metadata: :all) ===")
    IO.puts(log)
    IO.puts("====================================\n")

    assert log =~ "crash_reason", "crash_reason should appear with metadata: :all"
  end

  test "with metadata [:request_id], crash_reason is filtered" do
    Logger.configure_backend(LoggerFileBackend,
      metadata: [:request_id]
    )

    {:ok, socket} = :gen_tcp.connect(~c"localhost", 4000, [:binary, active: false])
    :gen_tcp.send(socket, "GET / HTTP/1.1\r\nHost: localhost\r\n")
    Process.sleep(100)
    :gen_tcp.close(socket)

    Logger.flush()
    Process.sleep(100)

    log = File.read!(@log_file)

    IO.puts("\n=== LOG OUTPUT (metadata: [:request_id]) ===")
    IO.puts(log)
    IO.puts("============================================\n")

    refute log =~ "crash_reason",
      "crash_reason should not appear when only [:request_id] is configured"
  end
end
