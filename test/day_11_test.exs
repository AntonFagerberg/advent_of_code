defmodule Day11Test do
  use ExUnit.Case
  
  test "Passwords must include one increasing straight of at least three letters" do
    assert Day11.req_1("hijklmmn")
    
    all_true =
      ["abc", "bcd", "cde", "xyz"]
      |> Enum.map(&Day11.req_1/1)
      |> Enum.reduce(true, &(&1 && &2))
    
    assert all_true
  end

  test "Passwords may not contain the letters i, o, or l" do
    all_false =
      ["i", "o", "l"]
      |> Enum.map(&Day11.req_2/1)
      |> Enum.reduce(false, &(&1 || &2))
    
    assert !all_false
  end
  
  test "Passwords must contain at least two different, non-overlapping pairs of letters" do
    all_true =
      ["aabb", "zzaa"]
      |> Enum.map(&Day11.req_3/1)
      |> Enum.reduce(true, &(&1 && &2))
      
    assert all_true
    assert !Day11.req_3("aaaa")
  end
  
  test "Lower case character to integer conversion and back" do
    input = "anton"
    output = input |> Day11.string_to_int |> Day11.int_to_string
    assert input == output
  end
  
  test "Part 1 (test)" do
    assert Day11.req_1("hijklmmn")
    assert !Day11.req_2("hijklmmn")
    
    assert Day11.req_3("abbceffg")
    assert !Day11.req_1("abbceffg")
    
    assert !Day11.req_3("abbcegjk")
  end
  
  test "Part 1" do
    assert Day11.solve("hxbxwxba") == "hxbxxyzz"
  end
  
  @tag timeout: :infinity
  test "Part 2" do
    old_index = "hxbxwxba" |> Day11.solve |> Day11.string_to_int
    result = 1 + old_index |> Day11.int_to_string |> Day11.solve
    assert result == "hxcaabcc"
  end
end
