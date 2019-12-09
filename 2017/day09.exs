# http://adventofcode.com/2017/day/9

defmodule Day9 do
  def solve(input), do: parse(input, 1)

  defp parse("{" <> r, depth), do: depth + parse(r, depth + 1)
  defp parse("}" <> r, depth), do: parse(r, depth - 1)
  defp parse("<" <> r, depth), do: garbage(r, depth)
  defp parse("," <> r, depth), do: parse(r, depth)
  defp parse("\n", _), do: 0

  defp garbage("!" <> <<_ :: binary-size(1)>> <> r, depth), do: garbage(r, depth)
  defp garbage(">" <> r, depth), do: parse(r, depth)
  defp garbage(<<_::bytes-size(1)>> <> r, depth), do: garbage(r, depth)
end

File.read!("res/day9.txt")
|> Day9.solve()
|> IO.inspect()
