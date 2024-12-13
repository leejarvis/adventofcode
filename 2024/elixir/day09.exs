# https://adventofcode.com/2024/day/9

defmodule Day09 do
  def part1(input) do
    input
    |> parse()
    |> blocks()
    |> move()
    |> checksum()
  end

  def part2(_input) do
    0
  end

  defp move(blocks) do
    move(blocks, [])
  end

  defp move([], right) do
    Enum.reverse(right)
  end

  defp move(["." | rest], right) do
    case List.pop_at(rest, -1) do
      {".", rest} ->
        move(["." | rest], right)

      {nil, _} ->
        right

      {block, rest} ->
        move(rest, [block | right])
    end
  end

  defp move([block | rest], right) do
    move(rest, [block | right])
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.graphemes()
    |> Enum.chunk_every(2)
    |> Enum.with_index()
    |> Enum.map(fn
      {[file, space], id} -> {id, String.to_integer(file), String.to_integer(space)}
      {[file], id} -> {id, String.to_integer(file), 0}
    end)
  end

  defp checksum(blocks) do
    blocks
    |> Enum.map(fn
      "." -> 0
      id -> id
    end)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {block_id, pos}, acc ->
      acc + pos * block_id
    end)
  end

  defp blocks(diskmap) do
    Enum.reduce(diskmap, [], fn {id, file, space}, blocks ->
      blocks ++ List.duplicate(id, file) ++ List.duplicate(".", space)
    end)
  end
end

"""
2333133121414131402
"""
|> then(fn input ->
  {
    Day09.part1(input),
    Day09.part2(input)
  }
  |> IO.inspect()
end)
