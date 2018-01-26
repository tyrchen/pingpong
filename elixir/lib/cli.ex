defmodule Pingpong.CLI do

  def main(_args \\ []) do
    pid = Pingpong.V2.start()
    Pingpong.V2.monitor(pid) 
  end
end
