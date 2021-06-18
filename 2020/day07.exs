# http://adventofcode.com/2020/day/7

defmodule Day7 do
  def solve(input) do
    map = input_to_map(input)
    s1 = count_parent_bags(map, "shiny gold")
    s2 = count_child_bags(map, "shiny gold")

    {s1, s2}
  end

  def count_parent_bags(map, bag) do
    parent_bags(map, bag) |> Enum.count()
  end

  def parent_bags(map, bag) do
    for {parent, children} <- map, reduce: MapSet.new do
      acc ->
        if Enum.member?(children, bag) do
          MapSet.union(MapSet.put(acc, parent), parent_bags(map, parent))
        else
          acc
        end
    end
  end

  def count_child_bags(map, bag) do
    for b <- map[bag], reduce: Enum.count(map[bag]) do
      acc -> acc + count_child_bags(map, b)
    end
  end

  def input_to_map(input) do
    for line <- input, into: %{}, do: parse_rule(line)
  end

  def parse_rule(rule) do
    [parent, children] = String.split(rule, " contain ")
    parent = String.trim(parent, " bags")

    {parent, parse_children(children)}
  end

  def parse_children(children) do
    String.split(children, ", ")
    |> Enum.map(&parse_child/1)
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
  end

  def parse_child("no other bags."), do: nil

  def parse_child(child) do
    [count, bag] = child
    |> String.replace(~r/\s?bags?\.?/, "")
    |> String.split(" ", parts: 2)

    List.duplicate(bag, String.to_integer(count))
  end
end

File.read!("input/day07.txt")
|> String.split("\n")
|> Day7.solve()
|> IO.inspect()
