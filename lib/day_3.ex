defmodule Day3 do
  def solve_1(input) do
    input
    |> to_char_list
    |> Enum.map(fn
      ?^ -> { 0,  1}
      ?v -> { 0, -1}
      ?< -> {-1,  0}
      ?> -> { 1,  0}
    end)
    |> Enum.scan({0,0}, fn {x, y}, {xx, yy} ->
      {x + xx, y + yy}
    end)
    |> Enum.into([{0,0}])
    |> Enum.uniq
    |> length
  end
  
  def solve_2(input) do
    input
    |> to_char_list
    |> Enum.map(fn
      ?^ -> { 0,  1}
      ?v -> { 0, -1}
      ?< -> {-1,  0}
      ?> -> { 1,  0}
    end)
    |> Enum.with_index
    |> Enum.scan({{0,0}, {0,0}}, fn {{x, y}, i}, {{x1, y1} = xy1, {x2, y2} = xy2} ->
      if rem(i, 2) == 0, do: {{x1 + x, y1 + y}, xy2},
    else: {xy1, {x2 + x, y2 + y}}
    end)
    |> Enum.flat_map(fn {xy1, xy2} -> [xy1, xy2] end)
    |> Enum.into([{0,0}])
    |> Enum.uniq
    |> length
  end
end