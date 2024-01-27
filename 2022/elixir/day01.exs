# http://adventofcode.com/2022/day/1

defmodule Day1 do
  import Enum

  def solve(input) do
    sums =
      input
      |> String.split("\n\n")
      |> map(fn s ->
        String.split(s) |> map(&String.to_integer/1) |> sum()
      end)
      |> sort()

    {max(sums), take(sums, -3) |> sum()}
  end
end

File.read!("input/day01.txt")
|> Day1.solve()
|> IO.inspect()
