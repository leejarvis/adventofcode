# https://adventofcode.com/2020/day/14

defmodule Day14 do
  use Bitwise

  def solve(input) do
    s1 = memory_sum(input)
    s2 = 0

    {s1, s2}
  end

  def memory_sum(input) do
    {memory, _masks} = for line <- input, reduce: {%{}, {nil, nil}} do
      {mem, masks = {mor, mand}} ->
        case line do
          "mask = " <> mask ->
            {mem, morand(mask)}
          _ ->
            [addr, value] = Regex.scan(~r/\d+/, line) |> List.flatten() |> Enum.map(&String.to_integer/1)
            {Map.put(mem, addr, band(bor(value, mor), mand)), masks}
        end
    end

    memory
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  defp morand(mask) do
    {mor, _} = String.replace(mask, "X", "0") |> Integer.parse(2)
    {mand, _} = String.replace(mask, "X", "1") |> Integer.parse(2)
    {mor, mand}
  end
end

File.read!("input/day14.txt")
|> String.split("\n", trim: true)
|> Day14.solve()
|> IO.inspect()
