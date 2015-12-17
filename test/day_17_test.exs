defmodule Day_17Test do
  use ExUnit.Case
  
  test "Part 1 (test)" do
    result = File.read!("input/day_17_test") |> Day17.solve_1(25)
    assert result == 4
  end
  
  test "Part 1" do
    result = File.read!("input/day_17") |> Day17.solve_1(150)
    assert result == 1304
  end
  
  test "Part 2 (test)" do
    result = File.read!("input/day_17_test") |> Day17.solve_2(25)
    assert result == 3
  end
  
  test "Part 2" do
    result = File.read!("input/day_17") |> Day17.solve_2(150)
    assert result == 18
  end
end
