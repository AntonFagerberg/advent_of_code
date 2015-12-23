defmodule Day20Test do
  use ExUnit.Case
  
  test "Part 1 (test)" do
    assert Day20.solve_1(10) == 1
    assert Day20.solve_1(30) == 2
    assert Day20.solve_1(40) == 3
    assert Day20.solve_1(70) == 4
    assert Day20.solve_1(60) == 4
    assert Day20.solve_1(120) == 6
    assert Day20.solve_1(80) == 6
    assert Day20.solve_1(150) == 8
    assert Day20.solve_1(130) == 8
  end
  
  @tag timeout: :infinity
  test "Part 1" do
    result = 
      "input/day_20"
      |> File.read!
      |> Integer.parse
      |> elem(0)
      |> Day20.solve_1
    
    assert result == 776160
  end
  
  @tag timeout: :infinity
  test "Part 2" do
    result = 
      "input/day_20"
      |> File.read!
      |> Integer.parse
      |> elem(0)
      |> Day20.solve_2
      
    assert result == 786240
  end
end