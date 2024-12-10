# https://adventofcode.com/2024/day/6

defmodule Day06 do
  def part1(input) do
    map = to_map(input)
    guard = guard_pos(map)

    map
    |> move(guard, {0, -1}, [guard])
    |> Enum.uniq()
    |> length()
  end

  def part2(_input) do
    0
  end

  defp move(map, {gx, gy} = guard, {dx, dy} = dir, moves) do
    next_pos = {gx + dx, gy + dy}

    case Map.get(map, next_pos) do
      nil ->
        moves

      "#" ->
        move(map, guard, new_dir(dir), moves)

      _ ->
        move(map, next_pos, dir, [next_pos | moves])
    end
  end

  def new_dir({0, -1}), do: {1, 0}
  def new_dir({1, 0}), do: {0, 1}
  def new_dir({0, 1}), do: {-1, 0}
  def new_dir({-1, 0}), do: {0, -1}

  defp guard_pos(map) do
    {guard, "^"} = Enum.find(map, fn {_, v} -> v == "^" end)
    guard
  end

  defp to_map(input) do
    for {r, y} <- Enum.with_index(String.split(input, "\n", trim: true)),
        {v, x} <- Enum.with_index(String.split(r, "", trim: true)),
        into: %{},
        do: {{x, y}, v}
  end
end

"""
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
"""
|> then(fn input ->
  {
    Day06.part1(input),
    Day06.part2(input)
  }
  |> IO.inspect()
end)
