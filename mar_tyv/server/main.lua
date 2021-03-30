ESX 				= nil
local Users         = {}

---- MENU

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('cuffServer')
AddEventHandler('cuffServer', function(closestID)
	TriggerClientEvent('cuffClient', closestID)
end)

RegisterServerEvent('unCuffServer')
AddEventHandler('unCuffServer', function(closestID)
	TriggerClientEvent('unCuffClient', closestID)
end)

RegisterServerEvent('dragServer')
AddEventHandler('dragServer', function(target)
  local _source = source
  TriggerClientEvent('cuffscript:drag', target, _source)
end)

RegisterServerEvent('Mar:putInVehicle')
AddEventHandler('Mar:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('Mar:putInVehicle', target)
end)

RegisterServerEvent('Mar:OutVehicle')
AddEventHandler('Mar:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('Mar:OutVehicle', target)
end)

ESX.RegisterUsableItem('kajdanki', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('cuffs:OpenMenu', source)
end)

RegisterServerEvent('esx_worek:closest')
AddEventHandler('esx_worek:closest', function()
    local name = GetPlayerName(najblizszy)
    TriggerClientEvent('esx_worek:nalozNa', najblizszy)
end)

RegisterServerEvent('esx_worek:sendclosest')
AddEventHandler('esx_worek:sendclosest', function(closestPlayer)
    najblizszy = closestPlayer
end)

RegisterServerEvent('esx_worek:zdejmij')
AddEventHandler('esx_worek:zdejmij', function()
    TriggerClientEvent('esx_worek:zdejmijc', najblizszy)
end)

---- END MENU


ESX.RegisterServerCallback('mar_tyv:getValue', function(source, cb, targetSID)
    if Users[targetSID] then
        cb(Users[targetSID])
    else
        cb({value = false, time = 0})
    end
end)

ESX.RegisterServerCallback('mar_tyv:getOtherPlayerData', function(source, cb, target)

    local xPlayer = ESX.GetPlayerFromId(target)

    local data = {
      name        = GetPlayerName(target),
      inventory   = xPlayer.inventory,
      accounts    = xPlayer.accounts,
      money       = xPlayer.get('money'),
      weapons     = xPlayer.loadout

    }

      cb(data)

end)


RegisterServerEvent('mar_tyv:stealPlayerItem')
AddEventHandler('mar_tyv:stealPlayerItem', function(target, itemType, itemName, amount)

    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        print("item_standard")

        local label = sourceXPlayer.getInventoryItem(itemName).label
        local itemWeight = sourceXPlayer.getInventoryItem(itemName).Weight
        local sourceItemCount = sourceXPlayer.getInventoryItem(itemName).count
        local targetItemCount = targetXPlayer.getInventoryItem(itemName).count

        if amount > 0 and targetItemCount >= amount then
    
            if itemWeight == -1 and (sourceItemCount + amount) > itemWeight then
                TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('ex_inv_lim_target'))
                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('ex_inv_lim_source'))
            else

                targetXPlayer.removeInventoryItem(itemName, amount)
                sourceXPlayer.addInventoryItem(itemName, amount)

                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_stole') .. ' ~g~x' .. amount .. ' ' .. label .. ' ~w~' .. _U('from_your_target') )
                TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('someone_stole') .. ' ~r~x'  .. amount .. ' ' .. label )

            end

        else
             TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
        end

    end

  if itemType == 'item_money' then

    if amount > 0 and targetXPlayer.get('money') >= amount then

      targetXPlayer.removeMoney(amount)
      sourceXPlayer.addMoney(amount)

      TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_stole') .. ' ' .. amount .. ' ~w~' .. _U('from_your_target') )
      TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('someone_stole') .. '  '  .. amount )

    else
      TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
    end

  end

  if itemType == 'item_account' then

    if amount > 0 and targetXPlayer.getAccount(itemName).money >= amount then

        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney(itemName, amount)

        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_stole') .. ' ' .. amount .. ' ~w~' .. _U('of_black_money') .. ' ' .. _U('from_your_target') )
        TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('someone_stole') .. ' '  .. amount .. ' ~w~' .. _U('of_black_money') )

    else
        TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
    end

  end

  if itemType == 'item_weapon' then
    print("Item_weapon")
    if amount == nil then amount = 0 end

        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon(itemName, amount)

        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_stole') .. ' ' .. amount .. ' ' .. label .. ' ~w~' .. _U('from_your_target') )
        TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('someone_stole') .. ' '  .. amount .. ' ' .. label )
  end
end)

RegisterServerEvent("mar_tyv:update")
AddEventHandler("mar_tyv:update", function(bool)
	local source = source
	Users[source] = {value = bool, time = os.time()}
end)

RegisterServerEvent("mar_tyv:getValue")
AddEventHandler("mar_tyv:getValue", function(targetSID)
    local source = source
	if Users[targetSID] then
		TriggerClientEvent("mar_tyv:returnValue", source, Users[targetSID])
	else
		TriggerClientEvent("mar_tyv:returnValue", source, Users[targetSID])
	end
end)


---- HANDCUFFS + ROPE ----

ESX.RegisterServerCallback('mar_tyv:getItemQ', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = xPlayer.getInventoryItem(item).count
    cb(quantity)
end)