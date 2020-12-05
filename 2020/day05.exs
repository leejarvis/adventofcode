# http://adventofcode.com/2020/day/5

# I realised far too late that I could just use bit shifting and that most
# of the walking code is superfluous. Oh well.

defmodule Day5 do
  import Enum, only: [take: 2]

  def solve(input) do
    seat_ids = Enum.map(input, &seat_id/1) |> Enum.sort()

    {Enum.max(seat_ids), find_seat(seat_ids)}
  end

  defp seat_id(<<row::binary-size(7), col::binary-size(3)>>) do
    seat_id({parse_row(row), parse_col(col)})
  end
  defp seat_id({row, col}), do: row * 8 + col

  defp parse_row(row), do: parse(to_charlist(row), 0..127)
  defp parse_col(col), do: parse(to_charlist(col), 0..7)

  defp parse([v | r], n) when v in [?F, ?L], do: parse(r, take(n, mid(n)))
  defp parse([v | r], n) when v in [?B, ?R], do: parse(r, take(n, -mid(n)))
  defp parse([], [v]), do: v

  defp mid(n), do: round(Enum.count(n) / 2)

  def find_seat([a, b | _r]) when b - a == 2, do: a + 1
  def find_seat([a, b | r]) when b - a == 1, do: find_seat([b | r])
end

File.read!("input/day05.txt")
|> String.split("\n")
|> Day5.solve()
|> IO.inspect()
