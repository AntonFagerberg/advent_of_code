defmodule Day22 do
  def solve_1(input, part_2 \\ false) do
    spells = [
      [mana: 53, damage: 4],
      [mana: 73, damage: 2, heal: 2],
      [mana: 113, effect: [time: 6, armor: 7]],
      [mana: 173, effect: [time: 6, damage: 3]],
      [mana: 229, effect: [time: 5, mana: 101]]
    ]

    [[boss_hp, boss_dmg]] = Regex.scan(~r/Hit Points: (\d+)\nDamage: (\d+)/, input, capture: :all_but_first)
    boss_hp = boss_hp |> Integer.parse |> elem(0)
    boss_dmg = boss_dmg |> Integer.parse |> elem(0)
    
    {:ok, agent} = Agent.start_link(fn -> -1 end)
    
    hp = if part_2, do: 49, else: 50
    
    attack(part_2, agent, spells, boss_hp, boss_dmg, hp) |> Enum.min
  end
  
  defp buff(boss_hp, mana, buffs) do
    {boss_hp, mana, armor} =
      Enum.reduce(buffs, {boss_hp, mana, 0}, fn 
        [time: _time, damage: damage], {h, m, a} ->
          {h - damage, m, a}
          
        [time: _time, mana: mana_increase], {h, m, a} ->
          {h, m + mana_increase, a}
        
        [time: _time, armor: armor_increase], {h, m, a} ->
          {h, m, a + armor_increase}
      end)
      
    buffs =
      buffs
      |> Enum.map(&(Dict.update(&1, :time, nil, fn time -> time - 1 end)))
      |> Enum.filter(fn buff -> buff[:time] > 0 end)

    {boss_hp, mana, armor, buffs}
  end
  
  defp defend(part_2, agent, spells, boss_hp, boss_dmg, hp \\ 50, mana, armor, buffs, mana_spent) do
    mana_max = Agent.get(agent, fn i -> i end)
    {boss_hp, mana, armor, buffs} = buff(boss_hp, mana, buffs)  
    
    cond do
      mana_max != -1 && mana_spent >= mana_max -> []
      
      boss_hp <= 0 ->
        Agent.update(agent, fn _ -> mana_spent end)
        [mana_spent]
      
      true ->
        dmg_diff = boss_dmg - armor
        if dmg_diff <= 0, do: dmg_diff = 1
        if part_2, do: dmg_diff = dmg_diff + 1
        
        attack(part_2, agent, spells, boss_hp, boss_dmg, hp - dmg_diff, mana, armor, buffs, mana_spent)
    end
  end
  
  defp attack(part_2, agent, spells, boss_hp, boss_dmg, hp \\ 50, mana \\ 500, armor \\ 0, buffs \\ [], mana_spent \\ 0) do
    mana_max = Agent.get(agent, fn i -> i end)
    
    if hp <= 0 || (mana_max != -1 && mana_spent >= mana_max) do
      []
    else
      {boss_hp, mana, armor, buffs} = buff(boss_hp, mana, buffs)  
      
      if boss_hp <= 0 do
        Agent.update(agent, fn _ -> mana_spent end)
        [mana_spent]
      else
        available_spells = spells |> Enum.filter(fn list -> list[:mana] <= mana end)

        if available_spells == [] do
          []
        else
          available_spells
          |> Enum.flat_map(fn
          [mana: mana_cost, damage: dmg, heal: heal] -> defend(part_2, agent, spells, boss_hp - dmg, boss_dmg, hp + heal, mana - mana_cost, armor, buffs, mana_spent + mana_cost)
            [mana: mana_cost, damage: dmg] -> defend(part_2, agent, spells, boss_hp - dmg, boss_dmg, hp, mana - mana_cost, armor, buffs, mana_spent + mana_cost)
            [mana: mana_cost, effect: effect] ->
              if Enum.any?(buffs, fn buff -> Dict.drop(buff, [:time]) == Dict.drop(effect, [:time]) end) do
                []
              else
                defend(part_2, agent, spells, boss_hp, boss_dmg, hp, mana - mana_cost, armor, [effect] ++ buffs, mana_spent + mana_cost)
              end
          end)
        end
      end
    end
  end
end