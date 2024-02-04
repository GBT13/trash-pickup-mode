data:extend({
    {
        type = "bool-setting",
        name = "trash-pickup-mode-enable-mining",
        localised_name = "Trash mined items",
        localised_description = "Automatically move items that were picked up up by mining (ore, buildings) to logistic trash slots",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "setting-1"
    },
    {
        type = "bool-setting",
        name = "trash-pickup-mode-enable-pickup",
        localised_name = "Trash picked up items",
        localised_description = "Automatically move items that were picked up from the ground or belts to logistic trash slots",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "setting-2"
    },
    {
        type = "bool-setting",
        name = "trash-pickup-mode-enable-other",
        localised_name = "Trash everything moved into the inventory",
        localised_description = "Automatically move any item moved into the inventory by bots or by player to logistic trash slots",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "setting-3"
    }
})