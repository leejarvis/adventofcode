defmodule Day22 do
  def part1(input, deck_size) do
    Enum.to_list(0..deck_size-1)
    |> shuffle(input)
    |> Enum.find_index(&(&1 == 2019))
  end

  def shuffle(deck, input) do
    Enum.reduce(input, deck, fn(ins, d) ->
      case ins do
        "cut " <> n ->
          Enum.split(d, String.to_integer(n))
          |> Tuple.to_list()
          |> Enum.reduce(&Enum.concat/2)
        "deal with increment " <> n ->
          increment(d, String.to_integer(n), Enum.count(d), 0, %{})
        _ -> Enum.reverse(d)
      end
    end)
  end

  def increment([], _, _, _, acc) do
    Map.keys(acc) |> Enum.sort() |> Enum.map(&(acc[&1]))
  end

  def increment([h | r], n, count, pc, acc) do
    increment(r, n, count, rem(pc + n, count), Map.put(acc, pc, h))
  end
end

File.read!("res/day22.txt")
|> String.split("\n", trim: true)
|> Day22.part1(10_007)
|> IO.inspect()
