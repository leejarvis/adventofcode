# https://adventofcode.com/2020/day/12

defmodule Day12 do
  @dirs ["N", "E", "S", "W"]

  def solve(input) do
    ins = parse_instructions(input)
    {x, y, _} = Enum.reduce(ins, {0, 0, "E"}, &move/2)

    s1 = abs(x) + abs(y)
    s2 = 0

    {s1, s2}
  end

  defp move({"N", v}, {x, y, dir}), do: {x, y - v, dir}
  defp move({"E", v}, {x, y, dir}), do: {x + v, y, dir}
  defp move({"S", v}, {x, y, dir}), do: {x, y + v, dir}
  defp move({"W", v}, {x, y, dir}), do: {x - v, y, dir}
  defp move({"F", v}, {x, y, dir}), do: move({dir, v}, {x, y, dir})

  defp move({"R", n}, x), do: turn(div(n, 90), x)
  defp move({"L", n}, x), do: turn(-div(n, 90), x)

  defp turn(times, {x, y, dir}) do
    idx = Enum.find_index(@dirs, & &1 == dir)
    new_dir = case Enum.at(@dirs, idx + times) do
      nil -> Enum.at(@dirs, (idx + times) - 4)
      dir -> dir
    end

    {x, y, new_dir}
  end

  defp parse_instructions(input) do
    for line <- input do
      [action, value] = String.split(line, "", trim: true, parts: 2)
      {action, String.to_integer(value)}
    end
  end
end

File.read!("input/day12.txt")
|> String.split("\n", trim: true)
|> Day12.solve()
|> IO.inspect()
