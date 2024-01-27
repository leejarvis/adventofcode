# http://adventofcode.com/2017/day/12

defmodule Day12 do
  def solve(file) do
    File.stream!(file)
    |> Stream.map(&parse/1)
    |> Map.new()
    |> connect("0")
    |> Enum.count()
  end

  defp parse(line) do
    [program, group] = String.trim(line) |> String.split(" <-> ")
    {program, String.split(group, ", ")}
  end

  defp connect(map, program) do
    {group, other} = Map.pop(map, program, MapSet.new())
    Enum.reduce(group, MapSet.new([program]), fn(g, acc) ->
      MapSet.union(acc, connect(other, g))
    end)
  end
end

Day12.solve("res/day12.txt")
|> IO.inspect()
