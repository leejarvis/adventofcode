# http://adventofcode.com/2017/day/6

defmodule Day6 do
  def count_cycles(input) do
    banks(input)
    |> redistribute(MapSet.new)
  end

  defp redistribute(banks, store) do
    cond do
      recorded?(banks, store) -> Enum.count(store)
      true -> do_redistribute(banks, MapSet.put(store, Map.values(banks)))
    end
  end

  defp do_redistribute(banks, store) do
    {index, blocks} = Enum.max_by(banks, fn({_, v}) -> v end)
    banks = Map.put(banks, index, 0)
    banks = do_redistribute(banks, index, blocks)
    redistribute(banks, store)
  end

  defp do_redistribute(banks, _index, 0), do: banks
  defp do_redistribute(banks, index, blocks) do
    index = cond do
      index == (Enum.count(banks) - 1) -> 0
      true -> index + 1
    end
    banks = Map.put(banks, index, Map.get(banks, index) + 1)
    do_redistribute(banks, index, blocks - 1)
  end

  defp recorded?(banks, store) do
    snapshot = banks
    |> Enum.sort_by(&(elem(&1, 0)))
    |> Enum.map(&(elem(&1, 1)))

    MapSet.member?(store, snapshot)
  end

  defp banks(input) do
    input
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index
    |> Enum.into(%{}, fn({v, k}) -> {k, v} end)
  end
end

input = "2 8 8 5 4 2 3 1 5 5 1 2 15 13 5 14"
Day6.count_cycles(input)
|> IO.inspect
