defmodule Y2021.Day05 do
  use Advent.Day

  def part1(input) do
    input
    |> Enum.reduce(%{}, fn
      {{x1, y1}, {x2, y2}}, map when x1 == x2 or y1 == y2 ->
        Enum.reduce(x1..x2, map, fn x, map ->
          Enum.reduce(y1..y2, map, fn y, map ->
            Map.update(map, {x, y}, 1, &(&1 + 1))
          end)
        end)

      _, map ->
        map
    end)
    |> Enum.count(fn {_, c} -> c >= 2 end)
  end

  def part2(_input) do
    nil
  end

  @impl Advent.Day
  def parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(&split_line/1)
  end

  defp split_line(line) do
    [a, "->", b] = String.split(line)
    {split_cord(a), split_cord(b)}
  end

  defp split_cord(cord) do
    cord
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end
