if not data.raw["custom-input"] or not data.raw["custom-input"]["toggle-trash-pickup"] then
    data:extend({
        {
            type = "custom-input",
            name = "toggle-trash-pickup",
            key_sequence = "N"
        }
    })
end

data:extend({
    {
        type = "shortcut",
        name = "trash-pickup-toggle",
        order = "c[toggles]-c[trash]",
        action = "lua",
        toggleable = true,
        localised_name = "Trash Pickup Toggle",
        technology_to_unlock = "logistic-robotics",
        icon = {
            filename = "__trash-pickup-mode__/trash.png",
            priority = "extra-high-no-scale",
            size = 32,
            scale = 0.5,
            mipmap_count = 2,
            flags = {"gui-icon"}
        },
        disabled_icon = {
            filename = "__trash-pickup-mode__/trash-white.png",
            priority = "extra-high-no-scale",
            size = 32,
            scale = 0.5,
            mipmap_count = 2,
            flags = {"gui-icon"}
        }
    }
})

