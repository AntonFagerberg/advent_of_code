defmodule Day6 do
  def solve_1(input) do
    input 
    |> String.split("\n")
    |> Enum.reduce(%{}, fn (input, acc) ->
      [[_, cmd, x1, y1, x2, y2]] = Regex.scan(~r/(turn (?:on|off)|toggle) (\d+),(\d+) through (\d+),(\d+)/, input)

      x1 = String.to_integer(x1)
      x2 = String.to_integer(x2)
      y1 = String.to_integer(y1)
      y2 = String.to_integer(y2)

      offset = 1_000_000
      
      Enum.reduce(x1..x2, acc, fn (x, x_acc) ->
        Enum.reduce(y1..y2, x_acc, fn (y, y_acc) ->
          Dict.get_and_update(y_acc, x + y * offset, fn (current) ->
            if (current == nil), do: current = 0
            
            case cmd do
              "turn on" ->
                {nil, 1}
              "turn off" ->
                {nil, 0}
              "toggle" ->
                {nil, (if current == 0, do: 1, else: 0)}
            end
          end)
          |> elem(1)
        end)
      end)
    end)
    |> Map.values
    |> Enum.sum
  end
  
  def solve_2(input) do
    input 
    |> String.split("\n")
    |> Enum.reduce(%{}, fn (input, acc) ->
      [[_, cmd, x1, y1, x2, y2]] = Regex.scan(~r/(turn (?:on|off)|toggle) (\d+),(\d+) through (\d+),(\d+)/, input)

      x1 = String.to_integer(x1)
      x2 = String.to_integer(x2)
      y1 = String.to_integer(y1)
      y2 = String.to_integer(y2)

      offset = 1_000_000
      
      Enum.reduce(x1..x2, acc, fn (x, x_acc) ->
        Enum.reduce(y1..y2, x_acc, fn (y, y_acc) ->
          Dict.get_and_update(y_acc, x + y * offset, fn (current) ->
            if (current == nil), do: current = 0
            
            case cmd do
              "turn on" ->
                {nil, current + 1}
              "turn off" ->
                if current > 0 do
                  {nil, current - 1}
                else
                  {nil, 0}
                end
              "toggle" ->
                {nil, current + 2}
            end
          end)
          |> elem(1)
        end)
      end)
    end)
    |> Map.values
    |> Enum.sum
  end
end