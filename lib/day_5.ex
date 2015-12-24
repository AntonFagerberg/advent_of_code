defmodule Day5 do
  def solve_1(input) do
    input
    |> String.split("\n")
    |> Enum.filter(fn line ->
      Regex.match?(~r/([a-z])\1/, line) &&
      Regex.scan(~r/(a|e|i|o|u)/, line) |> length >= 3 &&
      !Regex.match?(~r/(ab|cd|pq|xy)/, line)
    end)
    |> Enum.count
  end
  
  def solve_2(input) do
    input
    |> String.split("\n")
    |> Enum.filter(fn line ->
      Regex.match?(~r/([a-z]{2}).*\1/, line) &&
      Regex.match?(~r/([a-z])[a-z]\1/, line)
    end)
    |> Enum.count
  end
end