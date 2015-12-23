defmodule Day22Test do
  use ExUnit.Case
  
  test "Part 1" do
    result = File.read!("input/day_22") |> Day22.solve_1
    assert result == 1269
  end
  
  test "Part 2" do
    result = File.read!("input/day_22") |> Day22.solve_1(true)
    assert result == 1309
  end
end