# https://adventofcode.com/2024/day/11

defmodule Day11 do
  require Integer

  def part1(input) do
    input
    |> parse()
    |> blink(25)
    |> Enum.count()
  end

  def part2(_input) do
    # too slow
    0
  end

  defp blink(stones, 0), do: stones

  defp blink(stones, n) do
    blink(Enum.reduce(stones, [], &transform/2), n - 1)
  end

  defp transform(n, stones) do
    str = to_string(n)
    len = String.length(str)

    cond do
      n == 0 ->
        [1 | stones]

      Integer.is_even(len) ->
        [left, right] =
          String.split_at(str, floor(len / 2))
          |> Tuple.to_list()
          |> Enum.map(&String.to_integer/1)

        [right, left | stones]

      true ->
        [n * 2024 | stones]
    end
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end
end

"""
337 42493 1891760 351136 2 6932 73 0
"""
|> then(fn input ->
  {
    Day11.part1(input),
    Day11.part2(input)
  }
  |> IO.inspect()
end)
