defmodule Day18 do
  def neighbor_index(x, y) do
    Enum.flat_map((x - 1)..(x + 1), fn xx ->
      Enum.flat_map((y - 1)..(y + 1), fn yy ->
        if x == xx && y == yy, do: [], else: [{xx, yy}]
      end)
    end)
  end

  def solve(input, iterations, part_2 \\ false) do
    grid =
      input
      |> String.split("\n")
      |> Enum.map(&(String.split(&1, "", trim: true)))

    rows = grid |> length
    cols = grid |> hd |> length

    row_index = 0..(rows - 1)
    col_index = 0..(cols - 1)

    Stream.iterate(0, &(&1))
    |> Enum.take(iterations)
    |> Enum.reduce(grid, fn (_, acc) ->
      Enum.map(row_index, fn y ->
        Enum.map(col_index, fn x ->
          self = acc |> Enum.at(y) |> Enum.at(x)

          neighbors_on =
            neighbor_index(x, y)
            |> Enum.filter( fn {xx, yy} -> xx >= 0 && yy >= 0 && xx < cols && y < rows end)
            |> Enum.map(fn {xx, yy} ->
              if part_2 && (xx == 0 || xx == cols - 1) && (yy == 0 || yy == rows - 1), do: "#",
              else: acc |> Enum.at(yy, []) |> Enum.at(xx)
            end)
            |> Enum.count(&(&1 == "#"))

          cond do
            part_2 && (x == 0 || x == cols - 1) && (y == 0 || y == rows - 1) -> "#"
            self == "#" -> if neighbors_on == 2 || neighbors_on == 3, do: "#", else: "."
            self == "." -> if neighbors_on == 3, do: "#", else: "."
          end
        end)
      end)
    end)
    |> Enum.flat_map(&(&1))
    |> Enum.count(&(&1 == "#"))
  end
end
