# http://adventofcode.com/2020/day/4

defmodule Day4 do
  @expected ~w[byr iyr eyr hgt hcl ecl pid]
  @eye_colors ~w[amb blu brn gry grn hzl oth]

  def solve(passports) do
    passports = Enum.map(passports, &normalize/1)

    valid_1 = Enum.filter(passports, &valid_1?/1) |> Enum.count()
    valid_2 = Enum.filter(passports, &valid_2?/1) |> Enum.count()

    {valid_1, valid_2}
  end

  defp valid_1?(passport) do
    Enum.count(passport, fn {k, _} ->
      Enum.member?(@expected, k)
    end) == Enum.count(@expected)
  end

  defp valid_2?(passport) do
    Enum.count(passport, fn {k, v} ->
      valid_field?(k, v)
    end) == Enum.count(@expected)
  end

  def valid_field?("byr", v) do
    i = String.to_integer(v)
    i >= 1920 && i <= 2002
  end

  def valid_field?("iyr", v) do
    i = String.to_integer(v)
    i >= 2010 && i <= 2020
  end

  def valid_field?("eyr", v) do
    i = String.to_integer(v)
    i >= 2020 && i <= 2030
  end

  def valid_field?("hgt", v) do
    case Regex.run(~r/(\d+)(cm|in)/, v) do
      nil -> false
      [_, i, m] -> valid_height?(m, String.to_integer(i))
    end
  end

  def valid_field?("hcl", v), do: Regex.match?(~r/\A\#[0-9a-f]{6}\z/, v)
  def valid_field?("ecl", v), do: Enum.member?(@eye_colors, v)
  def valid_field?("pid", v), do: Regex.match?(~r/\A\d{9}\z/, v)
  def valid_field?(_, _),     do: false

  def valid_height?("cm", v), do: v >= 150 && v <= 193
  def valid_height?("in", v), do: v >= 59 && v <= 76
  def valid_height?(_, _),    do: false

  defp normalize(passport) do
    String.split(passport, ~r/\s+/)
    |> Enum.map(& String.split(&1, ":"))
    |> Enum.into(%{}, fn [a, b] -> {a, b} end)
  end
end

File.read!("input/day04.txt")
|> String.split("\n\n")
|> Day4.solve()
|> IO.inspect()
