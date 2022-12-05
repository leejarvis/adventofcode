# http://adventofcode.com/2022/day/5

defmodule Day5 do
  def solve(input) do
    [stacks, moves] = String.split(input, "\n\n")

    stacks = parse_stacks(stacks)
    moves = parse_moves(moves)

    one = Enum.reduce(moves, stacks, &move1/2) |> top_crates()
    two = Enum.reduce(moves, stacks, &move2/2) |> top_crates()

    {one, two}
  end

  defp top_crates(stacks) do
    Map.values(stacks) |> Enum.map(&Enum.at(&1, -1)) |> Enum.join()
  end

  defp move1([0, _, _], stacks), do: stacks
  defp move1([n, from, to], stacks) do
    {crate, stacks} = Map.get_and_update!(stacks, from, &List.pop_at(&1, -1))
    {_, stacks} = Map.get_and_update!(stacks, to, fn stack -> {stack, stack ++ [crate]} end)
    move1([n - 1, from, to], stacks)
  end

  defp move2([n, from, to], stacks) do
    {crates, stacks} = Map.get_and_update!(stacks, from, fn stack ->
      crates = Enum.slice(stack, -n..-1)
      stack = Enum.slice(stack, 0..-(n+1))
      {crates, stack}
    end)
    {_, stacks} = Map.get_and_update!(stacks, to, fn stack -> {stack, stack ++ crates} end)
    stacks
  end

  defp parse_stacks(input) do
    stacks = String.split(input, "\n")
    max = Enum.max_by(stacks, &String.length/1) |> String.length()
    stacks = Enum.map(stacks, fn s -> String.pad_trailing(s, max) end)
    {counts, stacks} = List.pop_at(stacks, -1)

    for {n, i} <- Enum.with_index(String.codepoints(counts)),
      stack <- stacks,
      Regex.match?(~r/[0-9]/, n),
      crate = String.at(stack, i),
      crate != " ",
      reduce: %{} do
      acc ->
        Map.update(acc, String.to_integer(n), [crate], fn s -> [crate | s] end)
    end
  end

  defp parse_moves(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      Regex.scan(~r/\d+/, s)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
    end)
  end
end

File.read!("input/day05.txt")
|> Day5.solve()
|> IO.inspect(charlists: :as_lists)
