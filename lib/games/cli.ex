defmodule Games.CLI do
  @default_count 10

  def run(argv) do
    argv
    |> parse_args()
    |> process_args()
  end

  def parse_args(argv) do
    OptionParser.parse(argv,
      switches: [help: :boolean, limit: :integer],
      aliases: [h: :help, l: :limit]
    )
    |> process_options()
  end

  defp process_options({[help: true], _, _}), do: :help

  defp process_options({[limit: count], [title], _}), do: {title, count}

  defp process_options({_, [title], _}), do: {title, @default_count}

  defp process_options(_), do: :help

  defp process_args(:help) do
    IO.puts("""
    usage: games <title>

    options:
    --limit, -l: Sets the limit of games searched (Default: 10)
    """)

    System.halt(0)
  end

  defp process_args({title, limit}) do
    Games.Game.fetch(title, limit)
    |> decode_response
    |> Games.TableFormatter.print_table_for_columns(["steamAppID", "cheapest", "external"])
  end

  defp decode_response({:ok, body}) do
    Games.Game.sort_by_cheapest(body)
  end

  defp decode_response({:error, error}) do
    IO.puts("Error fetching: #{error["message"]})")
    System.halt(2)
  end
end
