# http://adventofcode.com/2022/day/10

defmodule Day10 do
  def solve(input) do
    ins = parse_ins(input)
    result = cycle(ins)

    one = collect(result, [20, 60, 100, 140, 180, 220]) |> Enum.sum()
    two = 0

    {one, two}
  end

  defp collect(result, cycle_numbers) do
    cycle_numbers
    |> Enum.map(fn v -> Enum.at(result, v - 1) * v end)
  end

  defp cycle(ins) do
    ins
    |> Enum.reduce({[], 1}, fn
      :noop, {acc, x} -> {[x | acc], x}
      {:addx, n}, {acc, x} -> {[[x, x] | acc], x + n}
    end)
    |> elem(0)
    |> Enum.reverse()
    |> List.flatten()
  end

  defp parse_ins(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      case String.split(s, " ") do
        ["noop"] -> :noop
        ["addx", v] -> {:addx, String.to_integer(v)}
      end
    end)
  end
end

File.read!("input/day10.txt")
|> Day10.solve()
|> IO.inspect(charlists: :as_lists)
