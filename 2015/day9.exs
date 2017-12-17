# http://adventofcode.com/2015/day/9

defmodule Day9 do
  def solve(input) do
    File.stream!(input)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.reduce(%{}, &add/2)
    |> places()
    |> reduce()
    |> Enum.sort()
    |> List.first()
  end

  defp reduce({places, routes}) do
    permutation(places)
    |> Enum.map(fn(x) ->
      Enum.chunk(x, 2, 1)
      |> Enum.reduce(0, fn(d, t) ->
        t + Map.get(routes, Enum.sort(d)) end)
    end)
  end

  defp places(routes) do
    list = Enum.flat_map(routes, fn({r, _}) -> r end)
    |> MapSet.new
    |> MapSet.to_list
    {list, routes}
  end

  defp add(line, map) do
    [start, _, finish, _, distance ] = String.split(line, " ")
    Map.put(map, Enum.sort([start, finish]), String.to_integer(distance))
  end

  def permutation([]), do: [[]]
  def permutation(list), do: for h <- list, t <- permutation(list -- [h]), do: [h | t]
end

Day9.solve("res/day9.txt")
|> IO.inspect()
