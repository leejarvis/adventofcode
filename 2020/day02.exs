# http://adventofcode.com/2020/day/2

defmodule Day2 do
  @regex ~r/(\d+)-(\d+) ([a-z]): (\S+)/

  def solve(input) do
    parsed_inputs = Enum.map(input, &parse_input/1)

    valid_1 = Enum.filter(parsed_inputs, &valid_1?/1) |> Enum.count()
    valid_2 = Enum.filter(parsed_inputs, &valid_2?/1) |> Enum.count()

    {valid_1, valid_2}
  end

  defp valid_1?({{min, max}, c, s}) do
    occurences = String.graphemes(s) |> Enum.count(& &1 == c)
    occurences >= min && occurences <= max
  end

  defp valid_2?({{pos1, pos2}, c, s}) do
    chars = [String.at(s, pos1 - 1), String.at(s, pos2 - 1)]
    Enum.count(chars, & &1 == c) == 1
  end

  defp parse_input(input) do
    [min, max, c, s] = Regex.run(@regex, input, capture: :all_but_first)
    [min, max] = [String.to_integer(min), String.to_integer(max)]
    {{min, max}, c, s}
  end
end

File.read!("input/day02.txt")
|> String.split("\n")
|> Day2.solve()
|> IO.inspect()
