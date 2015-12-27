defmodule Day9 do
  def solve(input, part_2 \\ false) do
    map =
      input
      |> String.split("\n")
      |> Enum.map(fn line -> 
        Regex.split(~r/( (?:to|=) )/, line, capture: :all_but_first)
      end)
      |> Enum.reduce(%{}, fn [from, to, distance], acc ->
        distance = distance |> Integer.parse |> elem(0)
        
        acc
        |> Dict.update(from, Dict.put(%{}, to, distance), &(Dict.put(&1, to, distance)))
        |> Dict.update(to, Dict.put(%{}, from, distance), &(Dict.put(&1, from, distance)))
      end)
      
    distances =
      map
      |> trips
      |> Enum.map(fn trip ->
        Enum.chunk(trip, 2, 1)
        |> Enum.reduce(0, fn [from, to], total ->
          distance = map |> Dict.get(from) |> Dict.get(to)
          distance + total
        end)
      end) 
      
    if part_2, do: distances |> Enum.max, else: distances |> Enum.min
  end
  
  def trips(map, visited \\ []) do
    if length(Dict.keys(map)) == length(visited) do
      [visited]
    else
      map
      |> Dict.keys
      |> Enum.filter(fn dest -> !Enum.member?(visited, dest) end)
      |> Enum.flat_map(fn dest ->
        trips(map, [dest] ++ visited)
      end)
    end
  end
end