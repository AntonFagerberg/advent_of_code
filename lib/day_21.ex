defmodule Day21 do
  def solve_1(shop, boss) do
    inventory = make_inventory(shop)
    boss_stats = make_boss(boss)
      
    inventory
    |> Enum.map(&(attack(&1, boss_stats, 100)))
    |> Enum.filter(fn {win, _} -> win end)
    |> Enum.map(fn {_, cost} -> cost end)
    |> Enum.min
  end
  
  def solve_2(shop, boss) do
    inventory = make_inventory(shop)
    boss_stats = make_boss(boss)
      
    inventory
    |> Enum.map(&(attack(&1, boss_stats, 100)))
    |> Enum.filter(fn {win, _} -> !win end)
    |> Enum.map(fn {_, cost} -> cost end)
    |> Enum.max
  end
  
  defp make_inventory(shop) do
    shop
    |> String.split("\n\n")
    |> Enum.map(fn string ->
      string
      |> String.replace(" +", "")
      |> String.split(~r/( |\n)/, trim: true) 
      |> Enum.drop(4)
      |> Enum.chunk(4, 4)
      |> Enum.map(fn [_, a, b, c] ->
        a = a |> Integer.parse |> elem(0)
        b = b |> Integer.parse |> elem(0)
        c = c |> Integer.parse |> elem(0)
        
        {a, b, c}
      end)
    end)
    |> combinations
  end
  
  defp make_boss(boss) do
    boss
    |> String.split("\n")
    |> Enum.map(&(Regex.scan(~r/\d+/, &1) |> hd |> hd |> Integer.parse |> elem(0)))
  end
  
  defp defend({c, _, a} = p, [bh, bd, _] = b, h) do
    if (bh <= 0) do
      {true, c}
    else
      dmg = bd - a
      if dmg <= 0, do: dmg = 1
      attack(p, b, h - dmg)
    end
  end
  
  defp attack({c, d, _} = p, [bh, bd, ba], h) do
    if (h <= 0) do
      {false, c}
    else
      dmg = d - ba
      if dmg <= 0, do: dmg = 1
      defend(p, [bh - dmg, bd, ba], h)
    end
  end
  
  defp combinations([weapons, armors, rings]) do
    weapons
    |> Enum.flat_map(fn weapon ->
      Enum.flat_map(0..length(armors), fn i ->
        armor = Enum.slice(armors, i, 1)
        
        Enum.flat_map(0..length(rings), fn ii ->
          ring_1 = Enum.slice(rings, ii, 1)
          indexes = if ii == length(rings), do: [ii+1], else: (ii + 1)..length(rings)
          
          Enum.map(indexes, fn iii ->
            ring_2 = Enum.slice(rings, iii, 1)
            [weapon] ++ armor ++ ring_1 ++ ring_2
          end)
        end)
      end)
    end)
    |> Enum.map(fn list ->
      Enum.reduce(list, {0, 0, 0}, fn {c, d, a}, {ca, da, aa} ->
        {c + ca, d + da, a + aa}
      end)
    end)
  end
end