defmodule Day13Test do
  use ExUnit.Case
  
  test "Part 1 (test)" do
    result = 
      "input/day_13_test"
      |> File.read!
      |> Day13.solve
      
    assert result == 330
  end
  
  test "Part 1" do
    result = 
      "input/day_13"
      |> File.read!
      |> Day13.solve
      
    assert result == 618
  end
  
  test "Part 2" do
    result = 
      "input/day_13"
      |> File.read!
      |> Day13.solve(true)
      
    assert result == 601
  end
end