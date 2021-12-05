defmodule Y2021.Day04 do
  use Advent.Day

  def part1({numbers, boards}) do
    {board, n} = play(numbers, boards)

    sum = board
    |> List.flatten()
    |> Enum.filter(fn {_n, marked} -> !marked end)
    |> Enum.map(fn {n, _marked} -> n end)
    |> Enum.sum()

    sum * n
  end

  def part2(_input) do
    nil
  end

  defp play([], _boards), do: nil
  defp play([number | numbers], boards) do
    boards = Enum.map(boards, &mark(&1, number))

    case Enum.find(boards, &winner?/1) do
      nil -> play(numbers, boards)
      board -> {board, number}
    end
  end

  defp mark(board, number) do
    Enum.map(board, fn row ->
      Enum.map(row, fn {col, mark} ->
        case mark do
          true -> {col, mark}
          false -> {col, col == number}
        end
      end)
    end)
  end

  defp winner?(board) do
    winning_row?(board) || winning_column?(board)
  end

  defp winning_row?(board) do
    Enum.any?(board, fn r -> all_marked?(r) end)
  end

  defp winning_column?(board) do
    board
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.any?(fn r -> all_marked?(r) end)
  end

  defp all_marked?(row) do
    Enum.all?(row, fn {_n, t} -> t end)
  end

  @impl Advent.Day
  def parse_input(input) do
    [numbers | boards] = String.split(input, "\n\n")
    {parse_numbers(numbers), parse_boards(boards)}
  end

  defp parse_numbers(numbers) do
    String.split(numbers, ",") |> Enum.map(&String.to_integer/1)
  end

  defp parse_boards(boards) do
    Enum.map(boards, &parse_board/1)
  end

  defp parse_board(board) do
    board
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_row/1)
  end

  defp parse_row(row) do
    row
    |> String.split(~r/\s+/, trim: true)
    |> Enum.map(fn c -> {String.to_integer(c), false} end)
  end
end
