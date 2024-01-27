# https://adventofcode.com/2020/day/11

defmodule Day11 do
  def solve(input) do
    plan = parse(input) |> apply_rules()

    s1 = Map.values(plan) |> Enum.count(& &1 == "#")
    s2 = 0

    {s1, s2}
  end

  def apply_rules(plan) do
    apply_rules(plan, MapSet.new)
  end

  def apply_rules(plan, seen) do
    if MapSet.member?(seen, plan) do
      plan
    else
      apply_rules(adjust_model(plan), MapSet.put(seen, plan))
    end
  end

  def adjust_model(plan) do
    for {seat, c} <- plan, reduce: %{} do
      acc ->
        Map.put(acc, seat, swap(plan, seat, c))
    end
  end

  def swap(_plan, _seat, "."), do: "."

  def swap(plan, seat, "L") do
    cond do
      occupied_adjacent_seat_count(plan, seat) == 0 -> "#"
      true -> "L"
    end
  end

  def swap(plan, seat, "#") do
    cond do
      occupied_adjacent_seat_count(plan, seat) >= 4 -> "L"
      true -> "#"
    end
  end

  def occupied_adjacent_seat_count(plan, seat) do
    adjacent_seats(plan, seat) |> Enum.count(& &1 == "#")
  end

  defp adjacent_seats(plan, {x, y}) do
    [
      plan[{x, y - 1}],
      plan[{x + 1, y - 1}],
      plan[{x + 1, y}],
      plan[{x + 1, y + 1}],
      plan[{x, y + 1}],
      plan[{x - 1, y + 1}],
      plan[{x - 1, y}],
      plan[{x - 1, y - 1}],
    ]
  end

  defp parse(input) do
    for {line, y} <- Enum.with_index(String.split(input, "\n")),
        {char, x} <- Enum.with_index(String.split(line, "", trim: true)), into: %{} do
        {{x, y}, char}
      end
  end
end

File.read!("input/day11.txt")
|> Day11.solve()
|> IO.inspect()
