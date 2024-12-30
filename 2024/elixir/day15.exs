# https://adventofcode.com/2024/day/15

defmodule Day15 do
  def part1(input) do
    {map, movements} = parse(input)

    map =
      Enum.reduce(movements, map, fn move, map ->
        # IO.puts("Move #{move}:")

        move(map, robot(map), move)
        # |> print_map()
      end)

    gps_sum(map)
  end

  defp gps_sum(map) do
    Enum.reduce(map, 0, fn {{x, y}, v}, acc ->
      case v do
        "O" -> acc + 100 * y + x
        _ -> acc
      end
    end)
  end

  defp move(map, robot, dir) do
    next_pos = next_pos(robot, dir)

    case Map.get(map, next_pos) do
      "#" ->
        map

      "O" ->
        shift_boxes(map, robot, dir)

      "." ->
        map
        |> Map.replace(robot, ".")
        |> Map.replace(next_pos, "@")
    end
  end

  defp shift_boxes(map, robot, dir) do
    case find_space(map, robot, dir) do
      nil ->
        map

      point ->
        # Found a space, replace it with the wall and then
        # move the robot to the first position, and replace that
        # with an empty space
        map
        |> Map.put(point, "O")
        |> Map.put(next_pos(robot, dir), "@")
        |> Map.put(robot, ".")
    end
  end

  defp find_space(map, pos, dir) do
    next_pos = next_pos(pos, dir)

    case Map.get(map, next_pos) do
      "." -> next_pos
      "#" -> nil
      _ -> find_space(map, next_pos, dir)
    end
  end

  defp next_pos({x, y}, dir) do
    case dir do
      "^" -> {x, y - 1}
      ">" -> {x + 1, y}
      "v" -> {x, y + 1}
      "<" -> {x - 1, y}
    end
  end

  defp parse(input) do
    input
    |> String.split("\n\n", trim: true)
    |> then(fn [map, movements] ->
      {to_map(map), String.graphemes(movements) |> Enum.reject(&(&1 == "\n"))}
    end)
  end

  defp robot(map) do
    Enum.find(map, fn {_, v} -> v == "@" end) |> elem(0)
  end

  defp print_map(map) do
    max_x = Enum.map(map, fn {{x, _}, _} -> x end) |> Enum.max()
    max_y = Enum.map(map, fn {{_, y}, _} -> y end) |> Enum.max()

    for row <- 0..max_y do
      for col <- 0..max_x do
        IO.write(Map.get(map, {col, row}))
      end

      IO.puts("")
    end

    IO.puts("")

    map
  end

  defp to_map(input) do
    for {row, y} <- Enum.with_index(String.split(input, "\n", trim: true)),
        {val, x} <- Enum.with_index(String.split(row, "", trim: true)),
        into: %{},
        do: {{x, y}, val}
  end
end

"""
########
#..O.O.#
##@.O..#
#...O..#
#.#.O..#
#...O..#
#......#
########

<^^>>>vv<v>>v<<
"""
|> then(fn input ->
  Day15.part1(input)
  |> IO.inspect()
end)
