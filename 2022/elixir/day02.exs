# http://adventofcode.com/2022/day/2

defmodule Day2 do
  # A/X/1 = Rock/Lose, B/Y/2 = Paper/Draw, C/Z/3 = Scissors/Win
  # brute force ¯\_(ツ)_/¯
  def solve(input) do
    rounds =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split/1)
      |> Enum.map(&play/1)

    one = Enum.reduce(rounds, 0, fn {s, _}, a -> s + a end)
    two = Enum.reduce(rounds, 0, fn {_, s}, a -> s + a end)

    {one, two}
  end

  defp play(["A", "Y"]), do: {2 + 6, 1 + 3}
  defp play(["B", "X"]), do: {0 + 1, 0 + 1}
  defp play(["C", "Z"]), do: {3 + 3, 6 + 1}
  defp play(["B", "Y"]), do: {3 + 2, 3 + 2}
  defp play(["A", "Z"]), do: {0 + 3, 6 + 2}
  defp play(["B", "Z"]), do: {6 + 3, 6 + 3}
  defp play(["C", "Y"]), do: {0 + 2, 3 + 3}
  defp play(["C", "X"]), do: {6 + 1, 0 + 2}
  defp play(["A", "X"]), do: {3 + 1, 0 + 3}
end

File.read!("input/day02.txt")
|> Day2.solve()
|> IO.inspect()
