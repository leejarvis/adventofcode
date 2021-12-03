defmodule Y2021.Day03 do
  use Advent.Day

  @doc """
  iex> Day03.part1(["00100", "11110", "10110", "10111", "10101", "01111",
  ...>              "00111", "11100", "10000", "11001", "00010", "01010"])
  198
  """
  def part1(input) do
    gamma = input |> columnize() |> gamma_rate()
    epsilon = input |> columnize() |> epsilon_rate()

    gamma * epsilon
  end

  def part2(_input) do
    nil
  end

  defp columnize(input) do
    input
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp gamma_rate(input), do: find(input, &Enum.max_by/2)
  defp epsilon_rate(input), do: find(input, &Enum.min_by/2)

  def find(input, finder) do
    input
    |> Enum.map(fn row ->
      {v, _} = finder.(Enum.frequencies(row), fn {_, f} -> f end)
      v
    end)
    |> to_string()
    |> String.to_integer(2)
  end

  @impl Advent.Day
  def parse_input(input), do: String.split(input, "\n", trim: true)
end
