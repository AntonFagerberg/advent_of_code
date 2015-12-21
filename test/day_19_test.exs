defmodule Day19Test do
  use ExUnit.Case
  
  test "Part 1 (test)" do
    result =
      "input/day_19_test"
      |> File.read!
      |> Day19.solve_1
      
    assert result == 4
  end
  
  test "Part 1" do
    result =
      "input/day_19"
      |> File.read!
      |> Day19.solve_1
      
    assert result == 535
  end
  
  test "Part 2" do
    result = "input/day_19" |> File.read! |> Day19.solve_2
    assert result == 212
  end
end