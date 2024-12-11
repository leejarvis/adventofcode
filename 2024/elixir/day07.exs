# https://adventofcode.com/2024/day/7

defmodule Day07 do
  def part1(input) do
    solve(input, [&Kernel.+/2, &Kernel.*/2])
  end

  def part2(input) do
    solve(input, [&Kernel.+/2, &Kernel.*/2, &String.to_integer("#{&1}#{&2}")])
  end

  def solve(input, ops) do
    input
    |> parse()
    |> Enum.filter(fn eq -> valid?(eq, ops) end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  defp valid?({[acc], sum}, _), do: sum == acc

  defp valid?({[a, b | nums], sum}, ops) do
    Enum.any?(ops, fn op -> valid?({[op.(a, b) | nums], sum}, ops) end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [sum, numbers] = String.split(line, ": ")

      {
        Enum.map(String.split(numbers, " "), &String.to_integer/1),
        String.to_integer(sum)
      }
    end)
  end
end

"""
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
"""
|> then(fn input ->
  {
    Day07.part1(input),
    Day07.part2(input)
  }
  |> IO.inspect()
end)
