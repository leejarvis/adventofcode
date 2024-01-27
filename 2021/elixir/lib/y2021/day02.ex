defmodule Y2021.Day02 do
  use Advent.Day

  @doc ~S"""
  iex> Day02.part1([
  ...> {"forward", 5},
  ...> {"down", 5},
  ...> {"forward", 8},
  ...> {"up", 3},
  ...> {"down", 8},
  ...> {"forward", 2}])
  150
  """
  def part1(input) do
    Enum.reduce(input, {0, 0}, &move/2) |> multiply_position()
  end

  @doc ~S"""
  iex> Day02.part2([
  ...> {"forward", 5},
  ...> {"down", 5},
  ...> {"forward", 8},
  ...> {"up", 3},
  ...> {"down", 8},
  ...> {"forward", 2}])
  900
  """
  def part2(input) do
    Enum.reduce(input, {0, 0, 0}, &aim/2) |> multiply_position()
  end

  defp move({"forward", c}, {x, y}), do: {x + c, y}
  defp move({"down", c}, {x, y}), do: {x, y - c}
  defp move({"up", c}, {x, y}), do: {x, y + c}

  defp aim({"forward", c}, {x, y, a}), do: {x + c, y - (a * c), a}
  defp aim({"down", c}, {x, y, a}), do: {x, y, a + c}
  defp aim({"up", c}, {x, y, a}), do: {x, y, a - c}

  defp multiply_position({x, y}), do: abs(x) * abs(y)
  defp multiply_position({x, y, _}), do: abs(x) * abs(y)

  @impl Advent.Day
  def parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(fn line ->
      [dir, n] = String.split(line)
      {dir, String.to_integer(n)}
    end)
  end
end
