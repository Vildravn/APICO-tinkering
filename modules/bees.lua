function define_bees()
    api_define_bee(DEF_COPPER_BEE, "sprites/bees/copper/copper_bee_item.png", "sprites/bees/copper/copper_bee_shiny.png",
        "sprites/bees/copper/copper_bee_hd.png", {
            r = 218,
            g = 138,
            b = 103
        }, "sprites/bees/copper/copper_bee_mag.png", COPPER_BEE_MAG_TITLE, COPPER_BEE_MAG_TEXT)

    api_define_bee_recipe("rocky", "uncommon", "copper-haired", "mutation_chance")
end

function mutation_chance(bee_a, bee_b, beehive)
    if (bee_a == "rocky" and bee_b == "uncommon") or (bee_a == "uncommon" and bee_b == "rocky") then
        chance = api_random(99) + 1
        if chance <= 40 then
            return true
        end
    end

    return false
end