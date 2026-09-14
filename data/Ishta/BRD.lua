-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "1"
MacroBook = "9"
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Tropical Crepe"

--Modes for specific to bard
state.WeaponMode:options('Mordant Rime','Aeolian Edge','Shining Strike','Shining Blade','Savage Blade','Eviceration','Rudra\'s Storm','Staff', 'Atoyac')
state.WeaponMode:set('Savage Blade')

--Default to DT Mode
state.OffenseMode:set('TP')

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them ( Idle.X and OffenseMode.X )
state.OffenseMode:options('TP','ACC','DT','PDL','MEVA') -- ACC effects WS and TP modes

--Command to Lock Style and Set the correct macros
jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()

	--Set the weapon options.  This is set below in job customization section
	sets.Weapons = {}

	sets.Weapons['Mordant Rime'] = {
		main="Carnwenhan", 
		sub="Fusetto +2",
	}

	sets.Weapons['Aeolian Edge'] = {
		main="Carnwenhan",
		sub="Fusetto +2",
		--sub={ name="Gleti's Knife", augments={'Path: A',}},
	}

	sets.Weapons['Shining Strike'] = {
		main="Daybreak",
		sub="Crepuscular Knife",
	}

	sets.Weapons['Shining Blade'] = {
		main="Naegling",
		sub="Fusetto +2",
		--sub="Daybreak",
	}

	sets.Weapons['Savage Blade'] = {
		main="Naegling",
		sub={ name="Fusetto +2", augments={'TP Bonus +1000',}},
	}

	sets.Weapons['Staff'] = {
		main="Xoanon",
		sub="Alber Strap",
	}

	sets.Weapons['Eviceration'] = {
		main='Tauret',
		sub="Crepuscular Knife",
	}

	sets.Weapons['Rudra\'s Storm'] = {
		main="Carnwenhan",
		sub="Fusetto +2",
		--sub="Crepuscular Knife",
	}

	sets.Weapons['Atoyac'] = {
	main="Atoyac", 
	sub="Demersal Degen",
	}

	sets.Weapons.Songs = {
		main="Carnwenhan", 
		sub="Kali", 
	}

	sets.Weapons.Songs.Precast = {
	}

	sets.Weapons.Songs.Midcast = {
	}

	sets.Weapons.Shield = {
		sub="Genmei Shield",
	}

	sets.Weapons.Sleep = {
		range="Loughnashade",
	}

	-- Instruments to use
	Instrument = {}
	Instrument.Count = { name="Daurdabla" }
	Instrument.Potency = { name="Gjallarhorn" }
	Instrument.Pianissimo = { name="Gjallarhorn" } -- Swap to miracle Cheer if have
	Instrument.Honor = { name="Marsyas" }
	Instrument.Aria = { name="Loughnashade" }
	Instrument.AOE_Sleep = { name="Daurdabla" }
	Instrument.Idle = { name="Linos", augments={'Mag. Evasion+15','Phys. dmg. taken -4%','HP+20',} }
	Instrument.TP = { name="Linos", augments={'Accuracy+20','"Store TP"+4','Quadruple Attack +3',} }
	Instrument.Mordant = { name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','CHR+8',} }
	Instrument.QuickMagic = { name="Linos", augments={'Mag. Evasion+15','Occ. quickens spellcasting +4%','HP+20',} }
	Instrument.FastCast = { name="Linos", augments={'Mag. Evasion+15','"Fast Cast"+6','HP+20',} }
	Instrument.MAB = {  name="Linos", augments={'Mag.Atk.Bns."+15','Weapon skill damage +3%','INT+8',} }

	-- HP/MP Balancing Goal
	-- HP: 2200 MP: 550 

	-- Standard Idle set
	sets.Idle = {
		range=Instrument.Idle,  
		head="Fili Calot +2", 
		body="Nyame Mail", 
		hands="Bunzi's Gloves", -- 8/8 
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1", -- 6/6
		waist="Plat. Mog. Belt",
		left_ear="Infused Earring",
		right_ear="Mache earring +1",
		left_ring="Karieyh Ring",
		right_ring="Chirich Ring",
		back="Solemnity Cape",
    } -- PDT 60%%, MDT 56%
	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {})
	sets.Idle.Resting = set_combine(sets.Idle, {})

	--Used to swap into movement gear when the player is detected movement when not engaged
	sets.Movement = { feet="Fili Cothurnes +2"}

	-- Set to be used if you get cursna casted on you
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe1", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe2", priority=1},
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {}

	--Base TP set to build off
	sets.OffenseMode.TP = {
   		range={ name="Linos", augments={'Accuracy+15','"Store TP"+4','Quadruple Attack +3',}},
		head="Nyame Helm",
		body="Ashera Harness",
		hands="Bunzi's Gloves",
		legs="Volte Tights",
		feet="Revelation Sab.",
		neck="Bard's Charm +2",
    	waist="Sailfi Belt +1", 
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Chirich Ring",
		right_ring="Chirich Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
	}

	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode.DT = set_combine(sets.OffenseMode.TP, {
	})

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = set_combine(sets.OffenseMode.TP, {
	
	})

	--This set is used when OffenseMode is PDL and Enaged
	sets.OffenseMode.PDL = set_combine(sets.OffenseMode.TP, {
		left_ring="Sroda Ring",
	})

	--This set is used when OffenseMode is PDL and Enaged
	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode.DT, {
		waist="Carrier's Sash",
	})

	--The following sets augment the base TP set
	sets.DualWield = {
		--waist="Reiki Yotai",
		--left_ear="Eabani Earring",
	}

	sets.Precast = {}

	-- Used for Magic Spells
	sets.Precast.FastCast = {
		main="Carnwenhan",
		sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
		range="Gjallarhorn",
		head = "Vanya Hood",
		body="Brioso Justau. +4",
		hands="Brioso Cuffs +4",
		legs="Aya. Cosciales +1",
		feet="Brioso Slippers +4",
		neck="Aoidos' Matinee",
		waist="Aoidos' Belt",
		left_ear="Infused Earring",
		right_ear="Aoidos' Earring",
		left_ring="Prolix Ring",
		right_ring="Balrahn's Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	} -- 81 FC

	-- Used for Songs (now easy to max Fast Cast so not needed)
	sets.Precast.Songs = set_combine(sets.Precast.FastCast, {
		head="Fili Calot +2",
	})

	-- Used for "-Cure casting time"
	sets.Precast.Cure = {}

	-- Default song duration / strength
	sets.Midcast = set_combine(sets.Idle, {
		main = "Carnwenhan",
		head = "Fili Calot +2",
		neck = "Mnbw. Whistle +1",
		body = "Fili Hongreline +2",
		hands = "Fili Manchettes",
		legs = "Inyanga Shalwar +2",
		feet = "Brioso Slippers +4",
		--head="Fili Calot +2",
		--body="Fili Hongreline +3",
		--hands="Fili Manchettes +3",
		--legs="Inyanga Shalwar +2",
		--feet="Brioso Slippers +4",
		--neck="Mnbw. Whistle +1",
		--waist="Flume Belt +1",
		--left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=3},
		--right_ear={ name="Etiolation Earring", priority=1}, -- 1
		--left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=2}, -- 7/-1
		--right_ring="Defending Ring",
		--back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
		--feet="Brioso Slippers +4",
	})

	-- Reduce Durations for Dummy songs (Ballad is lowest duration)
	sets.Midcast.DummySongs = set_combine(sets.Idle, {
		head = "Fili Calot +2",
		body = "Brioso Justau. +4",
	})

	-- Cure Set
	sets.Midcast.Cure = {
		range=Instrument.FastCast, 
		main = "Daybreak",
		neck = "Nodens Gorget",
		ear1 = "Calamitous Earring",
		head = "Vanya Hood",
		hands = "Weath. Cuffs +1",
		ring1 = "Janniston Ring",
		ring2 = "Lebeche Ring",
		legs = "Vanya Slops",
		feet = "Vanya Clogs",
		--head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, -- 11/2
		--body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, -- 0/6
		--hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}}, -- 11/2
		--legs={ name="Kaykaus Tights +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, -- 11/2
		--feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, -- 11/2
		--neck={ name="Loricate Torque +1", augments={'Path: A',}},
		--waist="Luminary Sash",
		--left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		--right_ear="Mendi. Earring", -- 5/0
		--left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		--right_ring="Naji's Loop", -- 1/1
		--back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
    } -- 50% Cure Potency / 15% Cure Potency II

	-- Base set for duration
	sets.Midcast.Enhancing = {
		sub="Ammurapi Shield",
		range=Instrument.FastCast,
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Etiolation Earring",
		left_ring={ name="Stikini Ring +1",  bag="wardrobe1"},
		right_ring={ name="Stikini Ring +1",  bag="wardrobe2"},
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	-- Curaga Set (different rules than cure)
	sets.Midcast.Curaga = sets.Midcast.Cure

	-- Cursna Set
	sets.Midcast.Cursna = set_combine (sets.Midcast.Cure, {
	    hands="Inyan. Dastanas +2",
	    left_ring="Menelaus's Ring",
		right_ring="Haoma's Ring",
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		waist="Bishop's Sash",
	})

	--Used for elemental Bar Magic Spells
	sets.Midcast.Enhancing.Elemental = {}

	-- High MACC for landing spells
	sets.Midcast.Enfeebling = {
		sub="Ammurapi Shield",
		range=Instrument.Potency,
		head="Brioso Roundlet +3",
		body="Brioso Justau. +4",
		hands="Brioso Cuffs +4",
		legs="Inyanga Shalwar +2",
		--legs="Brioso Cannions +3",
		feet="Brioso Slippers +4",
		neck="Mnbw. Whistle +1",
		waist = "Luminary Sash",
		--waist={ name="Obstin. Sash", augments={'Path: A',}},
		left_ear="Aoidos' Earring",
		--left_ear="Regal Earring",
		right_ear="Fili Earring",
		--right_ear="Crep. Earring",
		left_ring="Metamorph Ring +1",
		right_ring="Vertigo Ring",
   		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	-- Bard Specific Sets

	-- Max duration
	sets.Midcast.Lullaby = set_combine(sets.Midcast.Enfeebling, {
		sub="Ammurapi Shield",
		head="Nyame Helm",
		neck="Moonbow Whistle +1",
		body="Brioso Justau. +4",
		hands="Brioso Cuffs +4",
		left_ring="Metamorph Ring +1",
		right_ring="Vertigo Ring",
		waist="Luminary Sash",
		left_ear="Pensee Earring",
		right_ear="Fili earring",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +4",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	})

	sets.Midcast.Finale = {}
	sets.Midcast.Requiem = {}
	sets.Midcast.Elegy = {}
	sets.Midcast.Prelude = {}
	sets.Midcast.Madrigal = {head="Fili Calot +2"}
    sets.Midcast.Minuet = {body="Fili Hongreline +2"}
    sets.Midcast.March = {hands="Fili Manchettes"}
    sets.Midcast.Ballad = {legs="Fili Rhingrave +3"}
    sets.Midcast.Scherzo = {feet="Fili Cothurnes +2"}
    sets.Midcast.Mazurka = {}
    sets.Midcast.Paeon = {head="Brioso Roundlet +3"}
    sets.Midcast.Threnody = {body="Mou. Manteel +1"}
    sets.Midcast.Minne = {legs="Mou. Seraweels +1"}
    sets.Midcast.Mambo = {}
    sets.Midcast.Carol = {hands="Mousai Gages +1"}
    sets.Midcast.Etude = {head="Mousai Turban +1"}
	sets.Midcast.Dirge = {}
	sets.Midcast.Sirvente = {}
	sets.Midcast.Aria = {}

	sets.Midcast.Utsusemi = set_combine(sets.Idle, {})

	-- Specific gear for spells
	sets.Midcast["Stoneskin"] = {
		waist="Siegel Sash",
	}

	-- Job Abilities
	sets.JA = {}
	sets.JA["Nightingale"] = {feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}}}
	sets.JA["Troubadour"] = {body={ name="Bihu Jstcorps. +4", augments={'Enhances "Troubadour" effect',}}}
	sets.JA["Soul Voice"] = {legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}}}
	sets.JA["Tenuto"] = {}
	sets.JA["Marcato"] = {}
	sets.JA["Clarion"] = {}
	sets.JA["Pianissimo"] = {}

	-- Dancer JA Section

	sets.Flourish = set_combine(sets.Idle.DT, {})
	sets.Jig = set_combine(sets.Idle.DT, { })
	sets.Step = set_combine(sets.OffenseMode.DT, {})
	sets.Samba = set_combine(sets.Idle.DT, {})
	sets.Waltz = set_combine(sets.OffenseMode.DT, {
		ammo="Yamarang", -- 5
		--body={ name="Gleti's Cuirass", augments={'Path: A',}}, -- 10
		hands="Slither Gloves +1", -- 5
		legs="Dashing Subligar", -- 10
	}) -- 30% Potency

	--Default WS set base
	sets.WS = {
		range={ name="Linos", augments={'Weapon skill damage +3%','STR+8',}},
		head="Nyame Helm",
		body="Bihu Jstcorps. +4",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bard's Charm +2",
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Cornelia's Ring",
		right_ring="Karieyh Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	-- Equipment to augment the Melee WS for Physical Damage Limit (Capped Attack)
	sets.WS.PDL = set_combine(sets.WS, {
		right_ring="Sroda Ring",
	})

	--The following sets augment the WS base set
	sets.WS.WSD = set_combine(sets.WS, {
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

	sets.WS.MAB = set_combine(sets.WS, {
		range=Instrument.MAB,
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		back={ name="Intarabus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

	sets.WS.ACC = set_combine(sets.WS, {})

	sets.WS.MEVA = set_combine(sets.WS, {
	    neck="Warder's Charm +1",
		waist="Carrier's Sash",
	})

	sets.WS.CRIT = set_combine(sets.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Hetairoi Ring",
		right_ring="Ilabrat Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

	sets.WS["Savage Blade"] =  set_combine(sets.WS.WSD, {
		right_ring="Sroda Ring",
	})

	sets.WS["Mordant Rime"] = set_combine(sets.WS, {
		range=Instrument.Mordant,
	})

	sets.WS["Eviceration"] = sets.WS.CRIT

	sets.WS["Aeolian Edge"] = set_combine(sets.WS.MAB, {
	})

	sets.WS["Burning Blade"] = sets.WS.MAB
	sets.WS["Shining Blade"] = set_combine( sets.WS.MAB, {
		right_ring="Weather. Ring",
	})
	sets.WS["Shining Strike"] = set_combine( sets.WS.MAB, {
		right_ring="Weather. Ring",
	})

	sets.WS["Shell Crusher"] = set_combine( sets.WS.WSD, {
		right_ring="Sroda Ring",
	})

	sets.TreasureHunter = {
		body="Volte Jupon",
		legs="Volte Hose",
		waist="Chaac Belt",
	}	
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
    equipSet = {}

    return equipSet
end
--Function is called when a self command is issued
function self_command_custom(command)

end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

function check_buff_JA()
	buff = 'None'
	--local ja_recasts = windower.ffxi.get_ability_recasts()
	return buff
end

-- Function is called when the job lua is unloaded
function user_file_unload()

end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end