defmodule Y2021.Day01 do
  use Advent.Day

  @doc """
  iex> Day01.part1([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
  7
  """
  def part1(input) do
    input
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  @doc """
  iex> Day01.part2([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
  5
  """
  def part2(input) do
    input
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> Enum.sum(b) > Enum.sum(a) end)
  end

  @impl Advent.Day
  def parse_input(input), do: input_to_ints(input)
end
