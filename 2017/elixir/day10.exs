# http://adventofcode.com/2017/day/9

defmodule Day10 do
  def solve(lengths) do
    solve(Enum.to_list(0..255), lengths, 0, 0)
    |> Enum.take(2)
    |> Enum.reduce(fn(x, acc) -> acc * x end)
  end

  defp solve(list, [], _, _), do: list
  defp solve(list, lengths, pos, skip) when pos >= length(list) do
    solve(list, lengths, pos - Enum.count(list), skip)
  end

  defp solve(list, [len | lengths], pos, skip) do
    rotate_reverse(list, pos, len)
    |> solve(lengths, pos + len + skip, skip + 1)
  end

  def rotate_reverse(list, index, length) do
    rotate(list, index)
    |> reverse(length)
    |> rotate(-index)
  end

  defp reverse(list, length) do
    Enum.reverse(Enum.slice(list, 0, length)) ++
      Enum.slice(list, length, Enum.count(list))
  end

  def rotate(list, index) do
    rotate(list, [], index)
  end

  defp rotate(prev, next, _index)
    when length(prev) == length(next),
    do: Enum.reverse(next)

  defp rotate(prev, next, index)
    when index == length(prev),
    do: rotate(prev, next, 0)

  defp rotate(prev, next, index) do
    rotate(prev, [Enum.at(prev, index) | next], index + 1)
  end
end

[130,126,1,11,140,2,255,207,18,254,246,164,29,104,0,224]
|> Day10.solve()
|> IO.inspect()
