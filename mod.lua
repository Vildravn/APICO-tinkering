MOD_NAME = "tinkering"

function register()
    return {
        name = MOD_NAME,
        hooks = {"ready", "gui", "click"},
        modules = {"tome", "forge", "items", "bees", "definitions", "strings"}
    }
end

TOME_MENU = nil
TOME_OBJ = nil

function init()
    api_set_devmode(true)

    define_items()

    define_tome()

    define_bees()

    define_forge()

    return "Success"
end

function ready()
    tomes = api_get_menu_objects(nil, MOD_NAME .. "_tinkerers_tome_obj")
    if #tomes == 0 then
        api_create_obj(MOD_NAME .. "_tinkerers_tome_obj", -32, -32)
    end

    discovery = api_check_discovery(MOD_NAME .. "_tinkerers_tome")
    if discovery == false then
        api_give_item(MOD_NAME .. "_tinkerers_tome", 1)
    end
end

function gui()
    if api_gp(TOME_OBJ, "open") == true then
        game = api_get_game_size()
        cam = api_get_cam()

        api_draw_rectangle(0, 0, game["width"], game["height"], "BLACK", false, 0.9)

        tome_draw(TOME_MENU)
    end
end

function click(button, click_type)
    if button == "RIGHT" and click_type == "PRESSED" then
        highlighted = api_get_highlighted("slot")
        if highlighted ~= nil then
            slot = api_get_slot_inst(highlighted)
            if slot["item"] == MOD_NAME .. "_tinkerers_tome" then
                api_toggle_menu(TOME_MENU, true)
            end
        end
    end
end