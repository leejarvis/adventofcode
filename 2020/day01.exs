# http://adventofcode.com/2020/day/1

defmodule Day1 do
  def solve(input, exp) do
    [{a1, a2} | _] = for a <- input, b <- input, a + b == exp, do: {a, b}
    [{b1, b2, b3} | _] = for a <- input, b <- input, c <- input, a + b + c == exp, do: {a, b, c}

    {a1 * a2, b1 * b2 * b3}
  end
end

File.read!("input/day01.txt")
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Day1.solve(2020)
|> IO.inspect()
