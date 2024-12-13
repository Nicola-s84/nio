defmodule KV do
  use GenServer

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def put(key, value) when is_binary(key) and is_binary(value) do
    GenServer.call(__MODULE__, {:put, key, value})
  end

  def get(key) when is_binary(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # Server Callbacks

  def init(state) do
    {:ok, state}
  end

  def handle_call({:put, key, value}, _from, state) do
    new_state = Map.put(state, key, value)
    {:reply, :ok, new_state}
  end

  def handle_call({:get, key}, _from, state) do
    value = Map.get(state, key, :not_found)
    {:reply, value, state}
  end

  def handle_call(_msg, _from, state) do
    {:reply, {:error, "Invalid request"}, state}
  end
end
