defmodule Day16 do
  def solve_1(input, tape) do
    list_to_tuple =
      fn [key, value] ->
        {String.to_atom(key), value |> Integer.parse |> elem(0)}
      end
    
    tape =  
      tape 
      |> String.split("\n")
      |> Enum.map(&(String.split(&1, ": ")))
      |> Enum.map(list_to_tuple)
    
    input
    |> String.split("\n")
    |> Enum.map(&(Regex.replace(~r/[^Sa-z0-9 ]/, &1, "")) |> String.split(" "))
    |> Enum.filter(fn ["Sue", nr | tail] ->
      tail
      |> Enum.chunk(2)
      |> Enum.map(list_to_tuple)
      |> Enum.all?(fn {key, value} ->
        Dict.get(tape, key, value) == value
      end)
    end)
    |> Enum.map(fn [_head, nr | _tail] -> Integer.parse(nr) |> elem(0) end)
  end
  
  def solve_2(input, tape) do
    list_to_tuple =
      fn [key, value] ->
        {String.to_atom(key), value |> Integer.parse |> elem(0)}
      end
    
    tape =  
      tape 
      |> String.split("\n")
      |> Enum.map(&(String.split(&1, ": ")))
      |> Enum.map(list_to_tuple)
    
    input
    |> String.split("\n")
    |> Enum.map(&(Regex.replace(~r/[^Sa-z0-9 ]/, &1, "")) |> String.split(" "))
    |> Enum.filter(fn ["Sue", nr | tail] ->
      tail
      |> Enum.chunk(2)
      |> Enum.map(list_to_tuple)
      |> Enum.all?(fn 
        {:cats, value} -> Dict.get(tape, :cats, value - 1) < value
        {:trees, value} -> Dict.get(tape, :trees, value - 1) < value
        {:pomeranians, value} -> Dict.get(tape, :pomeranians, value + 1) > value
        {:goldfish, value} -> Dict.get(tape, :goldfish, value + 1) > value
        {key, value} -> Dict.get(tape, key, value) == value
      end)
    end)
    |> Enum.map(fn [_head, nr | _tail] -> Integer.parse(nr) |> elem(0) end)
  end
end