DEF_TINKERERS_TOME = {
    id = "tinkerers_tome",
    name = TINKERERS_TOME_NAME,
    category = CATEGORY_TINKERING,
    tooltip = TINKERERS_TOME_TOOLTIP,
    shop_key = true,
    shop_buy = 0,
    shop_sell = 0,
    layout = {},
    info = {},
    buttons = {},
    center = true,
    singular = true
}

DEF_COPPER_DUST = {
    id = "copper_dust",
    name = COPPER_DUST_NAME,
    category = CATEGORY_TINKERING,
    tooltip = COPPER_DUST_TOOLTIP,
    shop_key = false,
    shop_buy = 0,
    shop_sell = 5,
    machines = {MOD_NAME .. "_forge"}
}

DEF_COPPER_BEE = {
    id = "copper",
    title = COPPER_BEE_TITLE,
    latin = COPPER_BEE_LATIN,
    hint = COPPER_BEE_HINT,
    desc = COPPER_BEE_DESC,
    lifespan = {"Normal"},
    productivity = {"Normal"},
    fertility = {"Fecund"},
    stability = {"Normal"},
    behaviour = {"Crepuscular"},
    climate = {"Tropic"},
    rainlover = false,
    snowlover = false,
    grumpy = false,
    produce = MOD_NAME .. "_copper_dust",
    chance = 100,
    requirement = "",
    bid = "🜠1",
    tier = 3
}

DEF_FORGE = {
    id = "forge",
    name = FORGE_NAME,
    category = CATEGORY_TINKERING,
    tooltip = FORGE_TOOLTIP,
    shop_key = false,
    shop_buy = 0,
    shop_sell = 0,
    layout = {
        {7, 17, "Input", {"log", MOD_NAME .. "_copper_dust"}},
        {7, 40, "Input", {"log", "planks1", "planks2", "sticks1", "sticks2", "cog", MOD_NAME .. "_charcoaled_log"}},
        {122, 28, "Output"},
        {7, 66}, {30, 66}, {53, 66}, {76, 66}, {99, 66}, {122, 66}}, -- Extra Storage
    buttons = {"Help", "Move", "Target", "Close"},
    info = {
        {"1. Forged Item Input", "GREEN"},
        {"2. Forge Fuel", "YELLOW"},
        {"3. Forge Output", "RED"},
        {"4. Extra Storage", "WHITE"}},
    tools = {"mouse1", "hammer1"}
}

DEF_CHARCOALED_LOG = {
    id = "charcoaled_log",
    name = CHARCOALED_LOG_NAME,
    category = CATEGORY_TINKERING,
    tooltip = CHARCOALED_LOG_TOOLTIP,
    shop_key = false,
    shop_buy = 0,
    shop_sell = 0,
    machines = {MOD_NAME .. "_forge"}
}

DEF_COPPER_BAR = {
    id = "copper_bar",
    name = COPPER_BAR_NAME,
    category = CATEGORY_TINKERING,
    tooltip = COPPPER_BAR_TOOLTIP,
    shop_key = false,
    shop_buy = 0,
    shop_sell = 5,
    machines = {MOD_NAME .. "_forge"}
}
