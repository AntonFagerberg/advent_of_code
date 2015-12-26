defmodule Day25Test do
  use ExUnit.Case
  
  test "Part 1" do
    result = File.read!("input/day_25") |> Day25.solve
    assert result == 8997277
  end
  
  test "Part 1 (test)" do
    assert Day25.solve("2 1") == 31916031
    assert Day25.solve("2 2") == 21629792
    assert Day25.solve("3 1") == 16080970
    assert Day25.solve("6 1") == 33071741
    assert Day25.solve("6 5") == 1534922
    assert Day25.solve("6 6") == 27995004
  end
end