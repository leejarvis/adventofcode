# http://adventofcode.com/2020/day/3

defmodule Day3 do
  def solve(input) do
    p1 = count_trees(input, {3, 1})

    p2 = for n <- [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}] do
      count_trees(input, n)
    end |> Enum.reduce(& &1 * &2)

    {p1, p2}
  end

  defp count_trees([row | _] = map, {x, y}) do
    Stream.take_every(map, y)
    |> Stream.zip(Stream.iterate(0, &(rem(&1 + x, String.length(row)))))
    |> Stream.filter(fn {row, x} -> String.at(row, x) == "#" end)
    |> Enum.count()
  end
end

File.read!("input/day03.txt")
|> String.split("\n")
|> Day3.solve()
|> IO.inspect()
