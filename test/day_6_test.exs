defmodule Day6Test do
  use ExUnit.Case
  
  test "Part 1" do
    result = 
      "input/day_6"
      |> File.read!
      |> Day6.solve_1
      
    assert result == 569999
  end

  test "Part 2" do
    result = 
      "input/day_6"
      |> File.read!
      |> Day6.solve_2
      
    assert result == 17836115
  end
end