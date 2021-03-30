local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local v1 = vector4(687.52, 239.89, 93.6, 360)
local v2 = vector4(1989.81, 3055.3, 47.22, 360)
local v3 = vector4(-217.71, 6175.97, 31.21, 360)
local ped = GetPlayerPed(-1)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
		while GetDistanceBetweenCoords(687.52, 3055.3, 93.6, GetEntityCoords(LocalPed())) < 12 do
			Citizen.Wait(1)
			Draw3DText(v1.x,v1.y,v1.z, "[~r~E~w~] for at tage bussen")
		end
		while GetDistanceBetweenCoords(1989.81, 3055.3, 47.22, GetEntityCoords(LocalPed())) < 12 do
			Citizen.Wait(1)
			Draw3DText(v2.x,v2.y,v2.z, "[~r~E~w~] for at tage bussen")
		end
		while GetDistanceBetweenCoords(-217.71, 6175.97, 31.21, GetEntityCoords(LocalPed())) < 12 do
			Citizen.Wait(1)
			Draw3DText(v3.x,v3.y,v3.z, "[~r~E~w~] for at tage bussen")
		end
end)

Citizen.CreateThread(function()
	
	for i=1, #Config.Map, 1 do
		
		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
		SetBlipSprite (blip, Config.Map[i].id)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, Config.Map[i].color)
		SetBlipScale (blip, Config.Map[i].scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)
		
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

			DrawMarker(25, 687.52, 239.89, 92.6, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.0001, 255, 255, 102, 165, 0, 0, 0,0) -- #v1
			DrawMarker(25, 1989.81, 3055.3, 46.22, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.0001, 255, 255, 102, 165, 0, 0, 0,0) -- #v2
			DrawMarker(25, -217.71, 6175.97, 30.21, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.0001, 255, 255, 102, 165, 0, 0, 0,0) -- #v3

			
			if GetDistanceBetweenCoords(687.52, 239.89, 93.6, GetEntityCoords(LocalPed())) < 0.8 or GetDistanceBetweenCoords(1989.81, 3055.3, 47.22, GetEntityCoords(LocalPed())) < 0.8 or GetDistanceBetweenCoords(-217.71, 6175.97, 31.21, GetEntityCoords(LocalPed())) < 0.8 then
				SetTextComponentFormat('STRING');
				AddTextComponentString("Brug ~ INPUT_CONTEXT ~ for at se de aktuelle priser");
				DisplayHelpTextFromStringLabel(0, 0, 1, -1);
				if IsControlJustReleased(0, Keys['E']) then
						ESX.ShowNotification("~y~Du kigger på listen.")
							TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
							FreezeEntityPosition(GetPlayerPed(-1), true)
							Wait(1500)
							OpenMenu()
						end
				elseif not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'mar_bus_menu') then
						
						if GetDistanceBetweenCoords(687.52, 3055.3, 93.6, GetEntityCoords(LocalPed())) < 12 then
							Draw3DText(v1.x,v1.y,v1.z, "[~r~E~w~] For at tage bussen")
						end
						if GetDistanceBetweenCoords(1989.81, 3055.3, 47.22, GetEntityCoords(LocalPed())) < 12 then
							Draw3DText(v2.x,v2.y,v2.z, "[~r~E~w~] For at tage bussen")
						end
						if GetDistanceBetweenCoords(-217.71, 6175.97, 31.21, GetEntityCoords(LocalPed())) < 12 then
							Draw3DText(v3.x,v3.y,v3.z, "[~r~E~w~] For at tage bussen")
						end
				end
			end
		end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if IsControlJustReleased(0, 202) and ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'mar_bus_menu') then
				FreezeEntityPosition(ped, false)
				ESX.UI.Menu.CloseAll()
			end
	end
end)

RegisterNetEvent('v1')
AddEventHandler('v1',function() 
	TriggerServerEvent("mar_bus:pay")
	FreezeEntityPosition(ped, false)
	ClearPedTasks(ped)
	SetNewWaypoint(687.52, 239.89)	
	ESX.ShowNotification("~p~Bussen kommer om et øjeblik...")
	ESX.UI.Menu.CloseAll()
	Citizen.Wait(7500)
	DoScreenFadeOut(100)
	Citizen.Wait(7500)
	TeleportPrzystanek()
	DoScreenFadeIn(100)

	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('v2')
AddEventHandler('v2',function() 
	TriggerServerEvent("mar_bus:pay")
	FreezeEntityPosition(ped, false)
	ClearPedTasks(ped)
	SetNewWaypoint(1989.81, 3055.3)
	ESX.ShowNotification("~p~Bussen kommer om et øjeblik...")
	ESX.UI.Menu.CloseAll()
	Citizen.Wait(7500)
	DoScreenFadeOut(100)
	Citizen.Wait(9000)
	TeleportPrzystanek()
	DoScreenFadeIn(100)

	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('v3')
AddEventHandler('v3',function() 
	TriggerServerEvent("mar_bus:pay")
	FreezeEntityPosition(ped, false)
	ClearPedTasks(ped)
	SetNewWaypoint(-217.71, 6175.97)
	ESX.ShowNotification("~p~Bussen kommer om et øjeblik...")
	ESX.UI.Menu.CloseAll()
	Citizen.Wait(7500)
	DoScreenFadeOut(100)
	Citizen.Wait(13000)
	TeleportPrzystanek()
	DoScreenFadeIn(100)

	ESX.UI.Menu.CloseAll()
end)

function OpenMenu(target)

	local elements = {}

	table.insert(elements, {label = ('Centrum'), value = 'v1'})
	table.insert(elements, {label = ('Sandy Shores'), value = 'v2'})
	table.insert(elements, {label = ("Paleto Bay"), value = 'v3'})
  		ESX.UI.Menu.CloseAll()	

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mar_bus_menu',
		{
			title    = ('Bus station'),
			align    = 'center',
			elements = elements
		},
		
    function(data, menu)
		
		if data.current.value == 'v1' then
		TriggerEvent('v1')
		elseif data.current.value == 'v2' then
		TriggerEvent('v2')
		elseif data.current.value == 'v3' then
		TriggerEvent('v3')	
		end
	end)
end


TeleportPrzystanek = function()

            local WaypointHandle = GetFirstBlipInfoId(8)

            if DoesBlipExist(WaypointHandle) then
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        break
                    end

                    Citizen.Wait(5)
                end
                ESX.ShowNotification("~b~Du betalte for turen.")
            end
end

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function LocalPed()
	return ped
end