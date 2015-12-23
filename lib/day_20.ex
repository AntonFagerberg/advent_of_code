defmodule Day20 do
  
  def solve_1(input) do
    Stream.unfold(1, fn n ->
      sum = 
        1..round(:math.sqrt(n))
        |> Enum.flat_map(fn i ->
          if rem(n, i) == 0 do
            d = div(n, i)
            if d != i, do: [d, i], else: [i]
          else
            []
          end
        end)
        |> Enum.sum
      
      {{n, sum * 10}, n + 1}
    end)
    |> Stream.filter(fn {_, presents} -> presents >= input end)
    |> Stream.take(1)
    |> Enum.to_list
    |> hd
    |> elem(0)
  end
  
  def solve_2(input) do
    Stream.unfold(1, fn n ->
      sum = 
        1..round(:math.sqrt(n))
        |> Stream.flat_map(fn i ->
          if rem(n, i) == 0 do
            d = div(n, i)
            if d != i, do: [d, i], else: [i]
          else
            []
          end
        end)
        |> Stream.filter(&(&1 * 50 >= n))
        |> Enum.sum
      
      {{n, sum * 11}, n + 1}
    end)
    |> Stream.filter(fn {_, presents} -> presents >= input end)
    |> Stream.take(1)
    |> Enum.to_list
    |> hd
    |> elem(0)
  end
end