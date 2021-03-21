defmodule Games.CLI do
  @default_count 10

  def run(argv) do
    parse_args(argv)
  end

  def parse_args(argv) do
    parse =
      OptionParser.parse(argv,
        switches: [help: :boolean, limit: :integer],
        aliases: [h: :help, l: :limit]
      )

    case parse do
      {[help: true], _, _} ->
        :help

      {[limit: count], [title], _} ->
        {title, count}

      {_, [title], _} ->
        {title, @default_count}

      _ ->
        :help
    end
  end
end
