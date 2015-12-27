defmodule Day8 do
  def solve_1(input) do
    input = input |> String.split("\n")

    a = input |> Enum.map(&String.length/1) |> Enum.sum
    b = input |> Enum.map(fn a -> Regex.scan(~r/(\\x[a-f0-9]{2}|\\\"|\\\\|\")/, a) |> length end) |> Enum.map(&(&1 - 2)) |> Enum.sum
    c = input |> Enum.map(fn a -> Regex.split(~r/(\\x[a-f0-9]{2}|\\\"|\\\\|\")/, a, trim: true) |> Enum.map(&String.length/1) |> Enum.sum end) |> Enum.sum

    a - b - c
  end

  def solve_2(input) do
    input = input |> String.split("\n")

    a = input |> Enum.map(&String.length/1) |> Enum.sum
    b = input |> Enum.map(fn a -> Regex.scan(~r/(\"|\\)/, a) |> Enum.map(&length/1) |> Enum.sum end) |> Enum.map(&(&1 + 2)) |> Enum.sum
    c = input |> Enum.map(fn a -> Regex.split(~r/(\"|\\)/, a, trim: true) |> Enum.map(&String.length/1) |> Enum.sum end) |> Enum.sum

    b + c - a
  end
end