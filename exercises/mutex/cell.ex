defmodule Cell do
  def new(), do: spawn_link(fn -> cell(:open) end)
  defp cell(state) do
    receive do
      {:get, from} ->
        send(from, {:ok, state})
        cell(state)
      {:set, value, from} ->
        send(from, :ok)
        cell(value)
    end
  end
  def get(cell) do
    send(cell, {:get, self()})
    receive do
      {:ok, value} -> value
    end
  end
  def set(cell, value) do
    send(cell, {:set, value, self()})
    receive do
      :ok -> :ok
    end
  end
end