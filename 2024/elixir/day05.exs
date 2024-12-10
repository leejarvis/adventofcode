# https://adventofcode.com/2024/day/5

defmodule Day05 do
  def part1(input) do
    {rules, updates} = parse_rules_and_updates(input)

    updates
    |> Enum.filter(&correct_update?(Enum.with_index(&1), rules))
    |> Enum.map(fn n -> Enum.at(n, floor(length(n) / 2)) end)
    |> Enum.sum()
  end

  def part2(input) do
    {rules, updates} = parse_rules_and_updates(input)

    updates
    |> Enum.filter(&(!correct_update?(Enum.with_index(&1), rules)))
    |> Enum.map(&reorder(&1, rules))
    |> Enum.map(fn n -> Enum.at(n, floor(length(n) / 2)) end)
    |> Enum.sum()
  end

  defp reorder(update, _rules) do
    # TODO
    update
  end

  defp correct_update?(update, rules) do
    Enum.all?(update, fn {page, index} ->
      matching_pages = Map.get(rules, page) || []

      update
      |> Enum.slice(0..index)
      |> Enum.filter(fn {p, _} -> p in matching_pages end)
      |> Enum.map(&elem(&1, 1))
      |> Enum.all?(&(&1 > index))
    end)
  end

  defp parse_rules_and_updates(input) do
    [rules, updates] = String.split(input, "\n\n", trim: true)

    {
      String.split(rules, "\n", trim: true) |> Enum.reduce(%{}, &parse_rule/2),
      String.split(updates, "\n", trim: true) |> Enum.map(&parse_update/1)
    }
  end

  defp parse_rule(rule, rules) do
    [key, val] =
      String.split(rule, "|", trim: true) |> Enum.map(&String.to_integer/1)

    case Map.get(rules, key) do
      nil -> Map.put(rules, key, [val])
      existing -> Map.put(rules, key, [val | existing])
    end
  end

  defp parse_update(update) do
    String.split(update, ",") |> Enum.map(&String.to_integer/1)
  end
end

"""
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
"""
|> then(fn input ->
  {
    Day05.part1(input),
    Day05.part2(input)
  }
  |> IO.inspect()
end)
