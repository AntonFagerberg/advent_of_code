defmodule Day11 do
  def solve(input) do
    start_index = string_to_int(input)
    
    Stream.unfold(start_index, fn n -> {int_to_string(n), n + 1} end)
    |> Stream.filter(&req_1/1)
    |> Stream.filter(&req_2/1)
    |> Stream.filter(&req_3/1)
    |> Stream.take(1)
    |> Enum.to_list
    |> hd
  end
  
  def req_1(string) do
    string 
    |> String.to_char_list 
    |> Enum.chunk(3, 1)
    |> Enum.any?(fn [a, b, c] -> a + 1 == b && b + 1 == c end)
  end
  
  def req_2(string) do
    !Regex.match?(~r/(i|o|l)/, string)
  end
  
  def req_3(string) do
    Regex.scan(~r/([a-z])\1/, string)
    |> Enum.uniq
    |> length > 1
  end
  
  def string_to_int(s) do
    s
    |> String.reverse
    |> to_char_list
    |> Enum.map(&(&1 - ?a))
    |> Enum.with_index
    |> Enum.map(fn {nr, 0} -> nr ; {nr, index} -> round((nr + 1) * :math.pow(26, index)) end)
    |> Enum.sum
  end
  
  def int_to_string(i), do: int_to_char_list(i) |> to_string
  
  defp int_to_char_list(i) do
    d = div(i, ?z - ?a + 1)
    r = rem(i, ?z - ?a + 1)

    char_list = if (d > 0), do: int_to_char_list(d - 1) ++ [r + ?a], else: [r + ?a]
  end
end