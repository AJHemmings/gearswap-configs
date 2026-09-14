function user_job_setup()

	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.IdleMode:options('Normal','PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'TP', 'DualTP')

	gear.idle_jse_back = 'Nantosuelta\'s cape'
	
	autoindi = "Fury"
	autogeo = "Frailty"
	autoentrust = 'Refresh'
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')
	
	indi_duration = 290
	
	select_default_macro_book()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic"}
	sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +1",back="Nantosuelta's Cape"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +2",hands="Bagua Mitaines"}
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}
	
	-- Fast cast sets for spells

	sets.precast.FC = {
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+27','"Fast Cast"+4','Accuracy+11 Attack+11','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+25','Mag. crit. hit dmg. +7%',}},
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Conserve MP"+2','MND+10','Mag. Acc.+5','"Mag.Atk.Bns."+9',}},
		neck="Deviant Necklace",
		waist="Witful Belt",
		left_ear="Handler's Earring +1",
		right_ear="Malignance Earring",,
		left_ring="Medada's Ring",
		right_ring="Kishar Ring",
		back="Moonbeam Cape",
	}

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna",ammo=empty})
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		hands = 'Bagua Mitaines',
		feet = 'Mallquis Clogs +1'
	})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		hands = 'Vanya Cuffs',
		body = 'Vanya Robe',
		legs = 'Vanya Slops',
	})
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Oshasha's Treatise",
		head="Jhakri Coronal +1",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +1",
		neck="Loricate Torque +1",
		waist="Famine Sash",
		left_ear="Moonshade Earring",
		right_ear="Thureous Earring",
		left_ring="Apate Ring",
		right_ring="Jhakri Ring",
		back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}},		
	}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast.Geomancy = {
		main = 'Idris',
		sub = 'Genmei Shield',
		neck = 'Bagua Charm +2',
		head = 'Azimuth Hood +2',
		hands = 'Geo. Mitaines +2',
		body = 'Bagua Tunic',
		legs = 'Azimuth Tights',
		back = 'Lifestream Cape',
		ear1 = 'Etiolation Earring',
		ear2 = 'Genmei Earring',
		ring1 = 'Stikini Ring +1',
		ring2 = 'Renaye Ring'
	}


	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {back=gear.idle_jse_back,legs="Bagua Pants +1",feet="Azimuth Gaiters"})
		
	sets.midcast.Cure = {
		main="Gada", -- 26%
		sub="Sors Shield", --3%
		ammo="Pemphredo Tathlum",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --10%
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --5%
		neck="Deviant Necklace",
		waist="Bishop's Sash",
		left_ear="Mendi. Earring", --5%
		right_ear="Meili Earring",
		left_ring="Metamorph Ring",
		right_ring="Stikini Ring +1",
		back="Moonbeam Cape",
	} --Cure pot 49%

	sets.midcast.LightWeatherCure = sets.midcast.Cure
		
		--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = sets.midcast.Cure

	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Cursna =  sets.midcast.Cure
	
	sets.midcast.StatusRemoval = sets.midcast.FastRecast
	
	sets.midcast['Elemental Magic'] = {
		
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+27','"Fast Cast"+4','Accuracy+11 Attack+11','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		body="Azimuth Coat +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Conserve MP"+2','MND+10','Mag. Acc.+5','"Mag.Atk.Bns."+9',}},
		neck="Sibyl Scarf",
		waist="Famine Sash",
		left_ear="Friomisi Earring",
		right_ear="Hermetic Earring",
		left_ring="Medada's Ring",
		right_ring="Stikini Ring +1",
		back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}},
		--main = 'Grioavolr',
		--sub = 'Giuoco Grip',
		--head = 'Merlinic Hood',
		--neck = 'Saevus Pendant +1',
		--hands = gear.jhakri.hands,
		--waist = "Eschan Stone",
		--back = 'Lifestream Cape',
		--ear1 = 'Malignance Earring',
		--ear2 = 'Barkaro. Earring',
		--ring1 = 'Acumen Ring',
		--ring2 = 'Metamor. Ring +1',
		--feet = 'Mallquis Clogs +1',
		--body = 'Mallquis Saio +2',
		--legs = 'Mallquis Trews +1'
	}

	sets.midcast['Elemental Magic'].Resistant = sets.midcast['Elemental Magic']
		
	sets.midcast['Elemental Magic'].Proc = sets.midcast['Elemental Magic']
	
	sets.midcast['Elemental Magic'].Fodder = sets.midcast['Elemental Magic']
		
	sets.midcast['Elemental Magic'].HighTierNuke = {
		main="Solstice",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+27','"Fast Cast"+4','Accuracy+11 Attack+11','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+28','Magic Damage +4','MND+10',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Conserve MP"+2','MND+10','Mag. Acc.+5','"Mag.Atk.Bns."+9',}},
		neck="Saevus Pendant +1",
		waist="Famine Sash",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Medada's Ring",
		right_ring="Jhakri Ring",
		back="Moonbeam Cape",
	}
	
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = sets.midcast['Elemental Magic'].HighTierNuke

	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = sets.midcast['Elemental Magic'].HighTierNuke
		
	sets.midcast['Dark Magic'] = {}
		
	sets.midcast.Drain = {
		main={ name="Gada", augments={'"Cure" potency +8%','VIT+15','Mag. Acc.+13','"Mag.Atk.Bns."+8','DMG:+7',}},
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'"Conserve MP"+5','"Drain" and "Aspir" potency +7','Accuracy+8 Attack+8','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Conserve MP"+2','MND+10','Mag. Acc.+5','"Mag.Atk.Bns."+9',}},
		neck="Erra Pendant",
		waist="Fucho-no-obi",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Medada's Ring",
		right_ring="Jhakri Ring",
		back="Moonbeam Cape",
	}
	
	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {}
		
	sets.midcast.Impact = {}
		
	sets.midcast.Dispel = {}

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})
		
	sets.midcast['Enfeebling Magic'] = {
		main = 'Gada',
		sub = 'Sors Shield',
		range = empty,
		ammo = "Pemphredo Tathlum",
		head = "Azimuth Hood +2",
		neck = 'Bagua Charm +2',
		ear1 = 'Malignance Earring',
		ear2 = 'Azimuth Earring',
		body = "Jhakri Robe +2",
		hands = "Azimuth Gloves +2",
		left_ring="Medada's Ring",
		right_ring="Stikini Ring +1",
		back = 'Lifestream Cape',
		legs = 'Psycloth Lappas',
		feet = 'Bagua Sandals',
	}
		
	sets.midcast['Enhancing Magic'] = {
		ear1 = 'Mimir Earring',
		waist = 'Embla Sash',
	}

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main = 'Bolelabunga',
		sub = 'Genmei Shield',
	})


	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {}

	-- Idle sets

	sets.idle = {
		main="Idris",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Azimuth Hood +2",
		body="Jhakri Robe +2",
		hands="Geo. Mitaines +2",
		legs="Jhakri Slops +2",
		feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Isa Belt",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring="Renaye Ring",
		right_ring="Stikini Ring +1",
		back="Moonbeam Cape",
	}
		
	sets.idle.PDT = set_combine(sets.idle, {
		neck = 'Twilight Torque',
		hands = 'Geomancy Mitaines +2',
		body = 'Mallquis Saio +1',
	})

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {
		main="Idris",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Azimuth Hood +2",
		body="Jhakri Robe +2",
		hands="Geo. Mitaines +2",
		legs="Jhakri Slops +2",
		feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Isa Belt",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring="Renaye Ring",
		right_ring="Stikini Ring +1",
		back="Moonbeam Cape",
	}

	sets.idle.PDT.Pet = {
		main = 'Malignance Pole',
		range = 'Dunna',
		head = 'Azimuth Hood +2',
		hands = 'Geo. Mitaines +2',
		waist = "Fucho-no-Obi",
		body = 'Telchine Chas.',
		neck = 'Bagua Charm +1',
		legs = 'Telchine Braconi',
		feet = 'Telchine Pigaches',
		back = 'Nantosuelta\'s Cape',
		ear1 = 'Etiolation Earring',
		ear2 = 'Ethereal Earring',
		ring2 = 'Dark Ring',
		ring1 = "Defending Ring"
	}

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = {}

	-- Defense sets
	
	sets.defense.PDT = sets.idle.PDT

	sets.defense.MDT = sets.idle.PDT
		
	sets.defense.MEVA = sets.idle.PDT
		
	sets.defense.PetPDT = sets.idle.PDT.Pet
		
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = { feet = "Geomancy Sandals", }
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	sets.HPDown = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		head="Jhakri Coronal +1",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +1",
		neck="Loricate Torque +1",
		waist="Famine Sash",
		left_ear="Dominance Earring",
		right_ear="Thureous Earring",
		left_ring="Apate Ring",
		right_ring="Jhakri Ring",
		back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}},
	}	
	
--	sets.engaged = {
--		head = 'Nyame Helm',
--		neck = "Sanctity Necklace",
--		ear1 = "Brutal Earring",
--		ear2 = "Cessance Earring",
--		body = 'Nyame Mail',
--		hands = 'Nyame Gauntlets',
--		ring1 = "Petrov Ring",
--		ring2 = "Chirich Ring +1",
--		back = "Solemnity Cape",
--		waist = "Windbuffet Belt +1",
--		legs = gear.jhakri.legs,
--		feet = 'Nyame Sollerets',
--	}
		
	sets.engaged.DW = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'], {
		ring1 = 'Locus Ring',
	})
	sets.ResistantMagicBurst = {}
	
	sets.buff.Sublimation = {}
	sets.buff.DTSublimation = {}
	
	-- Weapons sets
	sets.weapons.TP = { main = 'Daybreak', sub = "Genmei Shield" }
	sets.weapons.DualTP = { main = 'Daybreak', sub = "Ternion Dagger +1" }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 5)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 1')
end