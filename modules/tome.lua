function define_tome()
    api_define_item(DEF_TOME_ITEM, "sprites/items/item_tinkerers_tome.png")

    api_define_menu_object(DEF_TOME_OBJ, "sprites/items/item_tinkerers_tome.png", "sprites/gui/menu_tome.png", {
        define = "tome_define",
    })
end

-- Define the list of buttons globally
tome_buttons = {{
    name = "tome_intro_button",
    pos_y = 4,
    text = "Introduction",
    func = "tome_intro_button_click"
}, {
    name = "tome_craft_button",
    pos_y = 19,
    text = "Crafting",
    func = "tome_craft_button_click"
}, {
    name = "tome_achi_button",
    pos_y = 34,
    text = "Achievements",
    func = "tome_achi_button_click"
}, {
    name = "tome_about_button",
    pos_y = 49,
    text = "About Mod",
    func = "tome_about_button_click"
}}

PAGE_INDEX = 1

function tome_define(menu_id)
    obj_id = api_get_menus_obj(menu_id)
    api_set_immortal(obj_id, true)

    -- Set globals
    TOME_MENU = menu_id
    TOME_OBJ = obj_id

    -- Save the button texture for the fake highlight later
    button_spr = api_define_sprite("tome_button", "sprites/gui/button_tome.png", 2)
    api_dp(menu_id, "tome_button_sprite", button_spr)

    -- Loop through the list of buttons to define them
    for i = 1, #tome_buttons do
        button = tome_buttons[i]

        api_define_button(menu_id, button["name"], 2, button["pos_y"], button["text"], button["func"], "sprites/gui/button_tome.png")
    end
end

function tome_draw(menu_id)
    menu = api_get_inst(menu_id)
    cam = api_get_cam()

    mx = menu["x"] - cam["x"]
    my = menu["y"] - cam["y"]

    -- Draw the menu
    api_draw_sprite(menu["sprite_index"], 0, mx, my)

    -- Loop through the list of buttons to draw them and draw their text on top
    -- If we let the api_draw_button func draw the text, it would be centered
    for i = 1, #tome_buttons do
        button = tome_buttons[i]

        api_draw_button(api_gp(menu_id, button["name"]), false)

        -- Fake the permanent highlight when a page is selected by drawing the highlighted frame over the button
        if i == PAGE_INDEX then
            button_spr = api_gp(menu_id, "tome_button_sprite")
            api_draw_sprite(button_spr, 1, mx + 2, my + button["pos_y"])
        end

        api_draw_text(mx + 16, my + button["pos_y"] + 1, button["text"], false, "FONT_WHITE")
    end

    if PAGE_INDEX == 1 then
        api_draw_text(mx + 148, my + 7, "Hey, nice to meet you too. Now we're introduced.", false, "FONT_BOOK", 136)
    elseif PAGE_INDEX == 2 then
        api_draw_text(mx + 148, my + 7, "Here you'll be able to craft stuff.", false, "FONT_BOOK", 136)
    elseif PAGE_INDEX == 3 then
        api_draw_text(mx + 148, my + 7, "Achievements? Yeah that's a stretch. We'll see.", false, "FONT_BOOK", 136)
    elseif PAGE_INDEX == 4 then
        api_draw_text(mx + 148, my + 7, "Version: Alpha 0.1", false, "FONT_BOOK", 136)
    end
end

function tome_intro_button_click()
    api_play_sound("click")
    PAGE_INDEX = 1
end

function tome_craft_button_click()
    api_play_sound("click")
    PAGE_INDEX = 2
end

function tome_achi_button_click()
    api_play_sound("click")
    PAGE_INDEX = 3
end

function tome_about_button_click()
    api_play_sound("click")
    PAGE_INDEX = 4
end