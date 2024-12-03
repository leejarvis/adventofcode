# https://adventofcode.com/2024/day/3

defmodule Day03 do
  def part1(input) do
    for [_, x, y] <- Regex.scan(~r/mul\((\d+),(\d+)\)/, input), reduce: 0 do
      acc ->
        acc + String.to_integer(x) * String.to_integer(y)
    end
  end

  def part2(input) do
    Regex.scan(~r/(mul\(\d+,\d+\)|don't\(\)|do\(\))/, input, capture: :all_but_first)
    |> Enum.reduce({true, 0}, fn match, {capture, total} ->
      case {match, capture} do
        {["don't()"], _} ->
          {false, total}

        {["do()"], _} ->
          {true, total}

        {["mul(" <> rest], true} ->
          [x, y] =
            rest
            |> String.trim_trailing(")")
            |> String.split(",")
            |> Enum.map(&String.to_integer/1)

          {capture, total + x * y}

        _ ->
          {capture, total}
      end
    end)
    |> elem(1)
  end
end

"""
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
"""
|> then(fn input ->
  {
    #  192767529
    Day03.part1(input),
    Day03.part2(input)
  }
  |> IO.inspect()
end)
