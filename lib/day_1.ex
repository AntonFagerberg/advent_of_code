defmodule Day1 do
  def solve_1(input) do
    input 
    |> to_char_list 
    |> Enum.reduce(0, &(&2 + &1 * -2 + 81))
  end
  
  def solve_2(input) do
    input 
    |> to_char_list 
    |> Stream.scan(0, &(&2 + &1 * -2 + 81)) 
    |> Stream.with_index
    |> Stream.filter(fn {nr, _} -> nr == -1 end)
    |> Stream.take(1)
    |> Enum.to_list
    |> Enum.map(&(elem(&1, 1) + 1))
    |> hd
  end
end