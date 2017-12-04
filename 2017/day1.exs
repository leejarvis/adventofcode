# http://adventofcode.com/2017/day/1

defmodule Day1 do
  def solve(string) do
    string <> String.at(string, 0)
    |> String.codepoints()
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.filter(&match?([el, el], &1))
    |> Stream.map(&hd/1)
    |> Enum.sum
  end
end

System.argv
|> hd()
|> Day1.solve()
|> IO.inspect
