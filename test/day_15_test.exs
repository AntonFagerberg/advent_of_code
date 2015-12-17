defmodule Day15Test do
  use ExUnit.Case
  
  test "Part 1 (test)" do
    result = File.read!("input/day_15_test") |> Day15.solve
    assert result == 62842880
  end
  
  test "Part 1" do
    result = File.read!("input/day_15") |> Day15.solve
    assert result == 13882464
  end
  
  test "Part 2" do
    result = File.read!("input/day_15") |> Day15.solve(500)
    assert result == 11171160
  end
end
