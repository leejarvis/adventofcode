# https://adventofcode.com/2020/day/10

defmodule Day10 do
  def solve(adapters) do
    s1 = joltage_difference(adapters)
    s2 = count_arrangements(adapters)

    {s1, s2}
  end

  defp joltage_difference(adapters) do
    {_, n1, n3} = for adapter <- adapters, reduce: {0, 0, 0} do
      {curr, n1, n3} = acc ->
        case adapter - curr do
          1 -> {adapter, n1 + 1, n3}
          3 -> {adapter, n1, n3 + 1}
          _ -> acc
        end
    end

    n1 * (n3 + 1)
  end

  def count_arrangements(adapters) do
    adapters = Enum.sort([0 | adapters], :desc)
    max = Enum.max(adapters) + 3

    arrangements = for adapter <- adapters, reduce: %{max => 1} do
      acc ->
        Map.put(acc, adapter, Enum.sum(Enum.map(1..3, &Map.get(acc, adapter + &1, 0))))
    end

    arrangements[0]
  end
end

File.read!("input/day10.txt")
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Enum.sort()
|> Day10.solve()
|> IO.inspect()
