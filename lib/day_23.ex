defmodule Day23 do
  
  defmacro execute_next do
    quote do
      {next, forward} = Enum.split(var!(forward), 1)
      
      case next do
        [next] -> execute(next, [next] ++ var!(back), forward, var!(registers))
        [] -> var!(registers)
      end
    end
  end
  
  def solve(input, part_2 \\ false) do
    forward = String.split(input, "\n")
    back = []
    registers = 
      if part_2, do: %{"a" => 1, "b" => 0}, 
      else: %{"a" => 0, "b" => 0}
    
    execute_next
  end
  
  def execute("hlf " <> reg, back, forward, registers) do
    registers = Dict.update!(registers, reg, &(div(&1, 2)))
    execute_next
  end
  
  def execute("tpl " <> reg, back, forward, registers) do
    registers = Dict.update!(registers, reg, &(&1 * 3))
    execute_next
  end
  
  def execute("inc " <> reg, back, forward, registers) do
    registers = Dict.update!(registers, reg, &(&1 + 1))
    execute_next
  end
  
  def execute("jie " <> rest, back, forward, registers) do
    [reg, offset] = String.split(rest, ", ")
    value = Dict.get(registers, reg)
    
    if rem(value, 2) != 0, do: execute_next,
    else: execute("jmp " <> offset, back, forward, registers)
  end
  
  def execute("jio " <> rest, back, forward, registers) do
    [reg, offset] = String.split(rest, ", ")
    value = Dict.get(registers, reg)
    
    if value != 1, do: execute_next,
    else: execute("jmp " <> offset, back, forward, registers)
  end
  
  def execute("jmp " <> offset, back, forward, registers) do
    offset = offset |> Integer.parse |> elem(0)
    
    cond do
      offset == 0 ->
        [previous | back] = back
        forward = [previous] ++ forward
      offset > 0 ->
        {skipped, forward} = Enum.split(forward, offset - 1)  
        back = Enum.reverse(skipped) ++ back
      offset < 0 ->
        {skipped, back} = Enum.split(back, -offset + 1)
        forward = Enum.reverse(skipped) ++ forward
    end
    
    execute_next
  end
  
  def execute(cmd, back, forward, registers) do
    IO.inspect(cmd)
    IO.inspect(back)
    IO.inspect(forward)
    IO.inspect(registers)
    throw :invalid_instruction
  end
end