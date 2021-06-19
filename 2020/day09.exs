# https://adventofcode.com/2020/day/9

defmodule Day9 do
  @length 25

  def solve(input) do
    s1 = invalid_number(input, @length)
    s2 = contiguous_sum(input, s1)

    {s1, s2}
  end

  def invalid_number(input, ptr) do
    pattern = Enum.slice(input, ptr - @length, @length)
    number = Enum.fetch!(input, ptr)

    if valid_number?(pattern, number) do
      invalid_number(input, ptr + 1)
    else
      number
    end
  end

  def valid_number?(pattern, number) do
    Enum.any?(pattern, fn(x) ->
      Enum.any?(pattern, fn(y) ->
        x != y && x + y == number
      end)
    end)
  end

  def contiguous_sum(input, number) do
    contiguous_sum(input, 0, 2, number)
  end

  def contiguous_sum(input, idx, n, number) do
    range = Enum.slice(input, idx, n)
    sum = Enum.sum(range)

    cond do
      sum == number ->
        Enum.min_max(range) |> Tuple.to_list() |> Enum.sum()
      sum > number ->
        contiguous_sum(input, idx + 1, 2, number)
      true ->
        contiguous_sum(input, idx, n + 1, number)
    end
  end
end

File.read!("input/day09.txt")
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Day9.solve()
|> IO.inspect()
