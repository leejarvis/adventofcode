# http://adventofcode.com/2017/day/5

defmodule Day5 do
  @part2 true # yes this is very slow..

  def count_steps(list) when is_list(list) do
    count(list, 0, 0)
  end

  def count_steps(input_file) do
    input_file
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.into([])
    |> count_steps
  end

  defp count(list, pos, steps) do
    cond do
      pos == Enum.count(list) -> steps
      true ->
        curr = Enum.at(list, pos)

        inc = if @part2 && curr >= 3 do
          -1
        else
          1
        end

        list = List.replace_at(list, pos, curr + inc)

        count(list, pos + curr, steps + 1)
    end
  end
end

Day5.count_steps("res/day5.txt")
|> IO.inspect
