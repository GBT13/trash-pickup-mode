local shortcutEnabled = function(player)
    return player.is_shortcut_toggled("trash-pickup-toggle")
end

script.on_event(defines.events.on_player_mined_entity, function(event) 
    local player = game.get_player(event.player_index)
    if not shortcutEnabled(player) then
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

    local trashInventory = player.get_inventory(defines.inventory.character_trash)
    local mainInventory = player.get_main_inventory()


    mainInventory.remove(event.item_stack)
    trashInventory.insert(event.item_stack)
end)

script.on_event(defines.events.on_player_main_inventory_changed, function(event)
    local player = game.get_player(event.player_index)
    if not shortcutEnabled(player) then
        return end

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

        if (diff ~= nil and diff > 0) then
            game.print(item)
            game.print(diff)
            mainInventory.remove({name=item, count=diff})
            trashInventory.insert({name=item, count=diff})
        end
    end

    playerInventory = inventoryContent
end)

-- script.on_event(defines.events.on_player_created, function()
--     game.print("dadw")
--     playerinventories = {}
--     local players = game.players

--     for index, player in pairs (players) do
--         playerinventories.insert(player.index, player.get_main_inventory().get_contents())
--     end


--     -- playerInventory = player.get_main_inventory().get_contents()
-- end)

script.on_event(defines.events.on_lua_shortcut, function(event)
    if (event.prototype_name ~= "trash-pickup-toggle") then
        return 
    end
    
    local player = game.get_player(event.player_index)

    player.set_shortcut_toggled("trash-pickup-toggle", not shortcutEnabled(player))
    playerInventory = player.get_main_inventory().get_contents()
end)