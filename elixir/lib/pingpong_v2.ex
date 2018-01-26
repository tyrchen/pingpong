defmodule Pingpong.V2 do
  @total_actors 100000
  @total 100

  def start do
    IO.puts "Start #{@total_actors} actors"
    pid = 1..@total_actors - 1
    |> Enum.reduce([], fn _, acc ->
      pid = spawn(Pingpong.V2, :loop, [@total, List.first(acc) || self()])
      [pid | acc]
    end)
    |> List.first()
    IO.puts "All actors are started"
    send pid, :ping
    pid
  end

  def monitor(pid) do
    start = Time.utc_now()
    ref = Process.monitor(pid)
    main(pid, start, ref)
  end

  defp main(pid, start, ref) do
    receive do
      :ping ->
        send pid, :ping
        main(pid, start, ref)
      {:DOWN, ^ref, _, _, _} ->
        diff = Time.diff(Time.utc_now(), start, :microseconds)
        IO.puts("Time elapsed #{@total * @total_actors } runs for message passing: #{diff / 1000000}s")
        IO.puts("Single op spent: #{diff / @total / @total_actors}us")
    end
  end

  def loop(0, _pid), do: nil

  def loop(n, pid) when n > 0 do
    receive do
      :ping ->
        send pid, :ping
        loop(n - 1, pid)
      _ ->
        loop(n, pid)
    end
  end
end
