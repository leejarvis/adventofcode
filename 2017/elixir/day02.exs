# http://adventofcode.com/2017/day/2

defmodule Day2 do
  def checksum(content) do
    content
    |> parse
    |> calc_diff
    |> sum
  end

  def sum(rows) do
    Enum.reduce(rows, 0, fn({_, x}, acc) -> x + acc end)
  end

  defp calc_diff(rows) do
    Enum.map(rows, fn(r) ->
      {min, max} = Enum.min_max(r)
      {r, max - min}
    end)
  end

  defp parse(content) do
    content
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end

File.read!("res/day2.txt")
|> Day2.checksum()
|> IO.inspect()
