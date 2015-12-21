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
    
    replacements = 
      replacements
      |> String.split("\n")
      |> Enum.map(&(String.split(&1, " => ")))
      |> Enum.map(fn [key, value] -> {key, value} end)
      |> find_mutation(["e"], target)
  end

  def solve_4(input) do
    [replacements, target] = input |> String.split("\n\n")
    
    replacements = 
      replacements
      |> String.split("\n")
      |> Enum.map(&(String.split(&1, " => ")))
      |> Enum.map(fn [key, value] -> {value, key} end)
      |> find_mutation([target], "e")
  end
  
  def solve_3(input) do
    [replacements, target] = input |> String.split("\n\n")
    
    IO.puts("->" <> target <> "<-")
    
    replacements = 
      replacements
      |> String.split("\n")
      |> Enum.map(&(String.split(&1, " => ")))
      |> Enum.map(fn [key, value] -> {key, value} end)
      |> mutate_2("e", target)
  end
  
  
  
  def solve_5(input) do
    [replacements, target] = input |> String.split("\n\n")
    
    result = 
      replacements
      |> String.split("\n")
      |> Enum.map(&(String.split(&1, " => ")))
      |> Enum.map(fn [key, value] -> {value, key} end)
      |> mutate_2(target, "e")
      
    IO.inspect result
  end
  
  defp find_mutation(replacements, current, target, step \\ 0) do
    if Enum.any?(current, &(&1 == target)) do
      step
    else
      #target_length = String.length(target)
      
      IO.puts(length(current))
      
      next_mutations = 
        current
        |> Enum.flat_map(&(mutate(replacements, &1)))
        #|> Enum.filter(&(String.length(&1) <= target_length))
        |> Enum.uniq
        
      find_mutation(replacements, next_mutations, target, step + 1)
    end
  end
  
  defp mutate(replacements, current) do
    replacements
    |> Enum.filter(fn {key, _} -> String.contains?(current, key) end)
    |> Enum.flat_map(fn {key, value} ->
      {:ok, r} = Regex.compile(key)
      
      Regex.scan(r, current, return: :index)
      |> Enum.map(fn [{i, l}] ->
        prefix = String.slice(current, 0, i)
        suffix = String.slice(current, i + l, :infinity)
        prefix <> value <> suffix
      end)
    end)
  end
  
  defp mutate_2(replacements, current, target, step \\ 0) do
    IO.inspect current
    cond do
      current == target -> 
        IO.puts step
      #String.length(current) > String.length(target) -> nil
      true ->
        replacements
        |> Enum.filter(fn {key, _} -> String.contains?(current, key) end)
        |> Enum.find(fn {key, value} ->
          {:ok, r} = Regex.compile(key)
          
          Regex.scan(r, current, return: :index)
          |> Enum.find(fn [{i, l}] ->
            prefix = String.slice(current, 0, i)
            suffix = String.slice(current, i + l, :infinity)
            new_current = prefix <> value <> suffix
            
            mutate_2(replacements, new_current, target, step + 1) != nil
          end) != nil
        end)
    end
  end
end
