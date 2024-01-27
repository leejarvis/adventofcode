# https://adventofcode.com/2020/day/13

defmodule Day13 do
  def solve(input) do
    {time, busses} = parse(input)
    {bus, departure} = earliest_available_bus(time, busses)

    s1 = bus * (departure - time)
    s2 = 0

    {s1, s2}
  end

  defp earliest_available_bus(time, busses) do
    busses
    |> Enum.map(fn(b) -> {b, ceil(time / b) * b} end)
    |> Enum.min_by(fn({_, c}) -> c end)
  end

  defp parse([time, busses]) do
    time = String.to_integer(time)
    busses = String.split(busses, ",")
             |> Enum.filter(& &1 != "x")
             |> Enum.map(&String.to_integer/1)
             |> Enum.sort()

    {time, busses}
  end
end

File.read!("input/day13.txt")
|> String.split("\n", trim: true)
|> Day13.solve()
|> IO.inspect()
