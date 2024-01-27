# http://adventofcode.com/2015/day/1

defmodule Day1 do
  def count(input), do: count(input, 0)
  defp count("\n", acc), do: acc
  defp count("(" <> r, acc), do: count(r, acc + 1)
  defp count(")" <> r, acc), do: count(r, acc - 1)

  def basement(input), do: basement(input, 0, 0)
  defp basement("\n", _, _), do: raise "oops"
  defp basement(_, -1, index), do: index
  defp basement("(" <> r, acc, index), do: basement(r, acc + 1, index + 1)
  defp basement(")" <> r, acc, index), do: basement(r, acc - 1, index + 1)
end

File.read!("res/day1.txt")
|> Day1.count()
|> IO.inspect()

File.read!("res/day1.txt")
|> Day1.basement()
|> IO.inspect()
