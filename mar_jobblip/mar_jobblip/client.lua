PlayerData = {}

local done = false

ESX = nil
 Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    done = true
end)
--==============ESX^^^^^^IKKE PIL HER OVER!!!================---

-- Id og farve --
-- https://docs.fivem.net/docs/game-references/blips/ --

--  unemployedblips --

local unemployedblips = { 
	 {title="Det hemmelige skjulested", colour=?, id=?, x = ?, y= ?, z= ?}, 
}

--[[
exempel på flere

-- taxiblips --
local taxiblips = { 
	 {title="Mit Depot", colour=38, id=438, x = ?, y= ?, z= ?}, 
}

-- taxiblips --
 Citizen.CreateThread(function() 
    while not done do
        Citizen.Wait(10)
    end
    if PlayerData.job.name == 'taxi' then 
        for _, info in pairs(taxiblips) do 
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, false)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
      done = true
    end
end
end)

--]]

-- unemployedblips --
 Citizen.CreateThread(function() 
    while not done do
        Citizen.Wait(10)
    end
    if PlayerData.job.name == 'unemployed' then 
        for _, info in pairs(unemployedblips) do 
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, false)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
      done = true
    end
end
end)
