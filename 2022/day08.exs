# http://adventofcode.com/2022/day/8

defmodule Day8 do
  def solve(input) do
    map = tree_map(input)

    one = count_visible_trees(map)
    two = highest_scenic_score(map)

    {one, two}
  end

  def highest_scenic_score(map) do
    map
    |> Enum.map(fn {tree, _} -> scenic_score(map, tree) end)
    |> Enum.max()
  end

  def scenic_score(map, tree) do
    Enum.map([{0, -1}, {0, 1}, {-1, 0}, {1, 0}], fn delta ->
      Enum.count(visible_scenic_trees(map, map[tree], tree, delta))
    end)
    |> Enum.product()
  end

  def count_visible_trees(map) do
    Enum.count(map, fn
      {pos, tree} ->
        Enum.all?(visible_trees(map, pos, {0, -1}), &(map[&1] < tree)) ||
          Enum.all?(visible_trees(map, pos, {0, 1}), &(map[&1] < tree)) ||
          Enum.all?(visible_trees(map, pos, {-1, 0}), &(map[&1] < tree)) ||
          Enum.all?(visible_trees(map, pos, {1, 0}), &(map[&1] < tree))
    end)
  end

  def visible_scenic_trees(map, curr, {x, y}, {dx, dy}) do
    next = {x + dx, y + dy}

    case map[next] do
      nil -> []
      tree when tree < curr -> [next | visible_scenic_trees(map, curr, next, {dx, dy})]
      _ -> [next]
    end
  end

  def visible_trees(map, {x, y}, {dx, dy}) do
    next = {x + dx, y + dy}

    case map[next] do
      nil -> []
      tree when tree > 9 -> [next]
      _ -> [next | visible_trees(map, next, {dx, dy})]
    end
  end

  defp tree_map(input) do
    for {row, y} <- Enum.with_index(String.split(input, "\n", trim: true)),
        {tree, x} <- Enum.with_index(String.codepoints(row)),
        into: %{},
        do: {{x, y}, String.to_integer(tree)}
  end
end

File.read!("input/day08.txt")
|> Day8.solve()
|> IO.inspect(charlists: :as_lists)
