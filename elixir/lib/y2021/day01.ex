defmodule Y2021.Day01 do
  use Advent.Day, day: "01"

  def part1 do
    input_to_ints()
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  def part2 do
    input_to_ints()
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> Enum.sum(b) > Enum.sum(a) end)
  end
end
