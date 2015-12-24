defmodule Day12Test do
  use ExUnit.Case

  test "Part 1" do
    result = 
      "input/day_12"
      |> File.read!
      |> Day12.solve
      
    assert result == 191164
  end

  test "Part 2" do
    result = 
      "input/day_12"
      |> File.read!
      |> Day12.solve(true)
      
    assert result == 87842
  end
end