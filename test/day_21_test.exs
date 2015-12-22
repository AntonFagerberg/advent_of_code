defmodule Day21Test do
  use ExUnit.Case
  
  test "Part 1" do
    shop = File.read!("input/day_21_shop")
    boss = File.read!("input/day_21")
    
    assert Day21.solve_1(shop, boss) == 121
  end

  test "Part 2" do
    shop = File.read!("input/day_21_shop")
    boss = File.read!("input/day_21")
    
    assert Day21.solve_2(shop, boss) == 201
  end
end