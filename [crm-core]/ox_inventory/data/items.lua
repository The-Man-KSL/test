return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			}
		}
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 1,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
		description = "Used to buy illegal goods such as Heist items, Black Market items and more.",
	},

	['burger'] = {
		label = 'Cheese Burger',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['cola'] = {
		label = 'Coca-Cola',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with cola'
		}
	},
	['yoohoo'] = {
		label = 'Yoohoo',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with A Yoohoo'
		}
	},
	['snickers'] = {
		label = 'Snickers Bar',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_choc_meto`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Hungar with A Snickers Bar'
		}
	},
	['skittles'] = {
		label = 'Skittles',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_choc_meto`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Hungar with Skittles'
		}
	},
	['popcorn'] = {
		label = 'Popcorn',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_cb_bag_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You ate popcorn, make sure you share'
		}
	},
	--FOODPROPS FOLDER ITEMS
	['twix'] = {
		label = 'Twix',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_foodpack_twix001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You ate a twix bar'
		}
	},
	['snickers'] = {
		label = 'Snickers',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_foodpack_snickers001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You ate a Snickers bar'
		}
	},
	['milkyway'] = {
		label = 'Milky Way',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_foodpack_milkyway001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You ate a Milky Way bar'
		}
	},
	['mars'] = {
		label = 'Mars',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_foodpack_mars001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You ate a Mars bar'
		}
	},
	['bounty'] = {
		label = 'Bounty',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_foodpack_bounty001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You ate a Bounty bar'
		}
	},
	['chocolatedonut'] = {
		label = 'Chocolate donut',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_foodpack_donut002`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You ate a Chocolate donut'
		}
	},
	['strawberrydonut'] = {
		label = 'Strawberry donut',
		weight = 1,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_foodpack_donut001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You ate a Strawberry donut'
		}
	},
	['sprite'] = {
		label = 'Sprite',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_drinkpack_sprite001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drank Sprite'
		}
	},
	['pepsi'] = {
		label = 'Pepsi',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_drinkpack_pepsi001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drank Pepsi'
		}
	},
	['pepsimax'] = {
		label = 'Pepsi Max',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_drinkpack_pepsimax001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drank Pepsi Max'
		}
	},
	['mountaindew'] = {
		label = 'Mountain Dew',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_drinkpack_mtndew001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drank Mountain Dew'
		}
	},
	['fanta'] = {
		label = 'Fanta',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_drinkpack_fanta001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drank Fanta'
		}
	},
	['drpepper'] = {
		label = 'Dr. Pepper',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_drinkpack_drpepper001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drank Dr. Pepper'
		}
	},
	['cocacola'] = {
		label = 'Coca Cola',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_drinkpack_cocacola001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drank Coca Cola'
		}
	},
	['cocacolazero'] = {
		label = 'Coca Cola Zero',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_drinkpack_colazero001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drank Coca Cola Zero'
		}
	},
	['7up'] = {
		label = '7Up',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `bzzz_drinkpack_7up001`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drank 7Up'
		}
	},
	--END OF FOOD FOLDER
	['arizonh'] = {
		label = 'Arizona Tea With Genseng',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with Arizona Tea'
		}
	},
	['arizons'] = { 
		label = 'Arizona Southern Sweet Tea',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with Arizona Tea'
		}
	},
	['arizonp'] = {
		label = 'Arizona Peach Tea',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with Arizona Tea'
		}
	},
	['arizonw'] = {
		label = 'Arizona Watermelon Tea',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with Arizona Tea'
		}
	},
	['sprite'] = {
		label = 'Sprite',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with Sprite'
		}
	},
	['pepsi'] = {
		label = 'Pepsi',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with Pepsi'
		}
	},
	['lemonade'] = {
		label = 'Minute maid Lemonade',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with Lemonade'
		}
	},
	['crushp'] = {
		label = 'Crush Peach',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with Crush'
		}
	},
	['redhuggie'] = {
		label = 'Red Huggie',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with A Huggie'
		}
	},
	--starbucks
	['coffee'] = {
		label = 'Coffee',
		weight = 1,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `p_amb_coffeecup_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your Thirst with A Coffee'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 1,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['backpack'] = {
		label = 'Backpack',
		weight = 15,
		stack = false,
		consume = 0,
		client = {
			export = 'crm-backpack.openBackpack'
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['wood'] = {
		label = 'Wood',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	
	
	['metal'] = {
		label = 'Metal',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	
	['rope'] = {
		label = 'Rope',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['container'] = {
		label = 'Container',
		weight = 25,
		stack = true,
		close = true
	},

	['handcuffs'] = {
		label = 'Handcuffs',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['movieticket'] = {
		label = 'Movie Ticket',
		weight = 1,
		stack = false,
		close = true,
		description = "Go watch a movie with this ticket at the local Los Santos Movie Theater"
	},
	
	['shovel'] = {
		label = 'Shovel',
		weight = 1,
		stack = true,
		close = true,
		description = "Might be able to escape with this.",
	},

	['casinopass'] = {
		label = 'Casino Membership',
		weight = 0,
		stack = false,
		close = true,
		description = "Access to other floors of the Casino",
		consume = 0
	},

	['casinoentry'] = {
		label = 'Casino Entry',
		weight = 0,
		stack = false,
		close = true,
		description = "Casino entry access.",
		consume = 0
	},

	['planeticket_ssa'] = {
		label = 'Miami Ticket',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['planeticket_lsia'] = {
		label = 'New York Ticket',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},
	--HEIST ITEMS

	['gasmask'] = {
		label = 'Gas Mask',
		weight = 1,
		stack = false,
		close = false,
		description = "Used in the Vangelico Heist",
		consume = 0
	},

	['cutter'] = {
		label = 'Cutter',
		weight = 1,
		stack = false,
		close = false,
		description = "Used in a various amount of Heists",
		consume = 0
	},

	['bag'] = {
		label = 'Heist Bag',
		weight = 1,
		stack = false,
		close = false,
		description = "Used in a various amount of Heists",
		consume = 0
	},

	['drill'] = {
		label = 'Drill',
		weight = 1,
		stack = false,
		close = false,
		description = "Used in a various amount of Heists",
		consume = 0
	},

	['casinochips'] = {
		label = 'Casino Chips',
		weight = 1,
		stack = true,
		close = true,
		description = "Don't gamble too much!",
		consume = 0
	},

	['c4_bomb'] = {
		label = 'C4 Bomb',
		weight = 1,
		stack = false,
		close = false,
		description = "Used in a various amount of Heists",
		consume = 0
	},

	['thermite_bomb'] = {
		label = 'Thermite',
		weight = 1,
		stack = false,
		close = false,
		description = "Used in Pacific Bank Heist",
		consume = 0
	},

	['laptop'] = {
		label = 'Laptop',
		weight = 1,
		stack = false,
		close = false,
		description = "Used in Pacific Bank Heist",
		consume = 0
	},

	['hack_usb'] = {
		label = 'USB',
		weight = 1,
		stack = false,
		close = false,
		description = "Used in Pacific Bank Heist",
		consume = 0
	},
	--HEIST REWARDS

	['rolex'] = {
		label = 'Rolex',
		weight = 1,
		stack = false,
		close = false,
		description = "Sell this at a Heist Buyer for a great reward",
		consume = 0
	},

	['ring'] = {
		label = 'Ring',
		weight = 1,
		stack = false,
		close = false,
		description = "Sell this at a Heist Buyer for a great reward",
		consume = 0
	},

	['necklace'] = {
		label = 'Necklace',
		weight = 1,
		stack = false,
		close = false,
		description = "Sell this at a Heist Buyer for a great reward",
		consume = 0
	},

	['vanDiamond'] = {
		label = 'Diamond',
		weight = 1,
		stack = false,
		close = false,
		description = "Sell this at a Heist Buyer for a great reward",
		consume = 0
	},

	['vanPanther'] = {
		label = 'Panther',
		weight = 1,
		stack = false,
		close = false,
		description = "Sell this at a Heist Buyer for a great reward",
		consume = 0
	},

	['vanNecklace'] = {
		label = 'Necklace',
		weight = 1,
		stack = false,
		close = false,
		description = "Sell this at a Heist Buyer for a great reward",
		consume = 0
	},

	['vanBottle'] = {
		label = 'Bottle',
		weight = 1,
		stack = false,
		close = false,
		description = "Sell this at a Heist Buyer for a great reward",
		consume = 0
	},

	['gold'] = {
		label = 'Gold',
		weight = 1,
		stack = false,
		close = false,
		description = "Sell this at a Heist Buyer for an amazing reward",
		consume = 0
	},

	['racing'] = {
		label = 'Racing Tablet',
		weight = 1,
		stack = false,
		close = true,
		consume = 0
	},


	['identification'] = {
		label = 'Identification',
	},

	['panties'] = {
		label = 'Knickers',
		weight = 1,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 1,
		consume = 0,
		description = "Lockpick a various amount of doors and even cells",
		client = {
			anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer' },
			disable = { move = true, car = true, combat = true },
			usetime = 5000,
			cancel = true
		}
	},

	['phone'] = {
		label = 'Phone',
		weight = 1,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money'] = {
		label = 'Money',
		description = "Basic Los Santos Currency",
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 1,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 1,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 1,
		stack = false,
		consume = 0,
		allowArmed = true
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 5,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
		}
	},

	['backwoods_grape'] = {
		label = 'backwoods grape',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['backwoods_honey'] = {
		label = 'backwoods honey',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['backwoods_russian_cream'] = {
		label = 'backwoods russian cream',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['blueberry_cruffin'] = {
		label = 'blueberry cruffin',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['blueberry_cruffin_joint'] = {
		label = 'blueberry cruffin joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['blue_phone'] = {
		label = 'blue phone',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['bread'] = {
		label = 'bread',
		weight = 0,
		stack = true,
		close = true,
		description = nil,
	},

	['cake_mix'] = {
		label = 'cake mix',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cake_mix_joint'] = {
		label = 'cake mix joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cannabis'] = {
		label = 'weed',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cereal_milk'] = {
		label = 'cereal milk',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cereal_milk_joint'] = {
		label = 'cereal milk joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cheap_lighter'] = {
		label = 'cheap lighter',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cheetah_piss'] = {
		label = 'cheetah piss',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cheetah_piss_joint'] = {
		label = 'cheetah piss joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cigarett'] = {
		label = 'cigarette',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['clip'] = {
		label = 'weapon clip',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['coke'] = {
		label = 'coke',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['coke_pooch'] = {
		label = 'coke pouch',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['diamond'] = {
		label = 'diamonds',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['ecstasy'] = {
		label = 'ecstasy',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['ecstasy_pooch'] = {
		label = 'ecstasy bag',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['bottle_xanax'] = {
		label = 'Bottled Xanax',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['perc_pooch'] = {
		label = 'Perc Pouch',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['perc'] = {
		label = 'Perc',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['flashlight'] = {
		label = 'flashlight',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['gary_payton'] = {
		label = 'gary payton',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['gary_payton_joint'] = {
		label = 'gary payton joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['gelatti'] = {
		label = 'gelatti',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['gelatti_joint'] = {
		label = 'gelatti joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['georgia_pie'] = {
		label = 'georgia pie',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['georgia_pie_joint'] = {
		label = 'georgia pie joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['gold'] = {
		label = 'gold',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['grabba_leaf'] = {
		label = 'grabba leaf',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['grabba_leaf_joint'] = {
		label = 'grabba leaf joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['green_phone'] = {
		label = 'green phone',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['grip'] = {
		label = 'grip',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['hamburger'] = {
		label = 'hamburger',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['heroin'] = {
		label = 'heroin',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['heroin_pooch'] = {
		label = 'bag of heroin',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['icetea'] = {
		label = 'ice-tea',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['jefe'] = {
		label = 'jefe',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['jefe_joint'] = {
		label = 'jefe joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['jewels'] = {
		label = 'jewels',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['lean'] = {
		label = 'lean',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['lighter'] = {
		label = 'lighter',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['medkit'] = {
		label = 'med kit',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['meth'] = {
		label = 'meth',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['meth_pouch'] = {
		label = 'meth pouch',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['opium'] = {
		label = 'opium',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['opium_pooch'] = {
		label = 'opium pouch',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['pooch_bag'] = {
		label = 'pooch bag',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['repairkit'] = {
		label = 'repairkit',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['rolex'] = {
		label = 'rolex',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['salvia'] = {
		label = 'salvia',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['salvia_pooch'] = {
		label = 'salvia bag',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['seed_weed'] = {
		label = 'weed seed',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['shoes'] = {
		label = 'shoes',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['snow_man'] = {
		label = 'snow man',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['snow_man_joint'] = {
		label = 'snow man joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['suppressor'] = {
		label = 'suppressor',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['tunerchip'] = {
		label = 'tuner chip',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['weapon_pistol'] = {
		label = 'pistol',
		weight = nil,
		stack = nil,
		close = nil,
		description = nil
	},

	['weapon_snspistol'] = {
		label = 'sns pistol',
		weight = nil,
		stack = nil,
		close = nil,
		description = nil
	},

	['weed_fertilizer'] = {
		label = 'weed fertilizer',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['weed_leaf'] = {
		label = 'weed leaf',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['weed_pooch'] = {
		label = 'bag of weed',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['weed_pot'] = {
		label = 'weed pot',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['weed_spray'] = {
		label = 'weed spray',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['whitecherry_gelato'] = {
		label = 'whitecherry gelato',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['whitecherry_gelato_joint'] = {
		label = 'whitecherry gelato joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['white_phone'] = {
		label = 'white phone',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['white_runtz'] = {
		label = 'white runtz',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['white_runtz_joint'] = {
		label = 'white runtz joint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['yusuf'] = {
		label = 'weapon skin',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['acid'] = {
		label = 'acid',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['acid_pouch'] = {
		label = 'acid pouch',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['bourbon'] = {
		label = 'bourbon',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cachaca'] = {
		label = 'cachaca',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['caipirinha'] = {
		label = 'caipirinha',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cd'] = {
		label = 'candy canes',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cd_pouch'] = {
		label = 'candy cane pouch',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['chemicals'] = {
		label = 'chemicals',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['club_soda'] = {
		label = 'club soda',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['coconut_milk'] = {
		label = 'coconut milk',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cointreau'] = {
		label = 'cointreau',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cokebrick'] = {
		label = 'coke brick',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['coke_pouch'] = {
		label = 'coke pooch',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['common_key'] = {
		label = 'common key',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cosmopolitan'] = {
		label = 'cosmopolitan',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['cranberry_juice'] = {
		label = 'cranberry juice',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['curacao'] = {
		label = 'orange curacao liqeur',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['dark_rum'] = {
		label = 'dark rum',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['dice'] = {
		label = 'dice',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['double_cup'] = {
		label = 'double cup',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['empty_cup'] = {
		label = 'lean cup',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['empty_lean_bottle'] = {
		label = 'empty lean bottle',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['fresh_mix'] = {
		label = 'fresh sour mix',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['gold_rum'] = {
		label = 'gold rum',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['heroin_shot'] = {
		label = 'heroin shot',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['ice'] = {
		label = 'ice',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['lean_bottle'] = {
		label = 'lean bottle',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['legendary_key'] = {
		label = 'legendary key',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['light_rum'] = {
		label = 'light rum',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['lime'] = {
		label = 'lime',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['limeade'] = {
		label = 'limeadge',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['mai_tai'] = {
		label = 'mai tai',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['margarita'] = {
		label = 'margarita',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['meth_raw'] = {
		label = 'meth raw',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['mint'] = {
		label = 'mint',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['mint_julep'] = {
		label = 'mint julep',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['mojito'] = {
		label = 'mojito',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['pina_colada'] = {
		label = 'pina colada',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['pineapple_juice'] = {
		label = 'pineapple juice',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['rare_key'] = {
		label = 'rare key',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['raw_lean'] = {
		label = 'lean ingredients',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['salvia_pouch'] = {
		label = 'salvia bottle',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['spice_leaf'] = {
		label = 'spice leaf',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['spice_pouch'] = {
		label = 'spice pooch',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['sugar'] = {
		label = 'sugar',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['syrup'] = {
		label = 'orgeat syrup',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['tequila'] = {
		label = 'tequila',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['triple_sec'] = {
		label = 'triple sec',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['vodka'] = {
		label = 'vodka',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['weed'] = {
		label = 'weed',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['weed_pouch'] = {
		label = 'weed pooch',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['white_rum'] = {
		label = 'white rum',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['xpills'] = {
		label = 'x-pills',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['acid'] = {
		label = 'acid',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['acid_pooch'] = {
		label = 'acid bag',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['crm_coke'] = {
		label = 'coke brick',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['crm_cokebag'] = {
		label = 'coke bag',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['crm_meth'] = {
		label = 'meth bag',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['crm_methchemicals'] = {
		label = 'meth chemicals',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['crm_weed'] = {
		label = 'weed',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['crm_weedbud'] = {
		label = 'weed bud',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['d'] = {
		label = 'cocaine',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['nitrous'] = {
		label = 'nitrous',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['crm_acid'] = {
		label = 'acid',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['crm_acidbag'] = {
		label = 'acid bag',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['meth_pooch'] = {
		label = 'meth pouch',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_acid'] = {
		label = 'acid',
		weight = 5,
		stack = true,
		close = true,
		description = nil
	},

	['hd_bcloth'] = {
		label = 'broken spoon with wet cloth',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_bladle'] = {
		label = 'broken ladle',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_booze'] = {
		label = 'booze',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_bottle'] = {
		label = 'bottle',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_cleaner'] = {
		label = 'cleaner',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_cloth'] = {
		label = 'cloth',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_dliquid'] = {
		label = 'dirty liquid',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_file'] = {
		label = 'file',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_fpacket'] = {
		label = 'flavor packet',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_grease'] = {
		label = 'grease',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_iheat'] = {
		label = 'immersion heater',
		weight = 5,
		stack = true,
		close = true,
		description = nil
	},

	['hd_jspoon'] = {
		label = 'broken spoon',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_ladle'] = {
		label = 'ladle',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_metal'] = {
		label = 'metal',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_minih'] = {
		label = 'mini hammer',
		weight = 5,
		stack = true,
		close = true,
		description = nil
	},

	['hd_plug'] = {
		label = 'plug',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_ppunch'] = {
		label = 'prison punch',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_rock'] = {
		label = 'rock',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_schange'] = {
		label = 'spare change',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_shank'] = {
		label = 'shank',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_smetal'] = {
		label = 'sharp metal',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_spoon'] = {
		label = 'spoon',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hd_wcloth'] = {
		label = 'wet cloth',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['black_phone'] = {
		label = 'black phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['classic_phone'] = {
		label = 'classic phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['gold_phone'] = {
		label = 'gold phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['greenlight_phone'] = {
		label = 'green light phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['phone_hack'] = {
		label = 'phone hack',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['phone_module'] = {
		label = 'phone module',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['pink_phone'] = {
		label = 'pink phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['purple_phone'] = {
		label = 'purple phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['red_phone'] = {
		label = 'red phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_black_phone'] = {
		label = 'wet black phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_blue_phone'] = {
		label = 'wet blue phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_classic_phone'] = {
		label = 'wet classic phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_gold_phone'] = {
		label = 'wet gold phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_greenlight_phone'] = {
		label = 'wet green light phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_green_phone'] = {
		label = 'wet green phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_pink_phone'] = {
		label = 'wet pink phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_purple_phone'] = {
		label = 'wet purple phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_red_phone'] = {
		label = 'wet red phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},

	['wet_white_phone'] = {
		label = 'wet white phone',
		weight = 10,
		stack = true,
		close = true,
		description = nil
	},
}