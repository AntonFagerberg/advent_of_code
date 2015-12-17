defmodule Day15 do
  # Part 1 & 2
  def solve(input, cals \\ nil) do    
    Regex.scan(~r/-?\d+/, input)
    |> Enum.map(&hd/1)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.chunk(5)
    |> process([0, 0, 0, 0, 0], 0, cals)
  end
  
  defp process([], acc, 100, cals) do
    if Enum.any?(acc, &(&1 < 0)) || (cals != nil && Enum.at(acc, -1) != cals), do: 0, 
    else: acc |> Enum.drop(-1) |> Enum.reduce(&(&1 * &2))
  end
  
  defp process([props | tail], acc, used_tbsp, cals) do
    range = if tail == [], do: [100-used_tbsp], else: 0..(100-used_tbsp)

    range
    |> Enum.map(fn tbsp ->
      new_acc = 
        props
        |> Enum.map(&(&1 * tbsp))
        |> Enum.zip(acc)
        |> Enum.map(fn {a, b} -> a + b end)
        
      process(tail, new_acc, used_tbsp + tbsp, cals)
    end)
    |> Enum.max
  end
end
