defmodule Day14 do
  def solve_1(input) do
    Regex.scan(~r/\d+/, input)
    |> Enum.map(fn [nr] ->
      nr |> Integer.parse |> elem(0)
    end)
    |> Enum.chunk(3)
    |> Enum.map(fn [speed, time, sleep] ->
      active = Stream.repeatedly(fn -> speed end) |> Enum.take(time)
      inactive = Stream.repeatedly(fn -> 0 end) |> Enum.take(sleep)
      
      Stream.cycle(active ++ inactive)
      |> Enum.take(2503)
      |> Enum.sum
    end)
    |> Enum.max
  end
  
  def solve_2(input) do
    specs = 
      Regex.scan(~r/\d+/, input)
      |> Enum.map(fn [nr] ->
        nr |> Integer.parse |> elem(0)
      end)
      |> Enum.chunk(3)
      
    zeros = 
      Stream.repeatedly(fn -> 0 end)
      |> Enum.take(length(specs))
      
    0..2502
    |> Enum.reduce({specs, zeros, zeros}, fn iteration, {specs, current, points} ->
      distances =
        Enum.map(specs, fn [speed, time, sleep] ->
          if rem(iteration, time + sleep) < time, do: speed, else: 0
        end)
        |> Enum.zip(current)
        |> Enum.map(fn {c, n} -> c + n end)
      
      max_distance = Enum.max(distances)
      
      points =
        distances
        |> Enum.map(fn distance ->
          if distance == max_distance, do: 1, else: 0
        end)
        |> Enum.zip(points)
        |> Enum.map(fn {o, n} -> o + n end)
        
      {specs, distances, points}
    end)
    |> elem(2)
    |> Enum.max
  end
end