# http://adventofcode.com/2022/day/3

defmodule Day3 do
  def solve(input) do
    rucksacks = parse_input(input)

    one = Enum.map(rucksacks, &common_item/1) |> priority_sum()
    two = Enum.chunk_every(rucksacks, 3) |> Enum.map(&common_item/1) |> priority_sum()

    {one, two}
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn rucksack ->
      items = String.codepoints(rucksack)
      Enum.split(items, round(length(items) / 2))
    end)
  end

  defp common_item({c1, c2}) do
    [common] = MapSet.intersection(MapSet.new(c1), MapSet.new(c2)) |> Enum.to_list()
    common
  end

  defp common_item([c1, c2, c3]) do
    [common] =
      [c1, c2, c3]
      |> Enum.map(fn {a, b} -> MapSet.new(a ++ b) end)
      |> Enum.reduce(fn m, a -> MapSet.intersection(a, m) end)
      |> Enum.to_list()

    common
  end

  defp priority_sum(items), do: Enum.map(items, &priority/1) |> Enum.sum()

  defp priority(<<x::utf8>>) when x < 97, do: x - 38
  defp priority(<<x::utf8>>), do: x - 96
end

File.read!("input/day03.txt")
|> Day3.solve()
|> IO.inspect(charlists: :as_lists)
