defmodule Day24 do
  def solve(input, partition_count \\ 3) do
    input
    |> String.split("\n")
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&(elem(&1, 0)))
    |> init(partition_count)
  end
  
  def init(items, partition_count) do
    target = Enum.sum(items) |> div(partition_count)
    
    valid_pieces = 
      pieces(items, target)
      |> Enum.sort_by(fn {piece, _rest} -> length(piece) end)
      |> Stream.filter(fn {_piece, rest} ->
        valid_piece?(rest, partition_count - 1, target)
      end)
      
    [{piece, _rest}] = Enum.take(valid_pieces, 1)
    min_length = length(piece)
    
    valid_pieces
    |> Stream.take_while(fn {piece, _rest} -> length(piece) == min_length end)
    |> Enum.map(fn {piece, _rest} -> Enum.reduce(piece, &*/2) end)
    |> Enum.min
  end
  
  def valid_piece?(items, count, target) do
    if count == 1 do
      Enum.take(pieces(items, target), 1) != []
    else
      pieces(items, target)
      |> Enum.any?(fn {_piece, rest} ->
        valid_piece?(rest, count - 1, target)
      end)
    end
  end
  
  def pieces(items, target) do
    Stream.unfold([{[], [], items}], fn pieces ->
        new_pieces = 
          Enum.flat_map(pieces, fn {piece, skipped, unused} ->
            {head, new_unused} = Enum.split(unused, 1)
            
            [
              {head ++ piece, skipped, new_unused}, 
              {piece, head ++ skipped, new_unused}
            ]
          end)
        
        {return, continue} = Enum.partition(new_pieces, &(Enum.sum(elem(&1, 0)) == target))
        
        continue =
          Enum.filter(continue, fn item ->
            Enum.sum(elem(item, 0)) < target && elem(item, 2) != []
          end)

        if new_pieces == [], do: nil, else: {return, continue}
    end)
    |> Stream.flat_map(&(&1))
    |> Stream.map(fn {piece, rest, unused} -> {piece, rest ++ unused} end)
  end
end