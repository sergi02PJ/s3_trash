Config = {}

-- Seconds of cooldown
Config.cooldown = 120

-- Percentage is required. Numbers between 0-100, if number is greater than 100 it wont work.
Config.probabilityToBeEmpty = 30 

-- ¿Do you want to include throwed items by players in ObjectsInTrash with <count>% prob each one?
Config.includeThrowedItms = true

-- ¿Do you want to include throwed items by players in ObjectsInTrash with <count>% prob each one?
Config.menusAlign = 'center'

Config.translations = {
    invalidAmount = 'Cantidad Inválida.',
    cooldownMsg = 'No puedes realiza esta acción ahora espera: ',
    searchingItems = 'Buscando objetos en la papelera...',
    emptyBin = 'Esta papelera se encuentra vacía.',
    itemFound = 'Has encontrado en la papelera un ',
    binMenuTitle = 'Papelera',
    throwMenuTitle = 'Tirar Objetos',
    dialogMenuTitle = 'Cantidad a tirar',
    binMenuThrow = 'Tirar Objetos',
    binMenuSearch = 'Buscar Objetos',
    text3D = '~g~[E] ~w~Papelera',
}

-- {item, probability of object to spawn}
Config.ObjectsInTrash = {
    {"agua", 20},
    {"alcotester", 12},
    {"bread", 30},
    {"coke", 3},
    {"beer", 15},
    {"phone", 10},
    {"radio", 10},
}

-- Bin Props -> https://gta-objects.xyz/objects
Config.Bins = {
    "hei_heist_kit_bin_01",
    "prop_bin_01a",
    "prop_bin_02a",
    "prop_bin_03a",
    "prop_bin_04a",
    "prop_bin_05a",
    "prop_bin_06a",
    "prop_bin_07a",
    "prop_bin_07b",
    "prop_bin_07c",
    "prop_bin_07d",
    "prop_bin_08a",
    "prop_bin_08open",
    "prop_bin_10a",
    "prop_bin_10b",
    "prop_bin_11a",
    "prop_bin_11b",
    "prop_bin_12a",
    "prop_bin_14a",
    "prop_bin_14b",
    "prop_bin_beach_01a",
    "prop_bin_beach_01d",
    "prop_bin_delpiero",
    "prop_bin_delpiero_b",
    "prop_cs_bin_01",
    "prop_cs_bin_01_skinned",
    "prop_cs_bin_02",
    "prop_cs_bin_03",
    "prop_gas_smallbin01",
    "zprop_bin_01a_old",
    "prop_recyclebin_01a",
    "prop_recyclebin_02a",
    "prop_recyclebin_02b",
    "prop_recyclebin_02_c",
    "prop_recyclebin_02_d",
}