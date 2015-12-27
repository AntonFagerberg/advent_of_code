defmodule Day7Test do
  use ExUnit.Case

  test "Part 1" do
    result = 
      "input/day_7"
      |> File.read!
      |> Day7.solve
      
    assert result == 3176
  end

  test "Part 2" do
    result = 
      "input/day_7"
      |> File.read!
      |> Day7.solve(true)
      
    assert result == 14710
  end
end