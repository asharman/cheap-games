defmodule Games.Game do
  def fetch(title, limit) do
    game_url(title, limit)
    |> HTTPoison.get()
    |> handle_response
  end

  def sort_by_cheapest(list_of_games) do
    list_of_games
    |> Enum.sort(&(String.to_float(&1["cheapest"]) <= String.to_float(&2["cheapest"])))
  end

  defp game_url(title, limit) do
    "https://www.cheapshark.com/api/1.0/games?title=#{title}&limit=#{limit}&exact=0"
  end

  defp handle_response({:ok, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_status_code,
      body |> Jason.decode!()
    }
  end

  defp check_status_code(200), do: :ok

  defp check_status_code(_), do: :error
end
