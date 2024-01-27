# http://adventofcode.com/2017/day/4

defmodule Day4 do
  def valid_passphrase_count(file) do
    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&valid?/1)
    |> Enum.count
  end

  defp valid?(line) do
    line
    |> String.split
    |> Enum.reduce(%{}, fn(x, a) -> Map.update(a, x, 1, &(&1 + 1)) end)
    |> Enum.all?(fn({_, c}) -> c == 1 end)
  end
end

Day4.valid_passphrase_count("res/day4.txt")
|> IO.inspect
