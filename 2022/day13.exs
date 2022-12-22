# http://adventofcode.com/2022/day/13

defmodule Day13 do
  def solve(input) do
    pairs = parse_pairs(input)

    one = correct_indices(pairs) |> Enum.sum()
    two = 0

    {one, two}
  end

  defp correct_indices(pairs) do
    for {[left, right], index} <- Enum.with_index(pairs, 1), compare(left, right) == :lt do
      index
    end
  end

  def compare([], [_ | _]), do: :lt
  def compare([_ | _], []), do: :gt
  def compare([], []), do: :eq

  def compare([l | lr], [r | rr]) when is_integer(l) and is_integer(r) do
    cond do
      l < r -> :lt
      l > r -> :gt
      true -> compare(lr, rr)
    end
  end

  def compare([l | lr], [r | rr]) when is_list(l) and is_list(r) do
    case compare(l, r) do
      :eq -> compare(lr, rr)
      value -> value
    end
  end

  def compare([l | lr], [r | rr]) when is_list(l) and is_integer(r) do
    compare([l | lr], [[r] | rr])
  end

  def compare([l | lr], [r | rr]) when is_integer(l) and is_list(r) do
    compare([[l] | lr], [r | rr])
  end

  defp parse_pairs(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn block ->
      block
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> Code.eval_string()
        |> elem(0)
      end)
    end)
  end
end

File.read!("input/day13.txt")
|> Day13.solve()
|> IO.inspect(charlists: :as_lists)
