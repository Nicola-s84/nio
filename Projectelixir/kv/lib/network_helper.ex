defmodule ProjectElixir.NetworkHelper do
  def retry_operation(operation, retries) when retries > 0 do
    case operation.() do
      {:ok, result} -> {:ok, result}
      {:error, _reason} -> retry_operation(operation, retries - 1)
    end
  end

  def retry_operation(_operation, 0), do: {:error, :max_retries_exceeded}
end
