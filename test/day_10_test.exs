defmodule Day10Test do
  use ExUnit.Case

  test "Part 1" do
    result =
      "input/day_10"
      |> File.read!
      |> Day10.solve(40)
    
    assert result == 252594
  end

  test "Part 2" do
    result =
      "input/day_10"
      |> File.read!
      |> Day10.solve(50)
    
    assert result == 3579328
  end
end