function user_job_setup()
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DTLite','Parry','MEva','Hybrid')
	state.WeaponskillMode:options('Match','Normal','AtkCapped')
	state.CastingMode:options('Normal','SIRD')
	state.PhysicalDefenseMode:options('PDT_HP','PDT')
	state.MagicalDefenseMode:options('MDT_HP','BDT_HP','MDT','BDT')
	state.ResistDefenseMode:options('MEVA_HP','MEVA','Death','Charm','DTCharm')
	state.IdleMode:options('Normal', 'Tank', 'Evasion', 'PhalanxRec')
	state.Weapons:options('None','Epeolatry','EpeolatryDPS', 'Aettir','Lionheart', 'Club', 'GAxe', 'Zeni')
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	autows = 'Dimidiation'
	autowstp = 1500

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('exec binds')
	
	select_default_macro_book()
end

function user_job_self_command(commandArgs, eventArgs)
	local cmd = commandArgs[1];

	if cmd == 'FullBuff' then
			return send_command('gs c buffup')
	end

	if cmd == 'Rebuff' then
			return send_command('gs c buffup')
	end
end

function user_job_buff_change(buff, gain)
	if buff:contains('Aftermath') and gain then
		windower.send_command('@timers c "Aftermath" 180 down spells/00894.png')
	end
end

