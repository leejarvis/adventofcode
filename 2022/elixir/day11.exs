# http://adventofcode.com/2022/day/11

defmodule Day11 do
  def solve(input) do
    monkeys = parse_input(input)

    one = run_rounds(monkeys, 20) |> monkey_business()
    # FIXME: Part 2 takes too long but I suck at math
    # two = run_rounds(monkeys, 10_000) |> monkey_business()
    two = 0

    {one, two}
  end

  defp monkey_business(monkeys) do
    monkeys
    |> Map.values()
    |> Enum.map(&(&1.inspected))
    |> Enum.sort()
    |> Enum.take(-2)
    |> then(fn [a, b] -> a * b end)
  end

  defp run_rounds(monkeys, n) do
    run_rounds(monkeys, n, n)
  end

  defp run_rounds(monkeys, _, 0), do: monkeys

  defp run_rounds(monkeys, n, x) do
    run_rounds(run_round(monkeys), n, x - 1)
  end

  defp run_round(monkeys) do
    Enum.reduce(monkeys, monkeys, fn {i, _}, m ->
      inspect_next(m, i)
    end)
  end

  defp inspect_next(monkeys, n) do
    monkey = monkeys[n]

    if monkey.items == [] do
      monkeys
    else
      [item | items] = monkey.items
      monkeys = put_in(monkeys, [n, :items], items)
      monkeys = update_in(monkeys, [n, :inspected], &(&1 + 1))
      item = run_op(item, monkey.op)
      item = decrease_worry(item)
      next_monkey = run_test(item, monkey)
      monkeys = update_in(monkeys, [next_monkey, :items], &(&1 ++ [item]))
      inspect_next(monkeys, n)
    end
  end

  defp run_op(item, op) do
    case String.split(op) do
      [x, "old"] -> run_op(item, "#{x} #{item}")
      ["*", n] -> item * String.to_integer(n)
      ["+", n] -> item + String.to_integer(n)
    end
  end

  defp run_test(item, monkey) do
    if rem(item, monkey.div_by) == 0 do
      monkey.true_monkey
    else
      monkey.false_monkey
    end
  end

  def decrease_worry(item) do
    div(item, 3)
  end

  defp parse_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&parse_monkey/1)
    |> Enum.with_index()
    |> Enum.map(fn {k, i} -> {i, k} end)
    |> Map.new()
  end

  defp parse_monkey(input) do
    [items, op, test, true_monkey, false_monkey] =
      String.split(input, "\n", trim: true)
      |> Enum.drop(1)
      |> Enum.map(&String.trim/1)

    %{
      items: parse_items(items),
      inspected: 0,
      op: parse_op(op),
      div_by: parse_div_by(test),
      true_monkey: parse_test_result(true_monkey),
      false_monkey: parse_test_result(false_monkey)
    }
  end

  defp parse_items(items) do
    [_, _, items] = String.split(items, " ", parts: 3)
    String.split(items, ",", trim: true) |> Enum.map(&to_int/1)
  end

  defp parse_op(op) do
    String.split(op, "old", parts: 2) |> Enum.at(-1) |> String.trim()
  end

  defp parse_div_by(str) do
    String.split(str, " ") |> Enum.at(-1) |> String.to_integer()
  end

  defp parse_test_result(test_res) do
    test_res
    |> String.reverse()
    |> String.codepoints()
    |> List.first()
    |> to_int()
  end

  defp to_int(string), do: String.trim(string) |> String.to_integer()
end

File.read!("input/day11.txt")
|> Day11.solve()
|> IO.inspect(charlists: :as_lists)
