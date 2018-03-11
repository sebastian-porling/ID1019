defmodule DNS do

  @server {8,8,8,8}
  @port 53
  @local 5300


  def start() do
    start(@local, @server, @port)
  end

  def start(local, server, port) do
    spawn(fn() -> init(local, server, port) end)
  end
  
  def init(local, server, port) do
    case :gen_udp.open(local, [{:active, true}, :binary]) do
      {:ok, local} ->
        case :gen_udp.open(0, [{:active, true}, :binary]) do
          {:ok, remote} ->
            dns(local, remote, server, port)
          error ->
            :io.format("DNS error opening remote socket: ~w~n", [error])
        end
      error ->
        :io.format("DNS error opening remote socket: ~w~n", [error])
    end
  end

  def dns(local, remote, server, port) do
    receive do
    #{udp,#Port<0.3295>,{127,0,0,1},59001
      {:udp, ^local, client, client_port, query} ->
        :io.format("request from ~w ~w~n", [client, client_port])
        decoded = Msg.decode(query)
        :io.format("decoded: ~w~n", [decoded])
        :gen_udp.send(remote, server, port, query)
        DNS.dns(local, remote, server, port)
      {:udp, ^remote, server, port, reply} ->
        :io.format("request from ~w ~w~n ", [server, port])
        decoded = Msg.query(reply)
        :io.format("decoded: ~p~n", [decoded])
        dns(local, remote, server, port)
      :quit ->
        :ok
      :update ->
        DNS.dns(local, remote, server, port)
      strange ->
        :io.format("strange message ~w~n", [strange])
        DNS.dns(local, remote, server, port)
    end
  end



end