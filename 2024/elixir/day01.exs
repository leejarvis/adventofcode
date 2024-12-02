# https://adventofcode.com/2024/day/1

defmodule Day01 do
  def part1(input) do
    [left, right] = split(input)
    total_distance(Enum.sort(left), Enum.sort(right), 0)
  end

  def part2(input) do
    [left, right] = split(input)
    similarity_score(left, right, 0)
  end

  defp total_distance([], [], total), do: total

  defp total_distance([l | lr], [r | rr], total) do
    total_distance(lr, rr, total + abs(l - r))
  end

  defp similarity_score([], _, total), do: total

  defp similarity_score([l | lr], right, total) do
    similarity_score(lr, right, total + l * occurences(l, right))
  end

  def occurences(of, into) do
    Enum.count(into, fn x -> x == of end)
  end

  defp split(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [l, r] -> [String.to_integer(l), String.to_integer(r)] end)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end

"""
3   4
4   3
2   5
1   3
3   9
3   3
"""
|> then(fn input ->
  {
    Day01.part1(input),
    Day01.part2(input)
  }
  |> IO.inspect()
end)
