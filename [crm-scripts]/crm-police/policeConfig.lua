Config = {
    ESX = 'crm-core',
    Menu = {
        Command = 'pd',
        Bind = 'F6'
    },
    Duty = {
        Position = vector3(441.2125, -981.8501, 30.6895)
    },
    Armoury = {
        Position = vector3(479.1857, -996.7239, 13.2648),
        Weapons = {
            {Label = 'Combat Pistol', Value = 'WEAPON_COMBATPISTOL', Price = 1},
            {Label = 'AP Pistol', Value = 'WEAPON_APPISTOL', Price = 1},
        },
    },
    Garage = {
        Position = vector3(454.9505, -1017.0402, 28.4283),
        Vehicles = {
            {Label = 'Police Bike', Model = 'manchez', Rank = 0},
            {Label = 'Police Car', Model = 'police2', Rank = 0},
            {Label = 'Valor', Model = 'valor1rb', Rank = 0},
            {Label = 'Police 5RB', Model = 'valor5rb', Rank = 0},
            {Label = 'Police 4RB', Model = 'Valor4rb', Rank = 0},
            {Label = 'Police Explorer', Model = 'valor11rb', Rank = 0},
            {Label = 'Police Dodge Smart', Model = 'valor2rb', Rank = 0},
            {Label = 'Police Smart Explorer', Model = 'valor7rb', Rank = 0},
            {Label = 'Police Explorer 12RB', Model = 'valor12rb', Rank = 0},
            {Label = 'Police Ranger', Model = 'valor15rb', Rank = 0},
            {Label = 'Police Dodge Cruiser', Model = 'valor3rb', Rank = 0},
            {Label = 'Police Bulk', Model = 'valor14rb', Rank = 0},
            {Label = 'Police Default', Model = 'valor6rb', Rank = 0},
            {Label = 'Police Family', Model = 'valor13rb', Rank = 0},
            {Label = 'Police Family 2', Model = 'valor10rb', Rank = 0},
            {Label = 'Police Family 3', Model = 'valor9rb', Rank = 0}
        },
        Spawn = vector3(444.9824, -1020.3774, 28.5554), 
        Give = false,
        GeneratePlate = 'esx_vehicleshop'
    },
    BlackListedItems = {
        'common_key',
    }
}