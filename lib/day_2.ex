defmodule Day2 do
  def solve(input, part_2 \\ false) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, "x")
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(&(elem(&1, 0)))
      |> Enum.sort
    end)
    |> Enum.map(fn [a, b, c] -> 
      if part_2, do: (a + b) * 2 + a * b * c,
      else: a * b * 3 + (a + b) * c * 2
    end)
    |> Enum.sum
  end
end