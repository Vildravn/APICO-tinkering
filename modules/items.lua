function define_items()
    api_define_item(DEF_COPPER_DUST, "sprites/items/item_copper_dust.png")

    api_define_item(DEF_COPPER_BAR, "sprites/items/item_copper_bar.png")

    api_define_item(DEF_CHARCOALED_LOG, "sprites/items/item_charcoal.png")
end

function get_fuel_value(fuel_item)
    BASE_VAL = 5
    if fuel_item == "log" then
        return BASE_VAL
    elseif fuel_item == "planks1" then
        return BASE_VAL / 2
    elseif fuel_item == "sticks1" then
        return BASE_VAL / 4
    elseif fuel_item == MOD_NAME .. "_charcoaled_log" then
        return BASE_VAL * 2
    else
        return 0
    end
end
