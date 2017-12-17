# http://adventofcode.com/2017/day/16

defmodule Day16 do
  def solve(input) do
    dance(programs(), input) |> Enum.join()
  end

  defp programs(), do: for n <- ?a..?p, do: << n :: utf8 >>

  defp dance(programs, []), do: programs
  defp dance(programs, [move | moves]) do
    move(programs, move)
    |> dance(moves)
  end

  defp move(p, "s" <> m),
    do: spin(p, String.to_integer(m))
  defp move(p, "x" <> m),
    do: exchange(p, String.split(m, "/") |> Enum.map(&String.to_integer/1))
  defp move(p, "p" <> m),
    do: partner(p, String.split(m, "/"))

  defp spin(list, 0), do: list
  defp spin(list, n) do
    {el, list} = List.pop_at(list, -1)
    spin([el | list], n - 1)
  end

  defp exchange(list, [p1, p2]) do
    list
    |> List.replace_at(p1, Enum.at(list, p2))
    |> List.replace_at(p2, Enum.at(list, p1))
  end

  defp partner(list, [v1, v2]) do
    i1 = Enum.find_index(list, &(&1 == v1))
    i2 = Enum.find_index(list, &(&1 == v2))
    exchange(list, [i1, i2])
  end
end

File.read!("res/day16.txt")
|> String.trim_trailing()
|> String.split(",")
|> Day16.solve()
|> IO.inspect()
