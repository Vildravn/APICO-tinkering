function define_tome()
    api_define_menu_object(DEF_TINKERERS_TOME, "sprites/items/item_tinkerers_tome.png", "sprites/gui/menu_tome.png", {
        define = "tome_define",
        draw = "tome_draw"
    })
end

function tome_define(menu_id)
    --api_define_sprite("tome_button", "sprites/gui/button_tome.png", 2)
    --api_dp(menu_id, "tome_button_sprite", api_get_sprite(MOD_NAME .. "_tome_button"))

    api_define_button(menu_id, "tome_intro_button", 2, 4, "Introduction", "tome_intro_button_click", "sprites/gui/button_tome.png")
end

function tome_draw(menu_id)
    api_draw_button(api_gp(menu_id, "tome_intro_button"), true)

    -- cam = api_get_cam()

    -- button_x = menu_id["x"] - cam["x"]
    -- button_y = menu_id["y"] - cam["y"]

    -- tome_button_sprite = api_gp(menu_id, "tome_button_sprite")
    -- api_draw_sprite(tome_button_sprite, 0, button_x, button_y)
end

function tome_intro_button_click()
    api_log("tome", "intro button clicked")
end
