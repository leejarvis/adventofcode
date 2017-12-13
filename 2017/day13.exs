# http://adventofcode.com/2017/day/13

defmodule Day13 do
  def solve(file) do
    File.stream!(file)
    |> Stream.map(&parse/1)
    |> Enum.reduce(0, &calculate/2)
  end

  defp calculate([layer, depth], total) do
    if rem(layer, (depth - 1) * 2) == 0 do
      total + layer * depth
    else
      total
    end
  end

  defp parse(line) do
    line
    |> String.trim_trailing()
    |> String.split(": ")
    |> Enum.map(&String.to_integer/1)
  end
end

Day13.solve("res/day13.txt")
|> IO.inspect()
