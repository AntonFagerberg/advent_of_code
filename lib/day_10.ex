defmodule Day10 do
  def solve(input, steps) do
    Enum.reduce(1..steps, input, fn _, acc -> 
      Regex.scan(~r/(\d{1})\1*/, acc)
      |> Enum.map( fn [all, a] -> "#{String.length(all)}#{a}" end) 
      |> Enum.join 
    end) 
    |> String.length
  end
end