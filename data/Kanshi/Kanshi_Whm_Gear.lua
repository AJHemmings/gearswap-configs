-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal','Acc')
	state.CastingMode:options('Normal','Resistant')
	state.IdleMode:options('Refresh','DT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	--send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	-- Weapons sets
	sets.weapons.MeleeWeapons = {
		main = "Beryllium Mace"
	}
	sets.weapons.DualWeapons = {}
	
	sets.buff.Sublimation = {waist="Embla Sash"} 
	sets.buff.DTSublimation = {waist="Embla Sash"} 
	
	-- Precast SetsTheo. Bliaut

	-- Fast cast sets for spells
	sets.precast.FC = {
		ammo="Incantor Stone",
		head="Bunzi's Hat",
		body="Inyanga Jubbah +1",
		hands="Gende. Gages +1",
		legs="Aya. Cosciales +1",
		feet="Regal Pumps +1",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Witful Belt",
		ear2="Mendi. Earring",
		ear1="Loquac. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10',}},
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		ammo="Hydrocera",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
		body="Theo. Bliaut +3",
		hands={ name="Chironic Gloves", augments={'Attack+2','AGI+3','"Treasure Hunter"+1','Accuracy+15 Attack+15',}},
		legs="Aya. Cosciales +1",
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Olympus Sash",
		left_ear="Mendi. Earring",
		right_ear="Loquac. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Perimede Cape",
	})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		ammo="Hydrocera",
		head="Befouled Crown",
		body="Inyanga Jubbah +1",
		hands={ name="Chironic Gloves", augments={'Attack+2','AGI+3','"Treasure Hunter"+1','Accuracy+15 Attack+15',}},
		legs="Ebers Pant. +2",
		feet="Regal Pumps +1",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Olympus Sash",
		left_ear="Mendi. Earring",
		right_ear="Loquac. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Perimede Cape",
	})

	sets.precast.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'], {
		main = 'Yagrush',
	})	
	
	sets.midcast.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'], {
		main = 'Yagrush',
	})	

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
		legs = "Ebers Pant. +2",
		back = "Disperser's Cape",
		ear1 = "Nourish. Earring +1",
	})

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		sub = "Sors Shield",
		ammo = "Incantor Stone",
		hands = "Gende. Gages +1",
		head = "Vanya Hood",
		Body = "Inyanga Jubbah +1",
		back = "Alaunus's Cape",
		waist = "Ninurta's Sash",
		ear1 = "Loquac. Earring",
		ear2 = "Mendi. Earring",
		legs = "Ebers Pant. +2",
		feet = 'Vanya Clogs',
	})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {})
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {})

	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Oshasha's Treatise",
		head="Bunzi's Hat",
		body="Theo. Bliaut +3",
		hands="Theophany Mitts +3",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Light Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Digni. Earring",
		left_ring="Rajas Ring",
		right_ring="Apate Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10',}},
	}
	
	sets.precast.WS.Dagan = {}
		
	sets.MaxTP = {}
	sets.MaxTP.Dagan = {}

	--sets.precast.WS['Flash Nova'] = {}

	--sets.precast.WS['Mystic Boon'] = {}

	-- Midcast Sets

	sets.Kiting = { feet = "Herald's Gaiters", }
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst = {}

	sets.midcast.FastRecast = {}
	
	-- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	--Cure pot gear cap 50%
	sets.midcast.Cure = {
		main = 'Chatoyant Staff', --10%
		sub = 'Enki Strap',
		head = 'Ebers Cap +2', -- 16%
		neck = "Cleric's Torque +2", --10%
		ear1 = "Mendi. Earring", -- 5%
		ear2 = "Glorious Earring", --II 2%
		body = 'Theophany Bliaut +3', -- II 6%
		hands = 'Theophany Mitts +3', -- II 4%
		waist = 'Hachirin-no-Obi',
		legs = 'Ebers Pant. +2',
		feet = 'Kaykaus Boots', --15%
		ring1 = "Menelaus's Ring", --5%
		ring2 = "Janniston Ring", -- II 5%
	}
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {})

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.Cure, {})

	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.LightDayCuraga = set_combine(sets.midcast.Cure, {})

	sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {})
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {})

	sets.midcast.Cursna = {
		main="Yagrush",
		sub="Sors Shield",
		ammo="Hydrocera",
		head="Befouled Crown",
		body="Orison Bliaut +1",
		hands="Theophany Mitts +3",
		legs="Theo. Pant. +1",
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Malison Medallion",
		waist="Rumination Sash",
		left_ear="Mendi. Earring",
		right_ear="Loquac. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10',}},
	}
	
	sets.midcast.StatusRemoval = {
		main="Yagrush",
		hands = 'Ebers Mitts +1',
		legs = 'Ebers Pant. +2',
	}
	
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {})
	
	-- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {
		head = "Telchine Cap",
		body = "Telchine Chas.",
		hands = "Telchine Gloves",
		ear2 = 'Andoaa Earring',
		legs = "Telchine Braconi",
		feet = "Telchine Pigaches",
		waist = 'Embla Sash',
	}
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {
		feet = 'Ebers Duckbills +1',
	})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main = 'Bolelabunga',
		sub = 'Culminus',
		head = "Inyanga Tiara +1",
		hands = 'Ebers Mitts +1',
	})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		main = "Beneficus",
		head = 'Ebers Cap +2',
		body = 'Ebers Bliaud +1',
		hands = 'Ebers Mitts +1',
		legs = 'Ebers Pant. +2',
		feet = 'Ebers Duckbills +1',
	})

	sets.midcast.Impact = {}
		
	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast['Divine Magic'] = {
		body = 'Vanya Robe',
	}
		
	sets.midcast.Holy = {}

	sets.midcast['Dark Magic'] = {}

	sets.midcast.Drain = {}

	sets.midcast.Drain.Resistant = {}

	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}

	sets.midcast.Stun.Resistant = {}
		
	sets.midcast.Dispel = {}
		
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})

	sets.midcast['Enfeebling Magic'] = {
		main= "Bunzi's Rod",
		sub = 'Ammurapi Shield',
		head = "Bunzi's Hat",
		body = "Bunzi's Robe",
		hands = "Bunzi's Gloves",
		legs = "Bunzi's Pants",
		feet = "Bunzi's Sabots",
		back = "Alaunus's Cape",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",



	}

	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main="Yagrush",
		sub="Genmei Shield",
		ammo="Homiliary",
		head={ name="Chironic Hat", augments={'"Dbl.Atk."+1','INT+2','"Refresh"+2','Accuracy+3 Attack+3',}},
		body="Theo. Bliaut +3",
		hands={ name="Chironic Gloves", augments={'INT+1','DEX+8','"Refresh"+2',}},
		legs="Bunzi's Pants",
		feet="Herald's Gaiters",
		neck="Elite Royal Collar",
		waist="Plat. Mog. Belt",
		left_ear="Loquac. Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10',}},
	}

	sets.IdleWakeUp = {Main="Lorg Mor"}

	sets.idle.Refresh = set_combine(sets.idle, {
		main="Yagrush",
		sub="Genmei Shield",
		ammo="Homiliary",
		head={ name="Chironic Hat", augments={'"Dbl.Atk."+1','INT+2','"Refresh"+2','Accuracy+3 Attack+3',}},
		body="Theo. Bliaut +3",
		hands={ name="Chironic Gloves", augments={'INT+1','DEX+8','"Refresh"+2',}},
		legs="Assiduity Pants",
		feet= "Herald's Gaiters",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10',}},
	})

	sets.idle.DT = set_combine(sets.idle, {
		ammo="Homiliary",
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10',}},
	})

	-- Defense sets

	sets.defense.PDT = sets.idle

	sets.defense.MDT = sets.idle

	sets.defense.MEVA = sets.idle
		
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Basic set for if no TP weapon is defined.
	sets.engaged = {
		head = gear.ayanmo.head,
		hands = gear.ayanmo.hands,
		body = gear.ayanmo.body,
		feet = gear.ayanmo.feet,
		legs = gear.ayanmo.legs,
		waist = "Ninurta's Sash",
		ear1 = 'Digni. Earring',
		ear2 = 'Dominance Earring',
		back = 'Bleating Mantle',
		ring1 = 'Rajas Ring',
		ring2 = "Apate Ring",
		neck = 'Sanctity Necklace'
	}

	sets.engaged.Acc = set_combine(sets.engaged, {})

	sets.engaged.DW = set_combine(sets.engaged, {})

	sets.engaged.DW.Acc = set_combine(sets.engaged, {})

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = {
		back = 'Mending Cape',
	}

	sets.HPDown = {}

	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 1)
end

function user_job_lockstyle()
		windower.chat.input('/lockstyleset 1')
end