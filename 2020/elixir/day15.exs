# https://adventofcode.com/2020/day/15

defmodule Day15 do
  def solve(numbers) do
    s1 = number_spoken(numbers, 2020)
    s2 = number_spoken(numbers, 30000000)

    {s1, s2}
  end

  def number_spoken(numbers, number) do
    numbers
    |> Enum.with_index(1)
    |> Enum.into(%{})
    |> next_turn(Enum.count(numbers) + 1, 0, number)
  end

  def next_turn(_spoken, turn, prev, number) when turn == number, do: prev

  def next_turn(spoken, turn, prev, number) do
    case Map.get(spoken, prev) do
      nil ->
        next_turn(Map.put(spoken, prev, turn), turn + 1, 0, number)
      prev_seen ->
        next_turn(Map.put(spoken, prev, turn), turn + 1, turn - prev_seen, number)
    end
  end
end

"0,5,4,1,10,14,7"
|> String.split(",", trim: true)
|> Enum.map(&String.to_integer/1)
|> Day15.solve()
|> IO.inspect()
