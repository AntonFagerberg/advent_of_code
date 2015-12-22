defmodule Day16Test do
  use ExUnit.Case
  
  test "Part 1" do
    input = File.read!("input/day_16")
    tape = File.read!("input/day_16_tape")
    
    assert Day16.solve_1(input, tape) == [373]
  end
  
  test "Part 2" do
    input = File.read!("input/day_16")
    tape = File.read!("input/day_16_tape")
    
    assert Day16.solve_2(input, tape) == [260]
  end
end