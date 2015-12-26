defmodule Day24Test do
  use ExUnit.Case
  
  @tag timeout: :infinity
  test "Part 1" do
    result = File.read!("input/day_24") |> Day24.solve
    assert result == 10439961859
  end
  
  @tag timeout: :infinity
  test "Part 2" do
    result = File.read!("input/day_24") |> Day24.solve(4)
    assert result == 72050269
  end
  
  test "Part 1 (test)" do
    result =
      [1,2,3,4,5,7,8,9,10,11] |> Enum.join("\n")
      |> Day24.solve
    
    assert result == 99
  end
end