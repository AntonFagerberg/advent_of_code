defmodule Day8Test do
  use ExUnit.Case

  test "Part 1" do
    result = 
      "input/day_9"
      |> File.read!
      |> Day9.solve
      
    assert result == 251
  end

  test "Part 2" do
    result = 
      "input/day_9"
      |> File.read!
      |> Day9.solve(true)
      
    assert result == 898
  end
end