defmodule Day13 do
  def solve(input, part_2 \\ false) do
    dict =
      input
      |> String.split("\n")
      |> Enum.map(&(Regex.scan(~r/([A-Z][a-z]+) would (gain|lose) (\d+) happiness units by sitting next to ([A-Z][a-z]+)/, &1, capture: :all_but_first)))
      |> Enum.map(fn
        [[name1, "gain", nr, name2]] -> {name1, Integer.parse(nr) |> elem(0), name2}
        [[name1, "lose", nr, name2]] -> {name1, -1 * (Integer.parse(nr) |> elem(0)), name2}
      end)
      |> Enum.reduce(%{}, fn ({name1, score, name2}, acc) ->
        Dict.get_and_update(acc, name1, fn
          nil -> {nil, Dict.put(%{}, name2, score)}
          map -> {nil, Dict.put(map, name2, score)}
        end)
        |> elem(1)
      end)
      
    names = if part_2, do: Dict.keys(dict) ++ ["anton"], else: Dict.keys(dict)
      
    combinations(names)
    |> Enum.map(fn [head | tail] ->
      pairs = [head] ++ tail
      pairs_reversed = [head] ++ Enum.reverse(pairs)
      
      (pairs ++ pairs_reversed)
      |> Enum.chunk(2, 1)
      |> Enum.map(fn [name1, name2] ->
        dict |> Dict.get(name1, %{}) |> Dict.get(name2, 0)
      end)
      |> Enum.sum
    end)
    |> Enum.max
  end
  
  def combinations(list, acc \\ [])
  
  def combinations([], acc), do: [acc]
  
  def combinations(list, acc) do
    0..(length(list) - 1)
    |> Enum.flat_map(fn i ->
      {a, b} = Enum.split(list, i)
      [x | b] = b
      
      combinations(a ++ b, [x] ++ acc)
    end)
  end
end