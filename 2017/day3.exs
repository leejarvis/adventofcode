# http://adventofcode.com/2017/day/3

defmodule Day3 do
  import Integer, only: [mod: 2]

  def count_steps(square) do
    side  = side_length(square)
    steps = (side - 1) / 2
    count = round(square - :math.pow((side - 2), 2))
    offset = mod(count, side - 1)

    steps + abs(offset - steps)
    |> round()
  end

  defp side_length(square) do
    side = square
    |> :math.sqrt()
    |> :math.ceil()
    |> round()

    cond do
      mod(side, 2) == side -> side + 1
      true -> side
    end
  end
end

Day3.count_steps(277678)
|> IO.inspect()
# 475
# 279138
