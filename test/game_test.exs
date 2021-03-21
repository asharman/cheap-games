defmodule GameTest do
  use ExUnit.Case
  doctest Games

  import Games.Game, only: [sort_by_cheapest: 1]

  test "sort games cheapest to most expensive" do
    sorted_prices =
      test_data()
      |> sort_by_cheapest()
      |> Enum.map(&Map.get(&1, "cheapest"))

    assert sorted_prices == ["14.95", "19.99", "59.98"]
  end

  def test_data do
    Jason.decode!("""
    [{"gameID":"167613","steamAppID":null,"cheapest":"19.99","cheapestDealID":"XBi29i5eAtuiRO2htR8wlQ6JyRZcUl4uMnUaTlQAPxA%3D","external":"LEGO Batman 2","internalName":"LEGOBATMAN2","thumb":"https:\/\/cdn.fanatical.com\/production\/product\/400x225\/4cf0701e-77bf-4539-bda7-129ab3e81f8b.jpeg"},{"gameID":"213979","steamAppID":null,"cheapest":"59.98","cheapestDealID":"g8bndKSh36TtB0Ac6s%2FOyR7MgjwADkJ5Jpru%2FiLDvoo%3D","external":"Batman Bundle","internalName":"BATMANBUNDLE","thumb":"https:\/\/2game.com\/media\/catalog\/product\/cache\/2\/small_image\/17f82f742ffe127f42dca9de82fb58b1\/placeholder\/default\/2Game-Defalt-NEW_1.jpg"},{"gameID":"612","steamAppID":"21000","cheapest":"14.95","cheapestDealID":"tyTH88J0PXRvYALBjV3cNHd5Juq1qKcu4tG4lBiUCt4%3D","external":"LEGO Batman","internalName":"LEGOBATMAN","thumb":"https:\/\/originassets.akamaized.net\/origin-com-store-final-assets-prod\/195763\/142.0x200.0\/1040463_MB_142x200_en_US_^_2017-09-08-15-21-36_d7034d41216b6dc201fb20e0cee37c1e66190a11.jpg"}]
    """)
  end
end
