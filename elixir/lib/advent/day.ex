defmodule Advent.Day do
  defmacro __using__(day: day) do
    quote do
      def input(filename \\ "day#{unquote(day)}") do
        folder = __ENV__.file |> Path.dirname()

        "#{folder}/input/#{filename}.txt"
        |> File.read!()
        |> String.trim()
      end

      def input_to_ints(filename \\ "day#{unquote(day)}") do
        input()
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
      end
    end
  end
end
