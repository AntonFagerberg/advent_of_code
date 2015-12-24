defmodule Day4 do
  def solve(input, target) do
    Stream.unfold(0, &({&1, &1 + 1}))
    |> Stream.map(&(:crypto.hash(:md5, "#{input}#{&1}") |> Base.encode16(case: :lower)))
    |> Enum.find_index(&(String.starts_with?(&1, target)))
  end
end