# https://adventofcode.com/2024/day/16

Mix.install([{:libgraph, "~> 0.16.0"}])

defmodule Day16 do
  def part1(input) do
    {map, start, finish} = to_map(input)

    graph =
      Enum.reduce(map, Graph.new(), fn {{x, y}, val}, graph ->
        if val == "#" do
          graph
        else
          Enum.reduce([{0, 1}, {0, -1}, {1, 0}, {-1, 0}], graph, fn {dx, dy}, graph ->
            nx = x + dx
            ny = y + dy

            if Map.get(map, {nx, ny}) in [".", "S", "E"] do
              Graph.add_edge(graph, {x, y}, {nx, ny})
            else
              graph
            end
          end)
        end
      end)

    # IO.inspect({start, finish})
    # Graph.get_paths(graph, start, finish) |> Enum.count()
  end

  defp to_map(input) do
    map =
      for {row, y} <- Enum.with_index(String.split(input, "\n", trim: true)),
          {val, x} <- Enum.with_index(String.split(row, "", trim: true)),
          into: %{},
          do: {{x, y}, val}

    {start, _} = Enum.find(map, fn {_, v} -> v == "S" end)
    {finish, _} = Enum.find(map, fn {_, v} -> v == "E" end)

    {map, start, finish}
  end
end

"""
###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############
"""
|> then(fn input ->
  Day16.part1(input)
  |> IO.inspect()
end)
