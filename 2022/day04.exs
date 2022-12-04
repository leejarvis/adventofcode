# http://adventofcode.com/2022/day/4

defmodule Day4 do
  def solve(input) do
    ranges = parse_input(input)

    one = Enum.count(ranges, &overlap_full?/1)
    two = Enum.count(ranges, &overlap_any?/1)

    {one, two}
  end

  def overlap_full?([[x1, x2], [y1, y2]]) do
    x1 >= y1 && x2 <= y2 || y1 >= x1 && y2 <= x2
  end

  def overlap_any?([[x1, x2], [y1, y2]]) do
    !Range.disjoint?(x1..x2, y1..y2)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s -> Enum.map(String.split(s, ","), &parse_range/1) end)
  end

  defp parse_range(range) do
    String.split(range, "-") |> Enum.map(&String.to_integer/1)
  end
end

File.read!("input/day04.txt")
|> Day4.solve()
|> IO.inspect(charlists: :as_lists)
