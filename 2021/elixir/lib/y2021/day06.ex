defmodule Y2021.Day06 do
  use Advent.Day

  def part1(fish) do
    fish |> multiply(80) |> Enum.sum()
  end

  def part2(fish) do
    fish |> multiply(256) |> Enum.sum()
  end

  defp multiply(fish, 0), do: Map.values(fish)
  defp multiply(fish, day) do
    Enum.reduce(fish, %{}, &inc_day/2) |> multiply(day - 1)
  end

  def inc_day(dv, acc) do
    case dv do
      {0, x} ->
        Map.update(acc, 6, x, &(&1 + x)) |> Map.put(8, x)
      {c, x} ->
        Map.update(acc, c - 1, x, &(&1 + x))
    end
  end

  @impl Advent.Day
  def parse_input(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
  end
end
