defmodule Games.CLI do
  @default_count 10

  def run(argv) do
    parse_args(argv)
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
end
