ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local possibleObjectsInTrash = {}
local objectsSize = 0

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    loadTrashObjects()
    print('^2Script by s3Development: ' .. resourceName .. ' has been loaded successfully.')
end)

RegisterServerEvent('s3_trash:searchItem')
AddEventHandler('s3_trash:searchItem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local isEmpty = math.random(0, 100)

    if isEmpty <= Config.probabilityToBeEmpty then
        xPlayer.showNotification(Config.translations.emptyBin)
    else
        local selectedObject = possibleObjectsInTrash[math.random(1, objectsSize)]

        xPlayer.addInventoryItem(selectedObject, 1)
        xPlayer.showNotification(Config.translations.itemFound..selectedObject)
    end
end)

RegisterServerEvent('s3_trash:throwObjects')
AddEventHandler('s3_trash:throwObjects', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.includeThrowedItms then
        for i=1, count, 1 do
            table.insert(possibleObjectsInTrash, item)
        end
    end

    xPlayer.removeInventoryItem(item, count)
end)

ESX.RegisterServerCallback('s3_trash:getServerTime', function(source, cb)
    cb(os.time())
end)

ESX.RegisterServerCallback('s3_trash:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.inventory)
end)

loadTrashObjects = function()
    for k, v in pairs(Config.ObjectsInTrash) do
        objectsSize = objectsSize + v[2]
        for i=1, v[2], 1 do
            table.insert(possibleObjectsInTrash, v[1])
        end
    end
end
