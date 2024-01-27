# http://adventofcode.com/2022/day/14

defmodule Day14 do
  @source {500, 0}

  def solve(input) do
    parse_cave(%{}, input)
    |> simulate_falling(@source)
    |> sand_count()
  end

  defp simulate_falling(cave, {x, y} = point) do
    if y >= cave_floor(cave) do
      cave
    else
      next_point =
        Enum.find([{x, y + 1}, {x-1, y+1}, {x+1, y+1}], fn candidate ->
          Map.get(cave, candidate) == nil
        end)

      if next_point == nil do
        cave = Map.put(cave, point, :sand) # come to rest
        simulate_falling(cave, @source)
      else
        simulate_falling(cave, next_point)
      end
    end
  end

  defp cave_floor(cave) do
    Enum.max(for {{_, y}, _} <- cave, do: y)
  end

  defp sand_count(cave) do
    Map.values(cave) |> Enum.count(fn v -> v == :sand end)
  end

  defp parse_cave(cave, input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(cave, &parse_line/2)
    |> Map.put(@source, :source)
  end

  defp parse_line(line, cave) do
    line
    |> String.split(" -> ")
    |> Enum.map(fn point ->
      [x, y] = String.split(point, ",")
      {String.to_integer(x), String.to_integer(y)}
    end)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.flat_map(&connect_points/1)
    |> Enum.reduce(cave, fn points, cave ->
      Map.put(cave, points, :rock)
    end)
  end

  defp connect_points([{x1, y1}, {x2, y2}]) do
    for dx <- x1..x2, dy <- y1..y2 do
      {dx, dy}
    end
  end

  defp print_cave(cave) do
    for y <-  0..9 do
      for x <- 494..503 do
        IO.write(point_to_symbol(Map.get(cave, {x, y})))
      end
      IO.puts("")
    end
    cave
  end

  defp point_to_symbol(nil), do: "." # nil = air
  defp point_to_symbol(:rock), do: "#"
  defp point_to_symbol(:sand), do: "o"
  defp point_to_symbol(:source), do: "+"
end

# """
# 498,4 -> 498,6 -> 496,6
# 503,4 -> 502,4 -> 502,9 -> 494,9
# """
File.read!("input/day14.txt")
|> Day14.solve()
|> IO.inspect(charlists: :as_lists)
