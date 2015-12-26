defmodule Day25 do
  def solve(input) do
    [target_row, target_col] = 
      Regex.scan(~r/[^\d]*(\d+)[^\d]*(\d+)/, input, capture: :all_but_first) 
      |> hd
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(&(elem(&1, 0)))
    
    Stream.unfold({2,1,20151125}, fn {row, col, prev} -> 
      val = rem(prev * 252533, 33554393)

      if row < 1 do
        row = col
        col = 1
      end
      
      {{row, col, val}, {row - 1, col + 1, val}}
    end)
    |> Stream.filter(fn {row, col, _} -> target_row == row && target_col == col end)
    |> Stream.map(fn {_, _, value} -> value end)
    |> Enum.take(1)
    |> hd
  end
end