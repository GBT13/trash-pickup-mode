data:extend({
    {
        type = "custom-input",
        name = "trash-pickup-mode-toggle-input",
        localised_name = "Toggle Trash Pickup Mode",
        key_sequence = "ALT + T"
    }
})


data:extend({
    {
        type = "shortcut",
        name = "trash-pickup-mode-toggle",
        order = "c[toggles]-c[trash]",
        action = "lua",
        toggleable = true,
        localised_name = "Trash Pickup Toggle",
        technology_to_unlock = "logistic-robotics",
        associated_control_input = "trash-pickup-mode-toggle-input",
        icon = {
            filename = "__core__/graphics/icons/mip/trash.png",
            priority = "extra-high-no-scale",
            size = 32,
            scale = 0.5,
            mipmap_count = 2,
            flags = {"gui-icon"}
        },
        disabled_icon = {
            filename = "__core__/graphics/icons/mip/trash-white.png",
            priority = "extra-high-no-scale",
            size = 32,
            scale = 0.5,
            mipmap_count = 2,
            flags = {"gui-icon"}
        }
    }
})

