# https://adventofcode.com/2024/day/13

defmodule Day13 do
  def part1(input) do
    parse(input)
    |> Enum.map(&calculate/1)
    |> Enum.flat_map(fn
      [a, b] when a <= 100 and b <= 100 ->
        [3 * a + b]

      _ ->
        []
    end)
    |> Enum.sum()
    |> floor()
  end

  def part2(_input) do
    0
  end

  defp calculate([[ax, ay], [bx, by], [px, py]]) do
    x = (by * px - bx * py) / (ax * by - bx * ay)
    y = (ax * py - ay * px) / (ax * by - bx * ay)

    if floor(x) == x and floor(y) == y do
      [x, y]
    end
  end

  defp parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn block ->
      [
        "Button A: " <> a,
        "Button B: " <> b,
        "Prize: " <> prize
      ] = String.split(block, "\n", trim: true)

      [
        split(a, "+"),
        split(b, "+"),
        split(prize, "=")
      ]
    end)
  end

  defp split(input, sep) do
    input
    |> String.split(", ")
    |> Enum.map(&(String.split(&1, sep) |> Enum.at(1) |> String.to_integer()))
  end
end

"""
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
"""
|> then(fn input ->
  {
    Day13.part1(input),
    Day13.part2(input)
  }
  |> IO.inspect()
end)
