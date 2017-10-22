defmodule Oso.Storage do
  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(key) do
    Agent.get(__MODULE__, fn state ->
      Map.get(state, key)
    end)
  end

  def put(key, data) do
    Agent.update(__MODULE__, fn(state) ->
      Map.put(state, key, [data | state.key])
  end
end
