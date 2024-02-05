local shortcutEnabled = function(player)
    return player.is_shortcut_toggled("trash-pickup-mode-toggle")
end

script.on_event(defines.events.on_player_mined_entity, function(event) 
    local player = game.get_player(event.player_index)
    if not shortcutEnabled(player) then
        return end

    if not player.mod_settings["trash-pickup-mode-enable-mining"].value then
        return end

    local trashInventory = player.get_inventory(defines.inventory.character_trash)
    local mainInventory = player.get_main_inventory()

    for item, count in pairs(event.buffer.get_contents()) do
        trashInventory.insert({name=item, count=count})
    end

    event.buffer.clear()
end)

script.on_event(defines.events.on_picked_up_item, function(event)
    local player = game.get_player(event.player_index)
    if not shortcutEnabled(player) then
        return end

    if not player.mod_settings["trash-pickup-mode-enable-pickup"].value then 
        return end

    local trashInventory = player.get_inventory(defines.inventory.character_trash)
    local mainInventory = player.get_main_inventory()


    mainInventory.remove(event.item_stack)
    trashInventory.insert(event.item_stack)
end)

script.on_event(defines.events.on_player_main_inventory_changed, function(event)
    local player = game.get_player(event.player_index)
    
    if not shortcutEnabled(player) then
        return end

    if not player.mod_settings["trash-pickup-mode-enable-other"].value then
        return end
    
    if not inventoryInitialized then
        playerInventory = player.get_main_inventory().get_contents()
        inventoryInitialized = true
    end

    local trashInventory = player.get_inventory(defines.inventory.character_trash)
    local mainInventory = player.get_main_inventory()
    local inventoryContent = mainInventory.get_contents()
    local diff = nil

    for item, amount in pairs (inventoryContent) do
        if playerInventory[item] ~= nil then
            diff = amount - playerInventory[item]
        else
            diff = amount
        end

        local foo = string.find(item, "construction%-robot")

        if foo then
            goto continue
        end

        if (diff ~= nil and diff > 0) then
            mainInventory.remove({name=item, count=diff})
            trashInventory.insert({name=item, count=diff})
        end
        ::continue::
    end
end)

script.on_load(function()
    inventoryInitialized = false
end)

script.on_event(defines.events.on_research_reversed, function(event)
    if (event.research.name == "logistic-robotics") then
        for id, player in pairs(game.players) do
            player.set_shortcut_available("trash-pickup-mode-toggle", false)
        end
    end
end)

script.on_event(defines.events.on_research_finished, function(event)
    if event.research.name == "logistic-robotics" then
        for id, player in pairs(game.players) do
            player.set_shortcut_available("trash-pickup-mode-toggle", true)
        end
    end
end)

script.on_event({defines.events.on_lua_shortcut, "trash-pickup-mode-toggle-input"}, function(event)
    if (event.prototype_name ~= nil and event.prototype_name ~= "trash-pickup-mode-toggle") then
        return 
    end

    if (event.name == "trash-pickup-mode-toggle-input" and not player.is_shortcut_available("trash-pickup-mode-toggle")) then
        return end
    
    local player = game.get_player(event.player_index)

    if player.character == nil then
        player.print("Can't toggle trash mode without a character", {r = 1.0} )
        return end

    player.set_shortcut_toggled("trash-pickup-mode-toggle", not shortcutEnabled(player))

    if shortcutEnabled(player) and player.character_personal_logistic_requests_enabled and player.mod_settings["trash-pickup-mode-disable-logi-requests"].value then 
        player.character_personal_logistic_requests_enabled = false
    end

    playerInventory = player.get_main_inventory().get_contents()
end)

script.on_event(defines.events.on_player_created, function(event)
    local player = game.get_player(event.player_index)

    if player.force.technologies["logistic-robotics"].researched then
        player.set_shortcut_available("trash-pickup-mode-toggle", true)
    else
        player.set_shortcut_available("trash-pickup-mode-toggle", false)
    end
end)