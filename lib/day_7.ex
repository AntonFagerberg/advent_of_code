defmodule Day7 do
  import Bitwise
  
  def solve(inputs, part_2 \\ false) do
    get_value = fn input ->
      case Integer.parse(input, 10) do
        {int, _} -> 
          int
        
        :error -> 
          String.to_atom(input) |> send(self)
          receive do
            value -> value
          end
      end
    end
    
    if part_2 do
      [pre, post] = Regex.split(~r/\n.* -> b\n/, inputs)
      inputs = "#{pre}\n3176 -> b\n#{post}"
    end
    
    inputs
    |> String.split("\n")
    |> Enum.each(fn string ->
      parsed = Regex.scan(~r/(?:([a-z0-9]+)|(NOT) ([a-z0-9]+)|(?:([a-z0-9]+) (?:(AND|OR) ([a-z0-9]+)|(?:(L|R)SHIFT (\d+))))) -> ([a-z]+)/, string) |> hd |> tl
      
      case parsed do
        [_, "NOT", input, _, _, _, _, _, name] ->
          spawn_link(fn -> 
            receive do
              receiver ->
                result = ~~~get_value.(input) &&& 65535
                send(receiver, result)
                
                for _ <- Stream.cycle([:ok]) do
                  receive do
                    receiver -> send(receiver, result)
                  end
                end
            end
          end)
          |> Process.register(String.to_atom(name))
          
        [_, _, _, input, _, _, "R", steps, name] ->
          spawn_link(fn -> 
            receive do
              receiver -> 
                {steps, _} = Integer.parse(steps)
                result = get_value.(input) >>> steps
                send(receiver, result)
                
                for _ <- Stream.cycle([:ok]) do
                  receive do
                    receiver -> send(receiver, result)
                  end
                end
            end
          end)
          |> Process.register(String.to_atom(name))
          
        [_, _, _, input, _, _, "L", steps, name] ->
          spawn_link(fn -> 
            receive do
              receiver ->
                {steps, _} = Integer.parse(steps)
                result = get_value.(input) <<< steps &&& 65535
                send(receiver, result)
                
                for _ <- Stream.cycle([:ok]) do
                  receive do
                    receiver -> send(receiver, result)
                  end
                end
            end
          end)
          |> Process.register(String.to_atom(name))
          
        [_, _, _, input_1, "OR", input_2, _, _, name] ->
          spawn_link(fn -> 
            receive do
              receiver -> 
                result = get_value.(input_1) ||| get_value.(input_2)
                send(receiver, result)
                
                for _ <- Stream.cycle([:ok]) do
                  receive do
                    receiver -> send(receiver, result)
                  end
                end
            end
          end)
          |> Process.register(String.to_atom(name))
          
        [_, _, _, input_1, "AND", input_2, _, _, name] ->
          spawn_link(fn -> 
            receive do
              receiver ->
                result = get_value.(input_1) &&& get_value.(input_2)
                send(receiver, result)
                
                for _ <- Stream.cycle([:ok]) do
                  receive do
                    receiver -> send(receiver, result)
                  end
                end
            end
          end)
          |> Process.register(String.to_atom(name))
          
        [input, _, _, _, _, _, _, _, name] ->
          spawn_link(fn -> 
              receive do
                receiver -> 
                  result = get_value.(input)
                  send(receiver, result)
                  
                  for _ <- Stream.cycle([:ok]) do
                    receive do
                      receiver -> send(receiver, result)
                    end
                  end
              end
          end)
          |> Process.register(String.to_atom(name))
      end
    end)

    send :a, self

    receive do
      signal -> signal
    end
  end
end