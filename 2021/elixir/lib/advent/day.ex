defmodule Advent.Day do
  defmacro __using__(_) do
    quote do
      @behaviour Advent.Day

      def input do
        filename =
          __MODULE__
          |> to_string()
          |> String.split(".")
          |> Enum.at(-1)
          |> String.downcase()

        folder = __ENV__.file |> Path.dirname()

        "#{folder}/input/#{filename}.txt"
        |> File.read!()
        |> String.trim()
      end

      def input_to_ints(input) do
        input
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
      end
    end
  end

  @doc """
  Parses the input. The return value will be sent as the argument to `part1`
  and `part2`.
  """
  @callback parse_input(String.t()) :: any()
end
