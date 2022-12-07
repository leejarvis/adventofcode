# http://adventofcode.com/2022/day/7

defmodule Day7 do
  @disk_space 70_000_000

  def solve(input) do
    dir = build_directory(input)

    one = sum_directory_sizes(dir, 100_000)
    two = smallest_deletable_directory_size(dir, 30_000_000)

    {one, two}
  end

  def smallest_deletable_directory_size(dir, required_space) do
    [{"/", size} | sizes] = directory_sizes(dir) |> Enum.reverse()
    delete_space = required_space - (@disk_space - size)

    sizes
    |> Enum.filter(fn {_, size} -> size >= delete_space end)
    |> Enum.min_by(fn {_, size} -> size - delete_space end)
    |> elem(1)
  end

  def sum_directory_sizes(dir, limit) do
    dir
    |> directory_sizes()
    |> Enum.map(fn
      {_, size} when size <= limit -> size
      _ -> 0
    end)
    |> Enum.sum()
  end

  defp directory_sizes(dir) do
    directory_sizes({"/", dir}, [])
  end

  defp directory_sizes({_, size}, res) when is_integer(size), do: res

  defp directory_sizes({dir, subdir}, res) do
    Enum.reduce(subdir, [{dir, directory_size(subdir)} | res], fn dir, res ->
      directory_sizes(dir, res)
    end)
  end

  defp directory_size(size) when is_integer(size), do: size

  defp directory_size(directory) do
    directory
    |> Enum.map(fn
      {_, size} when is_integer(size) -> size
      {_, subdir} when is_map(subdir) -> directory_size(subdir)
    end)
    |> Enum.sum()
  end

  defp build_directory(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({%{}, []}, &parse_line/2)
    |> elem(0)
  end

  defp parse_line(line, state) when is_binary(line) do
    parse_line(String.split(line, " "), state)
  end

  defp parse_line(["$", "cd", "/"], _state) do
    {%{"/" => %{}}, ["/"]}
  end

  defp parse_line(["$", "cd", ".."], {fs, path}) do
    {fs, Enum.slice(path, 0..-2)}
  end

  defp parse_line(["$", "cd", dir], {fs, path}) do
    {fs, path ++ [dir]}
  end

  defp parse_line(["$", "ls"], state) do
    state
  end

  defp parse_line(["dir", file], {fs, path}) do
    {put_in(fs, path ++ [file], %{}), path}
  end

  defp parse_line([size, file], {fs, path}) do
    {put_entry(fs, path, {file, String.to_integer(size)}), path}
  end

  defp put_entry(fs, path, {key, value}) do
    elem(get_and_update_in(fs, path, fn e ->
      {nil, Map.put(e, key, value)}
    end), 1)
  end
end

File.read!("input/day07.txt")
|> Day7.solve()
|> IO.inspect(charlists: :as_lists)
