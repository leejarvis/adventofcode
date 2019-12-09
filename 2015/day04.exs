# http://adventofcode.com/2015/day/4

defmodule Day4 do
  @key "yzbqklnj"

  def solve() do
    solve(0)
  end

  defp solve(count) do
    case encode(count) do
      "00000" <> _ -> count
      _ -> solve(count + 1)
    end
  end

  defp encode(count) do
    :crypto.hash(:md5, @key <> to_string(count))
    |> Base.encode16()
  end
end

Day4.solve()
|> IO.inspect()
