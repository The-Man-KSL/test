Config = {}

Config.DrugSystem = { 
    Configure = {
        ESX = {
            Export = 'crm-core',
            Notifications = 'esx:showNotification'
        },
        InvalidDrugs = {
            ConsoleLog = true,
            ConsoleMessage = 'The Player ^2%s^7 [Identifier: ^4%s^7] attempted to spawn the drug ^3%s^7 [Drug isn\'t in the Database]',
            NotifyMessage = 'The Drug %s isn\'t in the Database!\nPlease contact the Owner/Developer',
            Punishment = 'kick' -- ['none', 'notifyPlayer', 'kick']
        }
    },
    Drugs = {  
        ['Weed'] = {
            Collecting = {
                Give = {item = 'weed', amount = 2, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Collect Weed', full = 'You\'re full on Weed', progress = 'Collecting...', tooFar = 'You ran from the Collection Area!'},
                Location = vector3(1057.448, -3197.646, -39.138),
                Blip = {show = true, label = 'Weed Farm', id = 140, scale = 0.7, color = 2, location = vector3(-257.1, -1545.71, 31.67)}
            },
            Processing = {
                Require = {item = 'weed', amount = 10},
                Give = {item = 'weed_pooch', amount = 1, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Process Weed', notEnough = 'You don\'t have enough Weed to Process', progress = 'Processing...', full = 'You\'re full on Weed Pouch', tooFar = 'You ran from the Process Area!'},
                Location = vector3(1037.527, -3205.368, -38.17),
                Blip = {show = false, label = 'Weed Processing', id = 0, scale = 0.0, color = 2, location = vector3(0.0, 0.0, 0.0)}
            },
            Selling = {
                Require = {item = 'weed_pooch', amount = 1},
                Give = {money = 'black_money', amount = 25000, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Sell Weed', notEnough = 'You don\'t have enough Weed to Sell', progress = 'Selling...', done = 'You Sold x1 Weed Pouch!', tooFar = 'You ran from the Sell Area!'},
                Location = vector3(-1173.45,-1572.68, 4.52),
                Blip = {show = true, label = 'Weed Sales', id = 140, scale = 0.7, color = 2, location = vector3(-1173.83, -1573.53, 4.37)}
            }
        },
        ['Coke'] = {
            Collecting = {
                Give = {item = 'coke', amount = 2, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Collect Coke', full = 'You\'re full on Coke', progress = 'Collecting...', tooFar = 'You ran from the Collection Area!'},
                Location = vector3(4985.2842, -5129.7129, -4.4736),
                Blip = {show = true, label = 'Coke Farm', id = 403, scale = 0.7, color = 3, location = vector3(4982.3037, -5116.5146, 2.6190)}
            },
            Processing = {
                Require = {item = 'coke', amount = 10},
                Give = {item = 'coke_pouch', amount = 1, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Process Coke', notEnough = 'You don\'t have enough Coke to Process', progress = 'Processing...', full = 'You\'re full on Coke Pooch', tooFar = 'You ran from the Process Area!'},
                Location = vector3(4991.9673, -5139.3779, -4.4736),
                Blip = {show = false, label = 'Coke Processing', id = 0, scale = 0.0, color = 0, location = vector3(0.0, 0.0, 0.0)}
            },
            Selling = {
                Require = {item = 'coke_pouch', amount = 1},
                Give = {money = 'black_money', amount = 41000, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Sell Coke', notEnough = 'You don\'t have enough Coke to Sell', progress = 'Selling...', done = 'You Sold x1 Coke Pooch!', tooFar = 'You ran from the Sell Area!'},
                Location = vector3(4862.5063, -4627.4697, 14.7768),
                Blip = {show = false, label = 'Coke Sales', id = 403, scale = 0.7, color = 3, location = vector3(-77.44, -1515.36, 34.25)}
            }
        },
        ['Meth'] = {
            Collecting = {
                Give = {item = 'meth', amount = 2, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Collect Meth', full = 'You\'re full on Meth', progress = 'Collecting...', tooFar = 'You ran from the Collection Area!'},
                Location = vector3(5132.0112, -4613.3569, -4.6656),
                Blip = {show = true, label = 'Meth Farm', id = 365, scale = 0.7, color = 3, location = vector3(5145.5566, -4615.0010, 2.4414)}
            },
            Processing = {
                Require = {item = 'meth', amount = 10},
                Give = {item = 'meth_pouch', amount = 1, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Process Meth', notEnough = 'You don\'t have enough Meth to Process', progress = 'Processing...', full = 'You\'re full on Meth Pooch', tooFar = 'You ran from the Process Area!'},
                Location = vector3(5122.1362, -4617.6470, -4.6656),
                Blip = {show = false, label = 'Meth Processing', id = 0, scale = 0.0, color = 0, location = vector3(0.0, 0.0, 0.0)}
            },
            Selling = {
                Require = {item = 'meth_pouch', amount = 1},
                Give = {money = 'black_money', amount = 37000, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Sell Meth', notEnough = 'You don\'t have enough Meth to Sell', progress = 'Selling...', done = 'You Sold x1 Meth Pooch!', tooFar = 'You ran from the Sell Area!'},
                Location = vector3(4987.3730, -5712.0347, 19.8838),
                Blip = {show = false, label = 'Meth Sales', id = 365, scale = 0.7, color = 3, location = vector3(4987.3730, -5712.0347, 19.8838)}
            }
        },
        ['Ecstasy'] = {
            Collecting = {
                Give = {item = 'ecstasy', amount = 2, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Collect Ecstasy', full = 'You\'re full on Ecstasy', progress = 'Collecting...', tooFar = 'You ran from the Collection Area!'},
                Location = vector3(1389.2563, 3605.1145, 38.9419),
                Blip = {show = true, label = 'Ecstasy Farm', id = 403, scale = 0.7, color = 0, location = vector3(1389.2563, 3605.1145, 38.9419)}
            },
            Processing = {
                Require = {item = 'ecstasy', amount = 10},
                Give = {item = 'ecstasy_pooch', amount = 1, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Process Ecstasy', notEnough = 'You don\'t have enough Ecstasy to Process', progress = 'Processing...', full = 'You\'re full on Xanax Pooch', tooFar = 'You ran from the Process Area!'},
                Location = vector3(1394.5988, 3601.8347, 38.9419),
                Blip = {show = false, label = 'Ecstasy Processing', id = 0, scale = 0.0, color = 0, location = vector3(0.0, 0.0, 0.0)}
            },
            Selling = {
                Require = {item = 'bottle_xanax', amount = 1},
                Give = {money = 'black_money', amount = 65000, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Sell Xanax', notEnough = 'You don\'t have enough Xanax to Sell', progress = 'Selling...', done = 'You Sold x1 Xanax Pooch!', tooFar = 'You ran from the Sell Area!'},
                Location = vector3(-1821.54,-404.65, -46.65),
                Blip = {show = false, label = 'Xanax Sales', id = 123, scale = 0.7, color = 0, location = vector3(-1821.54, -404.65, 46.65)}
            }
        },
        ['Percs'] = {
            Collecting = {
                Give = {item = 'perc', amount = 2, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Collect Perc', full = 'You\'re full on Perc', progress = 'Collecting...', tooFar = 'You ran from the Collection Area!'},
                Location = vector3(2430.6973, 4967.1050, 42.3476),
                Blip = {show = true, label = 'Perc Farm', id = 403, scale = 0.7, color = 53, location = vector3(2430.6973, 4967.1050, 42.3476)}
            },
            Processing = {
                Require = {item = 'perc', amount = 10},
                Give = {item = 'perc_pooch', amount = 1, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Process Perc', notEnough = 'You don\'t have enough Perc to Process', progress = 'Processing...', full = 'You\'re full on Perc Pooch', tooFar = 'You ran from the Process Area!'},
                Location = vector3(2435.8767, 4965.4458, 42.3476),
                Blip = {show = true, label = 'Perc Processing', id = 403, scale = 0.7, color = 53, location = vector3(2435.8767, 4965.4458, 42.3476)}
            },
            Selling = {
                Require = {item = 'perc_pooch', amount = 1},
                Give = {money = 'black_money', amount = 90000, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Sell Perc', notEnough = 'You don\'t have enough Perc to Sell', progress = 'Selling...', soldDrug = 'You Sold x1 Perc Pooch!', tooFar = 'You ran from the Sell Area!'},
                Location = vector3(-154.2658, 6140.8125, 32.3351),
                Blip = {show = true, label = 'Perc Sales', id = 403, scale = 0.7, color = 53, location = vector3(-154.2658, 6140.8125, 32.3351)}
            }
        },
        ['Lean'] = {
            Collecting = {
                Give = {item = 'lean', amount = 2, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Collect Lean', full = 'You\'re full on Lean', progress = 'Collecting...', tooFar = 'You ran from the Collection Area!'},
                Location = vector3(244.5718, 374.1433, 105.7381),
                Blip = {show = false, label = 'Lean Farm', id = 403, scale = 0.7, color = 27, location = vector3(244.39, 373.92, 105.72)}
            },
            Processing = {
                Require = {item = 'lean', amount = 10},
                Give = {item = 'lean_bottle', amount = 1, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Process Lean', notEnough = 'You don\'t have enough Lean to Process', progress = 'Processing...', full = 'You\'re full on Lean Pooch', tooFar = 'You ran from the Process Area!'},
                Location = vector3(252.3821, 374.2811, 105.6121),
                Blip = {show = false, label = 'Lean Processing', id = 0, scale = 0.0, color = 0, location = vector3(0.0, 0.0, 0.0)}
            },
            Selling = {
                Require = {item = 'lean_bottle', amount = 1},
                Give = {money = 'black_money', amount = 60000, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Sell Lean', notEnough = 'You don\'t have enough Lean to Sell', progress = 'Selling...', done = 'You Sold x1 Lean Pooch!', tooFar = 'You ran from the Sell Area!'},
                Location = vector3(-715.7542, 303.8292, 85.3048),
                Blip = {show = false, label = 'Lean Sales', id = 403, scale = 0.7, color = 27, location = vector3(-731.09, 320.52, 86.78)}
            }
        },
        ['Acid'] = {
            Collecting = {
                Give = {item = 'acid', amount = 2, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Collect Opium', full = 'You\'re full on Opium', progress = 'Collecting...', tooFar = 'You ran from the Collection Area!'},
                Location = vector3(-225.57,-2655.15, 6.0),
                Blip = {show = true, label = 'Opium Farm', id = 403, scale = 0.7, color = 1, location = vector3(-225.57,-2655.15, 6.0)}
            },
            Processing = {
                Require = {item = 'acid', amount = 10},
                Give = {item = 'acid_pooch', amount = 1, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Process Opium', notEnough = 'You don\'t have enough Opium to Process', progress = 'Processing...', full = 'You\'re full on Acid Pooch', tooFar = 'You ran from the Process Area!'},
                Location = vector3(-234.45, -2652.32, 6.0),
                Blip = {show = false, label = 'Opium Processing', id = 0, scale = 0.0, color = 0, location = vector3(0.0, 0.0, 0.0)}
            },
            Selling = {
                Require = {item = 'acid_pooch', amount = 1},
                Give = {money = 'black_money', amount = 72000, time = 3},
                Marker = {id = 2, size = {x = 0.75, y = 0.75, z = 0.75}, color = {r = 255, g = 255, b = 255, a = 200}, interactDistance = 2, seeDistance = 25, interactButton = 38},
                Notify = {interact = 'Press ~input_context~ To Sell Opium', notEnough = 'You don\'t have enough Opium to Sell', progress = 'Selling...', done = 'You Sold x1 Acid Pooch!', tooFar = 'You ran from the Sell Area!'},
                Location = vector3(343.69, -2028.61, 22.35),
                Blip = {show = true, label = 'Opium Sales', id = 403, scale = 0.7, color = 1, location = vector3(343.69, -2028.61, 22.35)}
            }
        }
    }
}