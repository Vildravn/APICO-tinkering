MOD_NAME = "tinkering"

function register()
    return {
        name = MOD_NAME,
        hooks = {},
        modules = {"tome", "forge", "items", "bees", "definitions", "strings"}
    }
end

function init()
    api_set_devmode(true)

    define_items()

    define_tome()

    define_bees()

    define_forge()

    return "Success"
end
