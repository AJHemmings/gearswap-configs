function user_job_setup()
	autows = 'Evisceration'
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal','AoE')
	state.IdleMode:options('Normal','DT','Refresh','DynaRP')
	state.Weapons:options('None','Sword','Dagger')

	-- Adjust this if using the Terpander (new +song instrument)
	info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 2
	
	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(true, 'Use Custom Timers')
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ExtraSongsMode')

	select_default_macro_book(2)
end

function user_job_self_command(commandArgs, eventArgs)
	local cmd = commandArgs[1];

	if cmd == 'FullBuff' then
			windower.add_to_chat(127, 'Performing full buff...')
			return send_command('exec brd/start.txt')
	end

	if cmd == 'Rebuff' then
			windower.add_to_chat(127, 'Performing full buff...')
			return send_command('exec brd/rebuff.txt')
	end

	if cmd == 'CrowdControl' then
		send_command('input /ma "Horde Lullaby II" <t>')
	end
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	gear.ambu = {
		--debuff = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10'}},
		--tp = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
		savage = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	}
	-- Weapons sets
	sets.weapons.Sword = { main = 'Naegling', sub = "Gleti's Knife" }
	sets.weapons.Dagger = { main = 'Carnwenhan', sub = "Gleti's Knife" }

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		legs="Vanya Slops",
		feet="Fili Cothurnes +2",
		neck="Mnbw. Whistle +1",
		waist="Aoidos' Belt",
		left_ear="Aoidos' Earring",
		right_ear="Infused Earring",
		left_ring="Balrahn's Ring",
		right_ring="Prolix Ring",
		back="Swith Cape",
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ring2 = "Lebeche Ring",
		legs = "Doyen Pants",
		feet = "Vanya Clogs",
	})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {
		legs = "Doyen Pants",
	})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.BardSong =  set_combine(sets.precast.FC, {
		main="Carnwenhan",
		sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
		range="Gjallarhorn",
		head="Fili Calot +2",
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		legs="Aya. Cosciales +1",
		feet="Brioso Slippers +3",
		neck="Aoidos' Matinee",
		waist="Aoidos' Belt",
		left_ear="Infused Earring",
		right_ear="Aoidos' Earring",
		left_ring="Prolix Ring",
		right_ring="Balrahn's Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	})

	sets.precast.FC.BardSong.DW = set_combine(sets.precast.FC.BardSong, {
		sub = "Kali",
	})

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong, {range="Gjallarhorn"})
	sets.precast.FC.Lullaby = {range="Gjallarhorn"}
	sets.precast.FC.Lullaby.AoE = {range="Blurred Harp +1"}
	sets.precast.FC.Paeon = {range = "Daurdabla"}
	sets.precast.FC['Horde Lullaby'] = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby II'] = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Blurred Harp +1"}

	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong, {range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = { feet="Bihu Slippers +3" }
	sets.precast.JA.Troubadour = { body="Bihu Jstcorps. +3" }
	sets.precast.JA['Soul Voice'] = { legs="Bihu Cannions +3" }

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Subtlety Spec.",
		waist="Luminary Sash",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Cornelia's Ring",
		right_ring="Karieyh Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	sets.precast.WS['Savage Blade'] = {
		head="Nyame Helm",
		body="Bihu Jstcorps. +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Cornelia's Ring",
		right_ring="AKarieyh Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = sets.precast.FC

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {}
	sets.midcast.Lullaby = {
		main="Carnwenhan",
		sub="Ammurapi Shield",
		head="Nyame Helm",
		neck="Moonbow Whistle +1",
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		left_ring="Metamorph Ring +1",
		right_ring="Vertigo Ring",
		back="Intarabus's Cape",
		waist="Luminary Sash",
		left_ear="Pensee Earring",
		right_ear="Fili earring",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
	}
	sets.midcast.Madrigal = { back = "Intarabus's Cape", feet = "Fili Cothurnes +2" }
	sets.midcast.Prelude = { back = "Intarabus's Cape", feet = "Fili Cothurnes +2" }
	sets.midcast.Mambo = {}
	sets.midcast.Scherzo = { feet = "Fili Cothurnes +2" }
	sets.midcast.Carol = {}
	sets.midcast.Etude = {}
	sets.midcast.Paeon = { range = "Daurdabla" }
	sets.midcast.March = {}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, { range = "Marsyas" })
	sets.midcast.Minuet = {}
	sets.midcast.Minne = { range = "Daurdabla" }
	sets.midcast["Sentinel's Scherzo"] = { feet = "Fili Cothurnes +2" }
	sets.midcast['Magic Finale'] = {}
	sets.midcast.Mazurka = {range="Marsyas"}
	sets.midcast['Goblin Gavotte'] = { range = "Daurdabla" }
	sets.midcast['Fowl Aubade'] = { range = "Daurdabla" }
	sets.midcast["Scop's Operetta"] = { range = "Daurdabla" }

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		main = "Carnwenhan",
		head = "Fili Calot +2",
		neck = "Mnbw. Whistle +1",
		body = "Fili Hongreline +2",
		hands = "Fili Manchettes",
		legs = "Inyanga Shalwar +2",
		feet = "Brioso Slippers +3",
	}

	sets.midcast.SongEffect.DW = set_combine(sets.midcast.SongEffect, {
		sub = "Kali",
	})

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
		main = "Carnwenhan",
		sub = "Ammurapi Shield",
		head = "Brioso Roundlet +3",
		neck = "Mnbw. Whistle +1",
		ear1 = "Pensee Earring",
		ear2 = "Fili Earring",
		body = "Brioso Justau. +3",
		hands = "Nyame Gauntlets",
		ring1 = "Stikini Ring",
		ring2 = "Stikini Ring",
		back = "Intarabus's Cape",
		waist = "Luminary Sash",
		legs = "Inyanga Shalwar +2",
		feet = "Brioso Slippers +3",
	}

	sets.midcast.SongDebuff.DW = set_combine(sets.midcast.SongDebuff, {
		sub = "Kali",
	})
		
	-- Song-specific recast reduction
	sets.midcast.SongRecast = {}
		
	sets.midcast.SongDebuff.DW = {}

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {
		main = "Daybreak",
		neck = "Nodens Gorget",
		ear1 = "Calamitous Earring",
		head = "Vanya Hood",
		hands = "Weath. Cuffs +1",
		ring1 = "Janniston Ring",
		ring2 = "Lebeche Ring",
		legs = "Vanya Slops",
		feet = "Vanya Clogs",
	}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
		
	sets.midcast['Enhancing Magic'] = {
		sub = "Ammurapi Shield",
		waist = "Embla Sash",
	}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck = "Nodens Gorget",
	})
		
	sets.midcast['Elemental Magic'] = {}
	sets.midcast['Enfeebling Magic'] = {
		sub = "Ammurapi Shield",
	}
		
	sets.midcast['Elemental Magic'].Resistant = {}
		
	sets.midcast.Cursna =  {
	}
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	-- Resting sets
	sets.resting = {}

	sets.idle.Normal = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Fili Cothurnes +2",
		neck="Elite Royal Collar",
		waist="Plat. Mog. Belt",
		left_ear="Infused Earring",
		right_ear="Aoidos' Earring",
		left_ring="Chirich Ring",
		right_ring="Chirich Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}

	sets.idle.Refresh = {
		neck = "Elite Royal Collar",
		head = gear.inyanga.head,
		ear1 = "Moonshade Earring",
		ear2 = "Genmei Earring",
		body = gear.inyanga.body,
		hands = "Gende. Gages +1",
		ring1 = "Defending Ring",
		ring2 = "Inyanga Ring",
		legs = gear.inyanga.legs,
		feet = "Fili Cothurnes +2",
	}


	sets.idle.DT = set_combine(sets.idle.Refresh, {
		head = "Nyame Helm",
		neck = "Elite Royal Collar",		
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
	}
)

	sets.idle.DynaRP = set_combine(sets.idle, {
		neck = "Bard's Charm +2",
	})
	
	-- Defense sets

	sets.defense.PDT = sets.idle

	sets.defense.MDT = sets.idle

	sets.Kiting = { feet = "Fili Cothurnes +2"}
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {
		range="Linos",
		head="Aya. Zucchetto +1",
		body="Ashera Harness",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bard's Charm +2",
		waist="Sailfi Belt +1",
		left_ear="Infused Earring",
		right_ear="Fili Earring",
		left_ring="Chirich Ring",
		right_ring="Chirich Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
	}

	sets.Reive = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 2)
end

function user_job_lockstyle()
		windower.chat.input('/lockstyleset 1')
end