function init_gear_sets()
	gear.PDTAmbu = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Phys. dmg. taken-10%'}}
	gear.ParryAmbu = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%'}}
	gear.ResolutionAmbu = { name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','STR+10'}}
	gear.DimidiationAmbu = { name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%', 'DEX+10'}}
	gear.TPAmbu = { name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%'}}

	sets.Enmity = {
		main = "Epeolatry",
		sub = "Refined Grip +1",
		ammo = "Aqreqaq Bomblet",
		head = "Halitus Helm",
		neck = "Moonlight Necklace",
		ear1 = "Odnowa Earring +1",
		ear2 = "Cryptic Earring",
		body = "Emet Harness +1",
		hands = "Futhark Mitons +2",
		ring1 = "Moonbeam Ring",
		ring2 = "Supershear Ring",
		back = gear.ParryAmbu,
		waist = "Sulla Belt",
		legs = "Eri. Leg Guards +1",
		feet = "Erilaz Greaves +1"
	}
		
	sets.Enmity.SIRD = {
		main = "Epeolatry", -- 23enm / 25DT(II)
		sub = "Refined Grip +1", -- 3DT
		ammo = "Staunch Tathlum +1", -- 11sird / 3DT
		head = "Agwu's Cap", -- 10sird
		neck = "Moonlight Necklace", --15sird / 15enm
		ear1 = "Odnowa Earring +1", -- 3DT
		ear2 = "Cryptic Earring",
		body = "Emet Harness +1", --10enm / 6DT
		hands = "Rawhide Gloves", --15sird
		ring1 = "Evanescence Ring", --5sird
		ring2 = "Defending Ring", --10DT
		back = gear.ParryAmbu, --10enm
		waist = "Audumbla Sash", --10sird / 4DT
		legs = "Carmine Cuisses +1", --20sird
		feet = "Taeon Boots", --10sird
	} -- (96 + 5 = 101sird) / 55enm / 57 DT
	
	sets.Enmity.DT = sets.Enmity
	
	sets.Enmity.SIRDT = set_combine(sets.Enmity.DT, sets.Enmity.SIRD)
		
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
	sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {body="Runeist's Coat +3",legs="Futhark Trousers +3"})
	sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
	sets.precast.JA['Pflug'] = set_combine(sets.Enmity, {}) --feet="Runeist Bottes +1"
	sets.precast.JA['Battuta'] = set_combine(sets.Enmity, {head="Fu. Bandeau +3"}) 
	sets.precast.JA['Liement'] = set_combine(sets.Enmity, {body="Futhark Coat +3"}) 
	sets.precast.JA['Gambit'] = set_combine(sets.Enmity, {hands="Runeist's Mitons +3"}) 
	sets.precast.JA['Rayke'] = set_combine(sets.Enmity, {feet="Futhark Boots +1"}) 
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {body="Futhark Coat +3"}) 
	sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {hands="Futhark Mitons +2"}) 
	sets.precast.JA['Embolden'] = set_combine(sets.Enmity, {})
	sets.precast.JA['One For All'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Souleater'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

	sets.precast.JA['Lunge'] = {
		ammo = "Seeth. Bomblet +1",
		head = "Agwu's Cap",
		neck = "Sibyl Scarf",
		ear1 = "Friomisi Earring",
		ear2 = "Hermetic Earring",
		body = "Samnuha Coat",
		hands = "Agwu's Gages",
		ring1 = "Mujin Band",
		ring2 = "Locus Ring",
		waist = "Eschan Stone",
		legs = "Agwu's Slops",
		feet = "Agwu's Pigaches",
	}

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	-- Gear for specific elemental nukes.
	sets.element.Dark = {head = "Pixie Hairpin +1", ring2="Archon Ring"}

	-- Pulse sets, different stats for different rune modes, stat aligned.
	sets.precast.JA['Vivacious Pulse'] = {
		head = "Erilaz Galea +1",
		neck = "Incanter's Torque",
		legs = "Rune. Trousers +3",
		ring1 = "Stikini Ring",
		ring2 = "Stikini Ring",
	}
	
	-- Fast cast sets for spells
	sets.precast.FC = {
		main = "Malignance Sword",
		ammo = "Sapience Orb",
		head = "Rune. Bandeau +3",
		neck = "Sanctity Necklace",
		ear1 = "Odnowa Earring +1",
		ear2 = "Loquac. Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring2 = "Moonbeam Ring",
		ring1 = "Defending Ring",
		legs = "Futhark Trousers +3",
		feet = "Nyame Sollerets"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga Beads'})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {
		ammo = "Knobkierrie",
		head = "Lustratio Cap +1",
		neck = 'Rep. Plat. Medal',
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Nyame Mail",
		hands = "Meg. Gloves +2",
		ring1 = "Karieyh Ring +1",
		ring2 = "Niqmaddu Ring",
		back = gear.DimidiationAmbu,
		waist = "Grunfeld Rope",
		legs = "Lustr. Subligar +1",
		feet = "Lustra. Leggings +1",
	}

	sets.precast.WS.Resolution = {
		ammo = "Seeth. Bomblet +1",
		head = "Lustratio Cap +1",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Ayanmo Corazza +2",
		hands = gear.herculean_ta_hands,
		ring1 = "Niqmaddu Ring",
		ring2 = "Regal Ring",
		back = gear.ResolutionAmbu,
		waist = "Fotia Belt",
		legs = "Meg. Chausses +2",
		feet = "Lustra. Leggings +1",
	}

	sets.precast.WS.Dimidiation = sets.precast.WS

	sets.precast.WS.Judgment = {
		ammo = "Knobkierrie",
		head = "Lustratio Cap +1",
		neck = 'Rep. Plat. Medal',
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Nyame Mail",
		hands = "Meg. Gloves +2",
		ring1 = "Karieyh Ring +1",
		ring2 = "Niqmaddu Ring",
		back = gear.DimidiationAmbu,
		waist = "Grunfeld Rope",
		legs = "Lustr. Subligar +1",
		feet = "Lustra. Leggings +1",
	}

	sets.precast.WS.Dimidiation.AtkCapped = set_combine(sets.precast.WS.Dimidiation, {
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
	})

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
	sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.FastRecast.SIRD = sets.precast.FC.Parry

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		main = "Pukulatmuj +1",
		ammo = "Staunch Tathlum +1",
		head = "Erilaz Galea +1",
		neck = "Incanter's Torque",
		ear2 = "Mimir Earring",
		ear1 = "Andoaa Earring",
		body = "Nyame Mail",
		hands = "Runeist's Mitons +3",
		ring1 = "Stikini Ring",
		ring2 = "Stikini Ring",
		waist = "Olympus Sash",
		legs = "Futhark Trousers +3",
		feet = "Nyame Sollerets"
	})
	
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		head = "Fu. Bandeau +3",
		ear1 = "Odnowa Earring +1",
		body = gear.taeon_phalanx_body,
		hands = gear.herculean_phalanx_hands,
		feet = "Taeon Boots",
	})

	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {
		head = "Rune. Bandeau +3",
	}) 

	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
		head = "Erilaz Galea +1",
		waist = "Gishdubar Sash",
	}) 

	sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'], {
		head = "Carmine Mask +1",
		body = "Manasa Chasuble"
	})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Jettatura = set_combine(sets.Enmity, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Sandspin = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Geist Wall'] = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})

	sets.Phalanx_Received = {
		head = "Fu. Bandeau +3",
		body = gear.taeon_phalanx_body,
		hands = gear.herculean_phalanx_hands,
		legs = gear.taeon_phalanx_legs,
		feet = "Taeon Boots",
	}
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

	sets.idle = {
		main = "Epeolatry",
		sub = "Refined Grip +1",
		ammo = "Homiliary",
		head = "Rawhide Mask",
		neck = "Bathy Choker +1",
		ear1 = "Infused Earring",
		ear2 = "Tuisto Earring",
		body = "Runeist's Coat +3",
		hands = "Turms Mittens +1",
		ring1 = "Defending Ring",
		ring2 = "Moonbeam Ring",
		waist = "Fucho-no-Obi",
		legs = "Carmine Cuisses +1",
		feet = "Nyame Sollerets",
	}
		
	sets.idle.Tank = {
		main = "Epeolatry",
		sub = "Refined Grip +1",
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Loricate Torque +1",
		ear1 = "Odnowa Earring +1",
		ear2 = "Tuisto Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Moonbeam Ring",
		back = gear.PDTAmbu,
		waist = "Eschan Stone",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
	}

	sets.idle.Evasion = {
		main = "Soulcleaver",
		sub = "Refined Grip +1",
		ammo = "Yamarang",
		head = "Nyame Helm",
		neck = "Bathy Choker +1",
		ear1 = "Infused Earring",
		ear2 = "Eabani Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		back = gear.PDTAmbu,
		waist = "Eschan Stone",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
	}

	sets.idle.KiteTank = set_combine(sets.idle.Tank, {
		legs="Carmine Cuisses +1",
	})

	sets.idle.Weak = set_combine(sets.idle.Tank, {})

	sets.idle.PhalanxRec = sets.Phalanx_Received
	sets.Kiting = {}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
	sets.MP = {ear2="Ethereal Earring"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Epeolatry = {main="Epeolatry",sub="Refined Grip +1"}
	sets.weapons.EpeolatryDPS = {main="Epeolatry",sub="Utu Grip"}
	sets.weapons.Aettir = {main="Aettir",sub="Refined Grip +1"}
	sets.weapons.Lionheart = {main="Lionheart",sub="Utu Grip"}
	sets.weapons.Club = {main="Loxotic Mace",sub=empty}
	sets.weapons.GAxe = {main="Kaja Chopper",sub="Utu Grip"}
	sets.weapons.Zeni = {main="Wind Knife",sub=empty, range = "Soultrapper 2000", ammo = "Blank Soulplate"}
	

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------
	gear.AMSwaps = {
		ear2 = 'Dedition Earring',
		ring2 = "Chirich Ring +1",
	}

	sets.engaged = {
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1",
		neck = "Anu Torque",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = "Ashera Harness",
		hands = "Adhemar Wrist. +1",
		ring1 = "Niqmaddu Ring",
		ring2 = "Epona's Ring",
		back = gear.TPAmbu,
		waist = "Windbuffet Belt +1",
		legs = "Samnuha Tights",
		feet = gear.herculean_ta_feet,
	}

	sets.engaged.AM = set_combine(sets.engaged, gear.AMSwaps)

	sets.engaged.Acc = set_combine(sets.engaged, {
		head = "Carmine Mask +1",
		ear2 = "Cessance Earring",
		waist = "Ioskeha Belt",
		legs = "Carmine Cuisses +1",
	})

	sets.engaged.Acc.AM = set_combine(sets.engaged.Acc, gear.AMSwaps)

	sets.engaged.DTLite = {
		head = "Adhemar Bonnet +1",
		neck = "Futhark Torque +1",
		ear1 = "Dedition Earring",
		ear2 = "Sherida Earring",
		body = "Ashera Harness",
		hands = "Adhemar Wrist. +1",
		ring1 = "Defending Ring",
		ring2 = "Niqmaddu Ring",
		back = gear.TPAmbu,
		waist = "Ioskeha Belt",
		legs = "Meg. Chausses +2",
		feet = gear.herculean_ta_feet,
	}

	sets.engaged.Acc.DTLite = set_combine(sets.engaged.DTLite, {
		head = "Carmine Mask +1",
		ear2 = "Cessance Earring",
		waist = "Ioskeha Belt",
		legs = "Carmine Cuisses +1",
	})

	sets.engaged.Parry = {
		sub = "Refined Grip +1",
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Futhark Torque +1",
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		body = "Nyame Mail",
		hands = "Turms Mittens +1",
		ring1 = "Defending Ring",
		ring2 = "Moonbeam Ring",
		back = gear.ParryAmbu,
		legs = "Nyame Flanchard",
		feet = "Erilaz Greaves +1", -- swap to turms once Engraved Belt is available
	}

	sets.engaged.MEva = set_combine(sets.engaged.Parry, {
		ammo = "Yamarang",
		body = "Runeist's Coat +3",
		hands = "Nyame Gauntlets",
		feet = "Nyame Sollerets",
	})

	sets.engaged.Hybrid = {
		ammo = "Yamarang",
		head = "Adhemar Bonnet +1",
		neck = "Anu Torque",
		ear1 = "Telos Earring",
		ear2 = "Sherida Earring",
		body = "Ashera Harness",
		hands = "Adhemar Wrist. +1",
		ring1 = "Niqmaddu Ring",
		ring2 = "Moonbeam Ring",
		back = gear.TPAmbu,
		waist = "Ioskeha Belt",
		legs = "Meg. Chausses +2",
		feet = gear.herculean_ta_feet,
	}

	sets.engaged.Hybrid.AM = set_combine(sets.engaged.Hybrid, {
		head = "Aya. Zucchetto +2",
		waist = 'Sailfi Belt +1'
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.buff.Battuta = {}
	sets.buff.Embolden = {}
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'SCH' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'BLU' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'WAR' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'SAM' then
		set_macro_page(3, 4)
	elseif player.sub_job == 'DRK' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 4)
	else
		set_macro_page(1, 4)
	end
end

--function user_job_lockstyle()
	--if global_lockstyle then
		--windower.chat.input('/lockstyleset ' .. global_lockstyle)
	--else
		--windower.chat.input('/lockstyleset 7')
	--end
--end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	When='Combat'},
		{Name='Temper',		Buff='Multi Strikes',	SpellID=493,	When='Engaged'},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	When='Always'},
		{Name='Refresh',	Buff='Refresh',			SpellID=109,	When='Idle'},
	},

	Default = {
		{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	Reapply=false},
		{Name='Temper',		Buff='Multi Strikes',	SpellID=493,	Reapply=false},
		{Name='Refresh',	Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Aquaveil',	Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Blink',		Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Ice Spikes',	Buff='Ice Spikes',			SpellID=250,	Reapply=false},
		{Name='Cocoon',		Buff='Defense Boost',	SpellID=547,	Reapply=false},
	},
	
	Tank = {
		{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	Reapply=false},
		{Name='Cocoon',		Buff='Defense Boost',	SpellID=547,	Reapply=false},
		{Name='Haste',		Buff='Haste',			SpellID=57,		Reapply=false},
		{Name='Refresh',	Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	Reapply=false},
	},
	
	Full = {
		{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	Reapply=false},
		{Name='Temper',		Buff='Multi Strikes',	SpellID=493,	Reapply=false},
		{Name='Refresh',	Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Aquaveil',	Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Stoneskin',	Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',		Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Ice Spikes',	Buff='Ice Spikes',			SpellID=250,	Reapply=false},
		{Name='Cocoon',		Buff='Defense Boost',	SpellID=547,	Reapply=false},
	},
	Melee = {
		{Name='Temper',		Buff='Multi Strikes',	SpellID=493,	Reapply=false},
		{Name='Haste',		Buff='Haste',			SpellID=57,		Reapply=false},
		{Name='Refresh',	Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Aquaveil',	Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Stoneskin',	Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',		Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	Reapply=false},
	},
}