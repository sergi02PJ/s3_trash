ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local latestSearch = 0
local inAction = false

Citizen.CreateThread(function()
    while true do 
        s = 2000
        local playerPed = PlayerPedId()

        if not IsPedInAnyVehicle(playerPed, true) and not inAction then	
            local object, distance = ESX.Game.GetClosestObject()
            for k, v in pairs(Config.Bins) do
                if GetEntityModel(object) == GetHashKey(v) and distance < 1.5 then
                    s = 0
                    local coords = GetEntityCoords(playerPed)
                    local binCoords = GetEntityCoords(object)
                    DrawText3D(binCoords.x, binCoords.y, binCoords.z+1.5, Config.translations.text3D , 0, 0.1, 0.1,255)
                    if IsControlJustReleased(0, 38) then
                        openBin()
                    end
                end
            end  
        end
        Citizen.Wait(s)
    end
end)


openBin = function()
    local elements = {
        {label = Config.translations.binMenuSearch, value = "search"},
		{label = Config.translations.binMenuThrow , value = "throw"}
    }

    ESX.UI.Menu.CloseAll()
    inAction = true
    openMenu(Config.translations.binMenuTitle, elements)
end

searchTrash = function()
    ESX.TriggerServerCallback('s3_trash:getServerTime', function(time)
        local rest = (time - latestSearch)
        if rest > Config.cooldown then
            ESX.ShowNotification(Config.translations.searchingItems)
            playAnim("anim@move_m@trash", "pickup")
            TriggerServerEvent('s3_trash:searchItem')
            latestSearch = time
        else
            ESX.ShowNotification(Config.translations.cooldownMsg..' ('..Config.cooldown-rest.."s)")
        end
        inAction = false
    end)
end

throwObjects = function()
    ESX.TriggerServerCallback('s3_trash:getPlayerInventory', function(inv)
        local elements = {}

        for i=1, #inv, 1 do
			if inv[i].count > 0 then
				table.insert(elements, {
					label    = inv[i].label.." x"..inv[i].count,
					value    = inv[i].name,
					amount   = inv[i].count
				})
			end
		end

        openMenu(Config.translations.throwMenuTitle, elements)
    end)
end

-- GENERAL FUNTIONS

openMenu = function(title, elements)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inv', {
        title    = title,
        align    = Config.menusAlign,
        elements = elements
    }, function(data, menu)
        if data.current.value == "search" then
            searchTrash()
			ESX.UI.Menu.CloseAll()
		elseif data.current.value == "throw" then
            throwObjects()
			ESX.UI.Menu.CloseAll()
        else
            menu.close()
            openDialog(Config.translations.dialogMenuTitle, data.current)
        end
    end, function(data, menu)
        menu.close()
        inAction = false
    end)
end

openDialog = function(title, menuData)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
        title = title
    }, function(data, menu)
        local count = tonumber(data.value)

        if count ~= nil then
            if count <= menuData.amount then
                menu.close()
                TriggerServerEvent('s3_trash:throwObjects', menuData.value, count)

                Citizen.Wait(300)
                throwObjects()
            else
                ESX.ShowNotification(Config.translations.invalidAmount)
            end
        end
    end, function(data, menu)
        menu.close()
    end)
end

playAnim = function(lib, anim)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    Citizen.CreateThread(function()
        RequestAnimDict(lib)
        while not HasAnimDictLoaded( lib) do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false )
    end)
    Citizen.Wait(3000)
    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped)
end

DrawText3D = function(x, y, z, text)
    local onScreen,x,y = World3dToScreen2d(x, y, z)
    local factor = #text / 370

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x,y)
        DrawRect(x,y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
    end
end
