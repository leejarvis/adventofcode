# http://adventofcode.com/2015/day/2

defmodule Day2 do
  def calculate(file) do
    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_line/1)
    |> Stream.map(&calculate_line/1)
    |> Enum.into([])
    |> Enum.sum()
  end

  defp parse_line(line) do
    String.split(line, "x") |> Enum.map(&String.to_integer/1)
  end

  def calculate_line([l, w, h]) do
    ((2*l*w) + (2*w*h) + (2*h*l)) + Enum.min([l*w, w*h, h*l])
  end
end

Day2.calculate("res/day2.txt")
|> IO.inspect()
