defmodule Pingpong.V1 do
  @total 10000000

  def start do
    pid1 = spawn(fn -> loop(@total, Time.utc_now()) end)
    pid2 = spawn(fn -> loop(@total, Time.utc_now()) end)
    send pid2, {:ping, pid1}
    pid2
  end

  def monitor(pid) do
    ref1 = Process.monitor(pid)
    receive do
      {:DOWN, ^ref1, _, _, _} -> IO.puts("Done")
    end
  end

  defp loop(0, start) do
    diff = Time.diff(Time.utc_now(), start, :microseconds)
    IO.puts("Time elapsed #{@total} runs for message passing: #{diff}ms")
    IO.puts("Single op spent: #{diff / @total}")
  end

  defp loop(n, start) when n > 0 do
    receive do
      {:ping, pid} ->
        send pid, {:ping, self()}
        loop(n - 1, start)
      _ ->
        loop(n - 1, start)
    end
  end
end
