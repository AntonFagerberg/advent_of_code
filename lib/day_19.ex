defmodule Day19 do
  def solve_1(input) do
    [replacements, data] = input |> String.split("\n\n")
    
    replacements = 
      replacements
      |> String.split("\n")
      |> Enum.map(&(String.split(&1, " => ")))
      |> Enum.map(fn [key, value] -> {key, value} end)
      |> transform(data)
      |> Enum.count
  end
  
  defp transform(replacements, ""), do: []
  
  defp transform(replacements, data) do
    transformed = 
      replacements
      |> Enum.filter(fn {key, _} -> String.starts_with?(data, key) end)
      |> Enum.map(fn {key, value} ->  
        remaining_data = 
          data
          |> String.split_at(String.length(key))
          |> elem(1)

        value <> remaining_data
      end)
      
    {skipped, rest} = String.split_at(data, 1)
    
    not_transformed =
      transform(replacements, rest)
      |> Enum.map(&(skipped <> &1))
    
    (transformed ++ not_transformed)
    |> Enum.uniq
  end

  def solve_2(input) do
    [replacements, target] = input |> String.split("\n\n")
    
    replacements
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, " => ")))
    |> Enum.map(fn [key, value] -> {value, key} end)
    |> mutate_reverse(target, "e")
    |> Stream.take(1)
    |> Enum.to_list
    |> hd
  end
  
  defp mutate_reverse(replacements, current, target, step \\ 0) do
    if current == target do
      [step]
    else
      replacements
      |> Stream.filter(fn {key, _} -> String.contains?(current, key) end)
      |> Stream.flat_map(fn {key, value} ->
        {:ok, r} = Regex.compile(key)
        
        Regex.scan(r, current, return: :index)
        |> Stream.flat_map(fn [{i, l}] ->
          prefix = String.slice(current, 0, i)
          suffix = String.slice(current, i + l, :infinity)
          new_current = prefix <> value <> suffix
          
          mutate_reverse(replacements, new_current, target, step + 1)
        end)
        |> Stream.filter(&(&1 != nil))
      end)
    end
  end
end
