# https://adventofcode.com/2024/day/12

Mix.install([{:libgraph, "~> 0.16.0"}])

defmodule Day12 do
  def part1(input) do
    map = to_map(input)
    graph = to_graph(map)

    # UGH should have added perimeter nodes to graph to avoid
    # region_price using map, or just avoided libgraph altogether
    # whatever
    group_regions(graph)
    |> Enum.map(&region_price(map, &1))
    |> Enum.sum()
  end

  def part2(_input) do
    0
  end

  # elixir day12.exs && open /tmp/output.png
  # defp to_dot(graph) do
  #   output =
  #     graph
  #     |> Graph.to_dot()
  #     |> elem(1)

  #   File.write!("/tmp/output.dot", output)
  #   System.shell("/opt/homebrew/bin/sfdp -Tpng /tmp/output.dot > /tmp/output.png")

  #   graph
  # end

  defp region_price(map, region) do
    Enum.count(region) * region_perimeter(map, region)
  end

  defp region_perimeter(map, region) do
    region
    |> Enum.map(fn point ->
      neighbours(point)
      |> Enum.count(fn neighbor ->
        Map.get(map, neighbor) != Map.get(map, point)
      end)
    end)
    |> Enum.sum()
  end

  defp group_regions(graph) do
    graph
    |> Graph.vertices()
    |> Enum.map(fn vertex ->
      Graph.reachable(graph, [vertex]) |> Enum.sort()
    end)
    |> Enum.uniq()
  end

  defp to_graph(map) do
    Enum.reduce(map, Graph.new(), fn {point, type}, graph ->
      Enum.reduce(neighbours(point), Graph.add_vertex(graph, point, type), fn neighbour, graph ->
        case Map.get(map, neighbour) do
          neighbour_type when neighbour_type == type ->
            graph
            |> Graph.add_vertex(neighbour, neighbour_type)
            |> Graph.add_edge(point, neighbour, label: type)
            |> Graph.add_edge(neighbour, point, label: type)

          _ ->
            graph
        end
      end)
    end)
  end

  defp neighbours({x, y}) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}]
  end

  defp to_map(input) do
    for {row, y} <- Enum.with_index(String.split(input, "\n", trim: true)),
        {val, x} <- Enum.with_index(String.split(row, "", trim: true)),
        into: %{},
        do: {{x, y}, val}
  end
end

"""
AAAA
BBCD
BBCC
EEEC
"""
|> then(fn input ->
  {
    Day12.part1(input),
    Day12.part2(input)
  }
  |> IO.inspect()
end)
