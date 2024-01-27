# http://adventofcode.com/2022/day/6

defmodule Day6 do
  def solve(input) do
    one = signal_marker(input, 0, 4)
    two = signal_marker(input, 0, 14)

    {one, two}
  end

  defp signal_marker(signal, i, marker_length) do
    buff = String.slice(signal, i, marker_length)

    if marker?(buff, marker_length) do
      i + marker_length
    else
      signal_marker(signal, i + 1, marker_length)
    end
  end

  defp marker?(buff, marker_length) do
    buff
    |> String.codepoints()
    |> MapSet.new()
    |> Enum.count() == marker_length
  end
end

File.read!("input/day06.txt")
|> Day6.solve()
|> IO.inspect(charlists: :as_lists)
