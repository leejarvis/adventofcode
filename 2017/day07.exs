# http://adventofcode.com/2017/day/7

defmodule Day7 do
  # The root is the only item in the structure that contains
  # sub-towers and is also not included in any other sub-towers
  # so we can just cheat..
  def find_root(file) do
    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_line/1)
    |> Enum.into([])
    |> collect([], MapSet.new)
    |> find()
  end

  defp find({roots, subs}) do
    Enum.find(roots, &(!MapSet.member?(subs, &1)))
  end

  defp collect([], root_acc, subs_acc), do: {root_acc, subs_acc}
  defp collect([{name, _weight, subs} | rest], root_acc, subs_acc) do
    collect(rest, [name | root_acc], map_put(subs_acc, subs))
  end

  defp map_put(map, []), do: map
  defp map_put(map, [x | r]), do: map_put(MapSet.put(map, x), r)

  defp parse_line(input) do
    case Regex.run(~r/\A(\S+) \((\d+)\)(?: -> (.+))?\z/, input) do
      [_, name, weight] ->
        {name, weight, []}
      [_, name, weight, subs] ->
        {name, weight, String.split(subs, ",") |> Enum.map(&String.trim/1)}
    end
  end
end

Day7.find_root("res/day7.txt")
|> IO.inspect
