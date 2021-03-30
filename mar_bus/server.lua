ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('mar_bus:pay')
AddEventHandler('mar_bus:pay', function()
	local src = source
	local xPlayer  = ESX.GetPlayerFromId(src)

			xPlayer.removeMoney(math.random(650, 850)) -- Tilfældig pris mellem 650 og 850 kr
			--xPlayer.removeMoney(500) -- Fast pris på 500 kr
			
end)