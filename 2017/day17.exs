# http://adventofcode.com/2017/day/17

defmodule Day17 do
  def solve(steps) do
    res = insert(2017, steps, [])
    i = Enum.find_index(res, &(&1 == 2017))
    Enum.at(res, i + 1)
  end

  defp insert(n, steps, acc) do
    insert(n + 1, steps, acc, 0, 0)
  end

  defp insert(0, _, acc, _, _), do: acc
  defp insert(n, steps, acc, val, pos) do
    acc = List.insert_at(acc, pos, val)
    val = val + 1
    pos = rem(pos + steps, val)
    insert(n - 1, steps, acc, val, pos + 1)
  end
end

Day17.solve(382)
|> IO.inspect()
