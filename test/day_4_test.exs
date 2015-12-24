defmodule Day4Test do
  use ExUnit.Case

  @tag timeout: :infinity
  test "Part 1" do
    result = 
      "input/day_4"
      |> File.read!
      |> Day4.solve("00000")
      
    assert result == 254575
  end

  @tag timeout: :infinity
  test "Part 2" do
    result = 
      "input/day_4"
      |> File.read!
      |> Day4.solve("000000")
      
    assert result == 1038736
  end
end