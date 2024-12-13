# https://adventofcode.com/2024/day/8

defmodule Day08 do
  def part1(input) do
    map = to_map(input)
    size = Enum.map(map, fn {{r, _}, _} -> r end) |> Enum.max()
    map = Enum.filter(map, fn {_, val} -> val != "." end) |> Map.new()

    map
    |> Enum.group_by(fn {_, node} -> node end)
    |> Enum.flat_map(fn {_, nodes} ->
      antinodes(nodes)
      |> Enum.filter(fn {x, y} ->
        0 <= x and size >= x and 0 <= y and size >= y
      end)
    end)
    |> Enum.uniq()
    |> length()
  end

  def part2(_input) do
    0
  end

  defp antinodes([{{x1, y1}, _}, {{x2, y2}, _}]) do
    dx = x1 - x2
    dy = y1 - y2

    [{x1 + dx, y1 + dy}, {x2 - dx, y2 - dy}]
  end

  defp antinodes(nodes) do
    nodes
    |> permutations(2)
    |> Enum.flat_map(&antinodes(&1))
  end

  defp permutations([], _), do: [[]]
  defp permutations(_, 0), do: [[]]

  defp permutations(list, k) do
    for h <- list, t <- permutations(list -- [h], k - 1), do: [h | t]
  end

  defp to_map(input) do
    for {row, y} <- Enum.with_index(String.split(input, "\n", trim: true)),
        {val, x} <- Enum.with_index(String.split(row, "", trim: true)),
        into: %{},
        do: {{x, y}, val}
  end
end

"""
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
"""
|> then(fn input ->
  {
    Day08.part1(input),
    Day08.part2(input)
  }
  |> IO.inspect()
end)
