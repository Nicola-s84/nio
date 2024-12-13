defmodule KVServer do
  use GenServer

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def handle_request(request) when is_binary(request) do
    GenServer.call(__MODULE__, {:handle_request, request})
  end

  # Server Callbacks

  def init(state) do
    {:ok, state}
  end

  def handle_call({:handle_request, request}, _from, state) do
    response = process_request(request)
    {:reply, response, state}
  end

  defp process_request(request) do
    case String.split(request) do
      ["PUT", key, value] -> KV.put(key, value)
      ["GET", key] -> KV.get(key)
      _ -> {:error, "Invalid request"}
    end
  end

  def handle_call(_msg, _from, state) do
    {:reply, {:error, "Invalid request"}, state}
  end
end