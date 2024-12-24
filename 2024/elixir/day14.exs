# https://adventofcode.com/2024/day/14

defmodule Day14 do
  def part1(input) do
    input
    |> parse()
    |> elapse(100, 11, 7)
    |> safe_area(11, 7)

    # for real input
    # |> elapse(100, 101, 103)
    # |> safe_area(101, 103)
  end

  defp safe_area(input, width, height) do
    # lol im sure there's a better way to do this
    w_mid = floor(width / 2)
    h_mid = floor(height / 2)

    [
      quadrant_count(input, &(&1 < w_mid and &2 < h_mid)),
      quadrant_count(input, &(&1 < w_mid and &2 > h_mid)),
      quadrant_count(input, &(&1 > w_mid and &2 < h_mid)),
      quadrant_count(input, &(&1 > w_mid and &2 > h_mid))
    ]
    |> Enum.product()
  end

  defp quadrant_count(input, matchfun) do
    Enum.count(input, fn [{x, y}, _] -> matchfun.(x, y) end)
  end

  defp elapse(input, 0, _, _), do: input

  defp elapse(input, n, width, height) do
    elapse(do_elapse(input, width, height), n - 1, width, height)
  end

  defp do_elapse(input, width, height) do
    Enum.map(input, fn [{x, y}, {xv, yv}] ->
      new_x = rem(x + xv, width)
      new_y = rem(y + yv, height)

      new_x = if new_x < 0, do: new_x + width, else: new_x
      new_y = if new_y < 0, do: new_y + height, else: new_y

      [{new_x, new_y}, {xv, yv}]
    end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, " ", trim: true)
      |> Enum.map(&parse_part/1)
    end)
  end

  defp parse_part(part) do
    part
    |> String.slice(2..-1//1)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end

"""
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
"""
|> then(fn input ->
  Day14.part1(input)
  |> IO.inspect()
end)
