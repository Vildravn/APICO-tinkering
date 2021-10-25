function define_forge()
    api_define_menu_object(DEF_FORGE, "sprites/items/item_forge.png", "sprites/gui/menu_forge.png", {
        define = "forge_define",
        draw = "forge_draw",
        tick = "forge_tick",
        change = "forge_change"
    })
end

function forge_define(menu_id)
    -- create initial properties
    api_dp(menu_id, "working", false)
    api_dp(menu_id, "p_start", 0)
    api_dp(menu_id, "p_end", 1)
    api_dp(menu_id, "fuel", 0)
    api_dp(menu_id, "fuel_max", 1200)

    api_define_gui(menu_id, "progress_bar", 49, 31, "forge_progress_tooltip", "sprites/gui/gui_forge_arrow.png")
    api_define_gui(menu_id, "fuel_bar", 26, 38, "forge_fuel_tooltip", "sprites/gui/gui_forge_fuel.png")

    -- save gui sprite references for later
    api_dp(menu_id, "progress_bar_sprite", api_get_sprite(MOD_NAME .. "_progress_bar"))
    api_dp(menu_id, "fuel_bar_sprite", api_get_sprite(MOD_NAME .. "_fuel_bar"))

    -- add our p_start and p_end props to the default _fields list so the progress is saved 
    -- any keys in _fields will get their value saved when the game saves, and loaded when the game loads again
    fields = {"p_start", "p_end", "fuel", "fuel_max"}
    fields = api_sp(menu_id, "_fields", fields)
end

function forge_change(menu_id)
    if api_get_slot(menu_id, 1)["item"] ~= "" and
        (api_get_slot(menu_id, 2)["item"] ~= "" or api_gp(menu_id, "fuel") > 0) then
        api_sp(menu_id, "working", true)
    end
end

function forge_tick(menu_id)
    fuel_slot = api_get_slot(menu_id, 2)
    fuel_item = fuel_slot["item"]

    if api_gp(menu_id, "fuel") < api_gp(menu_id, "fuel_max") and fuel_item ~= "" then
        fuel_val = get_fuel_value(fuel_item)

        api_slot_decr(fuel_slot["id"])
        api_sp(menu_id, "fuel", api_gp(menu_id, "fuel") + fuel_val)
    end

    -- handle countdown if working
    if api_gp(menu_id, "working") == true then
        -- add to counter
        api_sp(menu_id, "p_start", api_gp(menu_id, "p_start") + 0.01)
        api_sp(menu_id, "fuel", api_gp(menu_id, "fuel") - (api_gp(menu_id, "fuel_max") / 12000))

        -- if we hit the end, i.e. 10s have passed
        if api_gp(menu_id, "p_start") >= api_gp(menu_id, "p_end") then
            -- reset the counter
            api_sp(menu_id, "p_start", 0)

            -- get the first input slot to get an item
            input_slot = api_get_slot(menu_id, 1)
            input_item = input_slot["item"]

            if input_item ~= "" then
                api_slot_decr(input_slot["id"])

                out_item = ""
                if input_item == "log" then
                    out_item = MOD_NAME .. "_charcoaled_log"
                elseif input_item == MOD_NAME .. "_copper_dust" then
                    out_item = MOD_NAME .. "_copper_bar"
                end

                output_slot = api_get_slot(menu_id, 3)
                if output_slot["item"] == "" then
                    api_slot_set(output_slot["id"], out_item, 1)
                elseif output_slot["item"] == out_item then
                    api_slot_incr(output_slot["id"])
                end
            end
        end

        if api_get_slot(menu_id, 1)["item"] == "" or api_gp(menu_id, "fuel") <= 0 then
            api_sp(menu_id, "p_start", 0)
            api_sp(menu_id, "working", false)
        end
    end
end

function forge_draw(menu_id)
    -- get camera
    cam = api_get_cam()

    prog_gui = api_get_inst(api_gp(menu_id, "progress_bar"))
    prog_spr = api_gp(menu_id, "progress_bar_sprite")

    prog_gx = prog_gui["x"] - cam["x"]
    prog_gy = prog_gui["y"] - cam["y"]
    progress = (api_gp(menu_id, "p_start") / api_gp(menu_id, "p_end") * 47)
    api_draw_sprite_part(prog_spr, 2, 0, 0, progress, 10, prog_gx, prog_gy)
    api_draw_sprite(prog_spr, 1, prog_gx, prog_gy)

    if api_get_highlighted("ui") == prog_gui["id"] then
        api_draw_sprite(prog_spr, 0, prog_gx, prog_gy)
    end

    fuel_gui = api_get_inst(api_gp(menu_id, "fuel_bar"))
    fuel_spr = api_gp(menu_id, "fuel_bar_sprite")

    fuel_gx = fuel_gui["x"] - cam["x"]
    fuel_gy = fuel_gui["y"] - cam["y"]
    fuel = (api_gp(menu_id, "fuel") / api_gp(menu_id, "fuel_max") * 20)
    api_draw_sprite_part(fuel_spr, 2, 0, fuel - 20, 4, 20, fuel_gx, fuel_gy)
    api_draw_sprite(fuel_spr, 1, fuel_gx, fuel_gy)

    if api_get_highlighted("ui") == fuel_gui["id"] then
        api_draw_sprite(fuel_spr, 0, fuel_gx, fuel_gy)
    end
end

function forge_progress_tooltip(menu_id)
    progress = math.floor((api_gp(menu_id, "p_start") / api_gp(menu_id, "p_end")) * 100)
    percent = tostring(progress) .. "%"
    return {{"Progress", "FONT_WHITE"}, {percent, "FONT_BGREY"}}
end

function forge_fuel_tooltip(menu_id)
    remaining = math.floor((api_gp(menu_id, "fuel") / api_gp(menu_id, "fuel_max")) * 1200)
    time = tostring(remaining) .. "s remaining!"
    return {{"Fuel", "FONT_WHITE"}, {time, "FONT_BGREY"}}
end
