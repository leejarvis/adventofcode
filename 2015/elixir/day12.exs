# http://adventofcode.com/2015/day/12

defmodule Day12 do
  # who needs JSON :/
  def solve1(file) do
    Regex.scan(~r/-?\d+/, File.read!(file))
    |> Enum.reduce(0, fn([d], t) -> t + String.to_integer(d) end)
  end
end

Day12.solve1("res/day12.txt")
|> IO.inspect()
