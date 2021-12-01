# http://adventofcode.com/2021/day/1

defmodule Day1 do
  def solve(input) do
    {part1(input), part2(input)}
  end

  defp part1(input) do
    input
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  defp part2(input) do
    input
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> Enum.sum(b) > Enum.sum(a) end)
  end
end

File.read!("input/day01.txt")
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Day1.solve()
|> IO.inspect()
