# http://adventofcode.com/2020/day/6

defmodule Day6 do
  def solve(input) do
    groups = Enum.map(input, & String.split(&1, "\n"))

    s1 = Enum.map(groups, &unique_yes/1) |> Enum.sum()
    s2 = Enum.map(groups, &all_yes/1) |> Enum.sum()

    {s1, s2}
  end

  def unique_yes(group) do
    group
    |> Enum.join()
    |> String.graphemes()
    |> MapSet.new()
    |> Enum.count()
  end

  def all_yes(group) do
    [f | _] = group = Enum.map(group, &String.graphemes/1)

    for r <- group, m = MapSet.new(r), reduce: MapSet.new(f) do
      a -> MapSet.intersection(m, a)
    end
    |> Enum.count()
  end
end

File.read!("input/day06.txt")
|> String.split("\n\n")
|> Day6.solve()
|> IO.inspect()
