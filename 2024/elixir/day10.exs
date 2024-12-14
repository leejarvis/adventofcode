# https://adventofcode.com/2024/day/10

defmodule Day10 do
  def part1(input) do
    map = to_map(input)

    map
    |> Enum.filter(fn {_, val} -> val == 0 end)
    |> Enum.map(fn point_val ->
      hike(map, point_val)
      |> Enum.uniq()
      |> length()
    end)
    |> Enum.sum()
  end

  def part2(_input) do
    0
  end

  defp hike(_, {p, 9}), do: [p]

  defp hike(map, {{x, y}, i}) do
    [{1, 0}, {0, 1}, {0, -1}, {-1, 0}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.reject(fn {nx, ny} -> Map.get(map, {nx, ny}) == nil end)
    |> Enum.filter(fn n -> Map.get(map, n) == i + 1 end)
    |> Enum.flat_map(&hike(map, {&1, i + 1}))
  end

  defp to_map(input) do
    for {row, y} <- Enum.with_index(String.split(input, "\n", trim: true)),
        {val, x} <- Enum.with_index(String.split(row, "", trim: true)),
        into: %{},
        do: {{x, y}, String.to_integer(val)}
  end
end

"""
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
"""
|> then(fn input ->
  {
    Day10.part1(input),
    Day10.part2(input)
  }
  |> IO.inspect()
end)
