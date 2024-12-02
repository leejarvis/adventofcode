# https://adventofcode.com/2024/day/2

defmodule Day02 do
  def part1(input) do
    input
    |> parse()
    |> Enum.count(&safe?/1)
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.count(fn report ->
      safe?(report) or Enum.any?(dampened(report), &safe?/1)
    end)
  end

  defp dampened(report) do
    0..length(report)
    |> Enum.map(&List.delete_at(report, &1))
  end

  defp safe?(report) do
    processed =
      for [left, right] <- Enum.chunk_every(report, 2, 1) do
        diff = abs(left - right)

        cond do
          diff == 0 or diff > 3 -> nil
          left > right -> :inc
          right > left -> :dec
        end
      end

    case Enum.uniq(processed) do
      [v] when v in [:inc, :dec] -> true
      _ -> false
    end
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, " ") |> Enum.map(&String.to_integer/1)
    end)
  end
end

"""
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""
|> then(fn input ->
  {
    Day02.part1(input),
    Day02.part2(input)
  }
  |> IO.inspect()
end)
