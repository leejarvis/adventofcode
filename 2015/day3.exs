# http://adventofcode.com/2015/day/3

defmodule Day3 do
  def calculate(input) do
    calculate(input, {0, 0}, MapSet.new)
    |> Enum.count()
  end

  defp calculate("\n", _, set), do: set
  defp calculate(<<dir::binary-size(1), r::binary>>, pos, set) do
    next = next_pos(pos, dir)
    calculate(r, next, MapSet.put(set, next))
  end

  defp next_pos({x, y}, "^"), do: {x, y + 1}
  defp next_pos({x, y}, ">"), do: {x + 1, y}
  defp next_pos({x, y}, "v"), do: {x, y - 1}
  defp next_pos({x, y}, "<"), do: {x - 1, y}
end

File.read!("res/day3.txt")
|> Day3.calculate()
|> IO.inspect()
