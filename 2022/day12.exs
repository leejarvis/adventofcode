# http://adventofcode.com/2022/day/12

Mix.install([:libgraph])

defmodule Day12 do

  def solve(input) do
    grid = parse_input(input)

    {start_point, _} = Enum.find(grid, fn {_, v} -> v == ?S end)
    {end_point, _} = Enum.find(grid, fn {_, v} -> v == ?E end)

    grid = Map.put(grid, start_point, ?a) |> Map.put(end_point, ?z)

    path =
      grid2graph(grid)
      |> Graph.dijkstra(start_point, end_point)

    one = length(path) - 1
    two = 0

    {one, two}
  end

  defp grid2graph(grid) do
    Enum.reduce(grid, Graph.new, fn {point, ele}, graph ->
      Enum.reduce(neighbours(point), graph, fn p2, graph ->
        n_ele = Map.get(grid, p2, -1)

        if n_ele - ele <= 1 or (ele in [?a - 1, ?z + 1] and n_ele > 0) do
          Graph.add_edge(graph, point, p2)
        else
          graph
        end
      end)
    end)
  end

  defp neighbours({x, y}) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}]
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> then(fn rows ->
      for {row, y} <- Enum.with_index(rows),
          {col, x} <- Enum.with_index(String.codepoints(row)),
          into: %{},
          do: {{x, y}, :binary.first(col)}
    end)
  end
end

File.read!("input/day12.txt")
|> Day12.solve()
|> IO.inspect(charlists: :as_lists)
