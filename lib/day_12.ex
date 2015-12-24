defmodule Day12 do
  def solve(input, part_2 \\ false) do
    input
    |> Poison.decode!
    |> process(part_2)
  end
    

  defp process(item, part_2) when is_map(item) do
    if part_2 && Enum.any?(item, fn {k, v} -> k == "red" || v == "red" end) do
      0
    else
      item |> Enum.flat_map(fn {key, value} -> [process(key, part_2), process(value, part_2)] end) |> Enum.sum
    end
  end
  
  defp process(item, part_2) when is_list(item), do: item |> Enum.map(&(process(&1, part_2))) |> Enum.sum
  
  defp process(item, part_2) when is_integer(item), do: item
  
  defp process(item, part_2) when is_binary(item), do: 0
end