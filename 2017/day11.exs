# http://adventofcode.com/2017/day/11

# This was helpful:
# http://keekerdc.com/2011/03/hexagon-grids-coordinate-systems-and-distance-calculations/

defmodule Day11 do
  def solve(input) do
    input
    |> Enum.reduce(%{x: 0, y: 0, z: 0}, &move/2)
    |> Map.values()
    |> Enum.map(&abs/1)
    |> Enum.max()
  end

  defp move("n",  %{x: x, y: y, z: z}), do: %{x: x, y: y + 1, z: z - 1}
  defp move("ne", %{x: x, y: y, z: z}), do: %{x: x + 1, y: y, z: z - 1}
  defp move("nw", %{x: x, y: y, z: z}), do: %{x: x - 1, y: y + 1, z: z}
  defp move("s",  %{x: x, y: y, z: z}), do: %{x: x, y: y - 1, z: z + 1}
  defp move("se", %{x: x, y: y, z: z}), do: %{x: x + 1, y: y - 1, z: z}
  defp move("sw", %{x: x, y: y, z: z}), do: %{x: x - 1, y: y, z: z + 1}
end

File.read!("res/day11.txt")
|> String.trim_trailing()
|> String.split(",")
|> Day11.solve()
|> IO.inspect()
