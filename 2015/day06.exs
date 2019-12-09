# http://adventofcode.com/2015/day/6

defmodule Day6 do
  def solve(file) do
    File.stream!(file)
    |> Enum.reduce(%{}, &instruct/2)
    |> Enum.count(fn({_, x}) -> x == 1 end)
  end

  defp instruct(line, map) do
    String.trim_trailing(line)
    |> parse()
    |> switch(map)
  end

  defp switch({v, xr, yr}, map) do
    next = for x <- xr, y <- yr, into: %{} do
      val  = case v do
        "toggle" -> if Map.get(map, {x, y}, 0) == 0, do: 1, else: 0
        "on"     -> 1
        "off"    -> 0
      end
      {{x, y}, val}
    end
    Map.merge(map, next)
  end

  defp parse(line) do
    case String.split(line) do
      ["toggle", i1, "through", i2] ->
        parse("toggle", i1, i2)
      ["turn", onoff, i1, "through", i2] ->
        parse(onoff, i1, i2)
    end
  end

  defp parse(ins, i1, i2) do
    [x1, y1] = String.split(i1, ",") |> Enum.map(&String.to_integer/1)
    [x2, y2] = String.split(i2, ",") |> Enum.map(&String.to_integer/1)
    {ins, x1..x2, y1..y2}
  end
end

Day6.solve("res/day6.txt")
|> IO.inspect()
