defmodule Day17 do
  # Part 1
  def solve_1(input, target) do
    Regex.scan(~r/-?\d+/, input)
    |> Enum.map(&hd/1)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&(elem(&1, 0)))
    |> process_1([], target)
  end
  
  defp process_1([], acc, target) do
    if Enum.sum(acc) == target, do: 1, else: 0
  end
  
  defp process_1([head | tail], acc, target) do
    process_1(tail, [head] ++ acc, target) + process_1(tail, acc, target)
  end
  
  # Part 2
  def solve_2(input, target) do    
    Regex.scan(~r/-?\d+/, input)
    |> Enum.map(&hd/1)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&(elem(&1, 0)))
    |> process_2([], target)
    |> Enum.reduce({0, -1}, fn (nr, {acc_count, acc_min}) ->
      cond do
        acc_min == -1 || nr < acc_min -> {1, nr}
        nr == acc_min -> {acc_count + 1, acc_min}
        true -> {acc_count, acc_min}
      end
    end)
    |> elem(0)
  end
  
  defp process_2([], acc, target) do
    if Enum.sum(acc) == target, do: [length(acc)], else: []
  end
  
  defp process_2([head | tail], acc, target) do
    process_2(tail, [head] ++ acc, target) ++ process_2(tail, acc, target)
  end
end
