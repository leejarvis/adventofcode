# http://adventofcode.com/2017/day/19

defmodule Day19 do
  def solve() do
    %{
      x: 0,
      y: 0,
      dir: :down
    } |> move(map())
  end

  defp move(state, [row | rest]) do
    %{state | y: Enum.find_index(row, &(&1 == "|"))}
    |> move(rest, [])
  end

  defp move(state, map, letters) do
    state
  end

  defp map() do
    File.stream!("res/day19.txt")
    |> Stream.map(&(String.split(&1, "")))
    |> Stream.map(&(Enum.take_while(&1, fn(x) -> x != "\n" end)))
    |> Enum.into([])
  end
end

Day19.solve() |> IO.inspect(limit: :infinity)
