# https://adventofcode.com/2024/day/4

defmodule Day04 do
  @dirs [{1, 0}, {0, 1}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

  def part1(input) do
    grid = to_grid(input)

    for {point, _} <- grid, reduce: 0 do
      total ->
        total + Enum.count(words_for_point(grid, point), &(&1 == "XMAS"))
    end
  end

  def part2(input) do
    grid = to_grid(input)

    for {point, c} <- grid, c == "A", reduce: 0 do
      total ->
        if xmas?(grid, point), do: total + 1, else: total
    end
  end

  defp xmas?(grid, {x, y}) do
    d1 = Enum.sort([grid[{x - 1, y - 1}], grid[{x, y}], grid[{x + 1, y + 1}]])
    d2 = Enum.sort([grid[{x - 1, y + 1}], grid[{x, y}], grid[{x + 1, y - 1}]])

    d1 == ~w[A M S] and d2 == ~w[A M S]
  end

  defp words_for_point(grid, {x, y}) do
    Enum.map(@dirs, fn {dir_x, dir_y} ->
      Enum.reduce(0..3, "", fn delta, word ->
        point = {x + delta * dir_x, y + delta * dir_y}

        case grid[point] do
          nil -> word
          _ -> word <> grid[point]
        end
      end)
    end)
  end

  defp to_grid(input) do
    input
    |> String.split("\n", trim: true)
    |> then(fn rows ->
      for {row, y} <- Enum.with_index(rows),
          {cell, x} <- Enum.with_index(String.split(row, "", trim: true)),
          into: %{},
          do: {{x, y}, cell}
    end)
  end
end

"""
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""
|> then(fn input ->
  {
    Day04.part1(input),
    Day04.part2(input)
  }
  |> IO.inspect()
end)
