defmodule KVServerTest do
  use ExUnit.Case

  test "handle valid requests" do
    KVServer.start_link(nil)
    assert KVServer.handle_request("PUT key value") == :ok
    assert KVServer.handle_request("GET key") == "value"
  end

  test "handle invalid requests" do
    KVServer.start_link(nil)
    assert KVServer.handle_request("INVALID request") == {:error, "Invalid request"}
  end
end