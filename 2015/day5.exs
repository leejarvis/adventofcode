# http://adventofcode.com/2015/day/5

defmodule Day5 do
  @naughty ["ab", "cd", "pq", "xy"]

  def solve(file) do
    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&nice?/1)
    |> Enum.count()
  end

  def nice?(string) do
    three_vowels?(string) &&
      pairs?(string) &&
      !naughty?(string)
  end

  defp three_vowels?(string) do
    Enum.count(Regex.scan(~r/[aeiou]/, string)) >= 3
  end

  defp pairs?(string) do
    string
    |> String.split("")
    |> Enum.chunk(2, 1)
    |> Enum.any?(fn([a, b]) -> a == b end)
  end

  defp naughty?(string) do
    Enum.any?(@naughty, fn(x) -> String.contains?(string, x) end)
  end
end

Day5.solve("res/day5.txt")
|> IO.inspect()
