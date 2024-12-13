defmodule KVTest do
  use ExUnit.Case

  test "put and get" do
    KV.start_link(nil)
    assert KV.put("key", "value") == :ok
    assert KV.get("key") == "value"
  end

  test "get non-existent key" do
    KV.start_link(nil)
    assert KV.get("non_existent_key") == :not_found
  end

  test "invalid put request" do
    KV.start_link(nil)
    assert KV.put(123, "value") == {:error, "Invalid request"}
  end
end
