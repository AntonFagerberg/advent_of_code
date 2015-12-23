defmodule Day23Test do
  use ExUnit.Case
  
  test "Part 1" do
    result = File.read!("input/day_23") |> Day23.solve
    assert result == %{"a" => 1, "b" => 170}
  end
  
  test "Part 2" do
    result = File.read!("input/day_23") |> Day23.solve(true)
    assert result == %{"a" => 1, "b" => 247}
  end
  
  test "Part 1 (test 1)" do
    registers =
      [
        "inc a",
        "inc b",
        "inc a"
      ]
      |> Enum.join("\n")
      |> Day23.solve
      
    assert registers == %{"a" => 2, "b" => 1}
  end
  
  test "Part 1 (test 2)" do
    registers =
      [
        "inc a",
        "jmp 3",
        "inc b",
        "inc b",
        "inc a"
      ]
      |> Enum.join("\n")
      |> Day23.solve
      
    assert registers == %{"a" => 2, "b" => 0}
  end
  
  test "Part 1 (test 3)" do
    registers =
      [
        "jmp 3",
        "inc a",
        "jmp 2",
        "jmp -2"
      ]
      |> Enum.join("\n")
      |> Day23.solve
      
    assert registers == %{"a" => 1, "b" => 0}
  end
  
  test "Part 1 (test 4)" do
    registers =
      [
        "inc a",
        "jio a, 2",
        "jmp 0"
      ]
      |> Enum.join("\n")
      |> Day23.solve
      
    assert registers == %{"a" => 1, "b" => 0}
  end
  
  test "Part 1 (test 5)" do
    registers =
      [
        "jio a, 2",
        "inc b"
      ]
      |> Enum.join("\n")
      |> Day23.solve
      
    assert registers == %{"a" => 0, "b" => 1}
  end
  
  test "Part 1 (test 6)" do
    registers =
      [
        "inc a",
        "jio a, 2",
        "inc b",
        "inc a"
      ]
      |> Enum.join("\n")
      |> Day23.solve
      
    assert registers == %{"a" => 2, "b" => 0}
  end
  
  test "Part 1 (test 7)" do
    registers =
      [
        "inc a",
        "inc a",
        "jie a, -1"
      ]
      |> Enum.join("\n")
      |> Day23.solve
      
    assert registers == %{"a" => 3, "b" => 0}
  end
end