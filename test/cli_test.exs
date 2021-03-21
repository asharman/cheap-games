defmodule CliTest do
  use ExUnit.Case
  doctest Games

  import Games.CLI, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "limit parsing changes the count value" do
    assert parse_args(["-l", "2", "title"]) == {"title", 2}
    assert parse_args(["--limit", "2", "title"]) == {"title", 2}
  end

  test "when no limit is given, default to 10" do
    assert parse_args(["title"]) == {"title", 10}
  end
end
