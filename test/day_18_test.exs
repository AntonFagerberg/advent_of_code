defmodule Day18Test do
  use ExUnit.Case
  doctest Day18

  test "Day 18 test 1" do
    assert "input/day_18_test_1" |> File.read! |> Day18.solve(0) == 15
    assert "input/day_18_test_1" |> File.read! |> Day18.solve(1) == 11
    assert "input/day_18_test_1" |> File.read! |> Day18.solve(2) == 8
    assert "input/day_18_test_1" |> File.read! |> Day18.solve(3) == 4
    assert "input/day_18_test_1" |> File.read! |> Day18.solve(4) == 4
  end

  test "Day 18 test 2" do
    assert "input/day_18_test_2" |> File.read! |> Day18.solve(0, true) == 17
    assert "input/day_18_test_2" |> File.read! |> Day18.solve(1, true) == 18
    assert "input/day_18_test_2" |> File.read! |> Day18.solve(2, true) == 18
    assert "input/day_18_test_2" |> File.read! |> Day18.solve(3, true) == 18
    assert "input/day_18_test_2" |> File.read! |> Day18.solve(4, true) == 14
    assert "input/day_18_test_2" |> File.read! |> Day18.solve(5, true) == 17
  end

  @tag timeout: :infinity
  test "Day 18 puzzle 1" do
    assert "input/day_18" |> File.read! |> Day18.solve(100) == 821
  end

  @tag timeout: :infinity
  test "Day 18 puzzle 2" do
    assert "input/day_18" |> File.read! |> Day18.solve(100, true) == 886
  end
end
