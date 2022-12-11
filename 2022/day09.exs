# http://adventofcode.com/2022/day/9

defmodule Day9 do
  def solve(input) do
    moves = parse_moves(input)

    one = run(moves) |> MapSet.new() |> Enum.count()
    two = 0

    {one, two}
  end

  defp run(moves) do
    move(moves, [], {0, 0})
  end

  defp move([], tail, _), do: tail

  defp move([{_, 0} | rest], tail, head) do
    move(rest, tail, head)
  end

  defp move([{dir, n} | moves], tail, head) do
    next_head = next_pos(dir, head)
    tail = update_tail(tail, head, next_head)
    move([{dir, n - 1} | moves], tail, next_head)
  end

  defp next_pos("U", {x, y}), do: {x, y - 1}
  defp next_pos("R", {x, y}), do: {x + 1, y}
  defp next_pos("D", {x, y}), do: {x, y + 1}
  defp next_pos("L", {x, y}), do: {x - 1, y}

  defp update_tail([], head, _), do: [head]
  defp update_tail([{px, py} | _] = tail, head, {nx, ny}) do
    if abs(ny - py) < 2 && abs(nx - px) < 2 do
      tail
    else
      [head | tail]
    end
  end

  defp parse_moves(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      [dir, n] = String.split(s, " ", trim: true)
      {dir, String.to_integer(n)}
    end)
  end
end

File.read!("input/day09.txt")
|> Day9.solve()
|> IO.inspect(charlists: :as_lists)
