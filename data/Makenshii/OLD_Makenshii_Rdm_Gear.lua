function user_job_setup()
	autows = 'Sanguine Blade'
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Enspell', 'EnspellOnly')
	state.HybridMode:options('Normal')
	state.WeaponskillMode:options('Match','Proc')
	state.AutoBuffMode:options('Off','Auto','AutoMelee')
	state.CastingMode:options('Normal','BowLock')
	state.IdleMode:options('Normal','DynaRP','Refresh')
	state.PhysicalDefenseMode:options('PDT','NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.ExtraMeleeMode = M{['description']='Melee Mode','None', 'BowLock'}
	state.Weapons:options('None', 'SavageSpam', 'SeraphSpam', 'Enspell', 'EnspellCheese', 'Bonk', 'Daggers', 'ProcZeni', 'Trials')
	
		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind !f11 gs c toggle ExtraMeleeMode')
	send_command('sta !packets on')
	
	select_default_macro_book()
end

function file_unload()
	windower.send_command('sta !packets off')
end

function job_customize_idle_set(idleSet)
	if state.ExtraMeleeMode.value == 'BowLock' then
		idleSet = set_combine(idleSet, sets.BowLock)
	end

	return idleSet
end

default_sc_opener = 'Chant Du Cygne'
sc_openers = {
	RNG = 'Realmrazer',
	RNG_AM = 'Chant du Cygne',
	SCH = 'Chant du Cygne',
	COR = 'Chant du Cygne',
}

function user_job_self_command(commandArgs, eventArgs)
	local cmd = commandArgs[1];

	if cmd == 'FullBuff' then
			return send_command('gs c buffup')
	end

	if cmd == 'Rebuff' then
			return send_command('gs c buffup')
	end

	if cmd == 'Debuff' then
			return send_command('exec rdm/debuff.txt')
	end

	if cmd == 'Nuke1' then
		send_command('gs c elemental nuke')
	end

	if cmd == 'OpenSC' then
		if commandArgs[2] and sc_openers[commandArgs[2]] then
			send_command('input /ws "' .. sc_openers[commandArgs[2]] .. '" <t>')
		else
			send_command('input /ws "' .. default_sc_opener .. '" <t>')
		end
	end
end

ambu_cape_name = "Sucellos's Cape"

function init_gear_sets()
	gear.ambu = {
		tp = { name = ambu_cape_name, augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},
		enfeeb = { name = ambu_cape_name, augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%'}}, -- also seraph etc
		savage = { name = ambu_cape_name, augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}},
		ws_int = { name= ambu_cape_name, augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%'}}
	}
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	sets.BowLock = { range = "Ullr Bow", ammo = "Stone Arrow" }
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = { body = 'Viti. Tabard +3' }
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {
		head="Atro. Chapeau +2", --14
		body="Vitiation Tabard +3", --8
		hands="Gende. Gages +1", --7
		legs="Ayanmo Cosciales +2", --6
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+29','Magic Damage +3','MND+7','Mag. Acc.+14',}}, --5
		neck="Loricate Torque +1",
		waist="Embla Sash", --5
		ear1 = "Malignance Earring",
		ear2 ="Lethargy Earring", --7
		ring1="Prolix Ring", --2
		ring2="Stikini Ring +1",
		back="Solemnity Cape",
	} -- 38 + 46 = 84 (80)
		
	sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
		head = 'Leth. Chappel +1',
	})
	sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty, body = "Twilight Cloak" })
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = 'Daybreak', sub = 'Genmei Shield' })
       
	-- Weaponskill sets
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Chant Du Cygne'] = {
		ammo="Oshasha's Treatise",
		neck = 'Fotia Gorget',
		ear1 = 'Sherida Earring',
		hands = 'Malignance Gloves',
		ring1 = 'Begrudging Ring',
		waist = 'Fotia Belt',
		feet = 'Thereoid Greaves',
	}
		
	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant Du Cygne']

	sets.precast.WS['Savage Blade'] = {
		ammo="Oshasha's Treatise",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Viti. Tabard +3",
		hands="Atrophy Gloves +3",
		legs="Jhakri Slops +1",
		feet="Leth. Houseaux +2",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		ear1="Ishvara Earring",
		ear2={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		ring1="Rufescent Ring",
		ring2="Strendu Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Circle Blade'] = sets.precast.WS['Savage Blade']

	sets.precast.WS['Requiescat'] = {
		ammo="Oshasha's Treatise",
		head = "Viti. Chapeau +3",
		neck = "Fotia Gorget",
		ear1 = "Malignance Earring",
		ear2 = "Moonshade Earring",
		body = "Viti. Tabard +3",
		hands = "Viti. Gloves +3",
		ring1 = "Metamor. Ring +1",
		ring2 = "Epona's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},
		waist = "Fotia Belt",
		legs = "Nyame Flanchard",
		feet="Leth. Houseaux +2",
	}

	sets.precast.WS['Empyreal Arrow'] = set_combine(sets.precast.WS, {
		ammo = "Stone Arrow",
		head = "Malignance Chapeau",
		ear2 = "Telos Earring",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		feet = "Malignance Boots",
	})

	sets.precast.WS['Sanguine Blade'] = {
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet="Vitiation Boots +3",
        neck="Sibyl Scarf",
        waist="Refoccilation Stone",
        ear1="Malignance Earring",
        ear2="Friomisi Earring",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
		
	sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Sanguine Blade'], {
		ammo="Pemphredo Tathlum",
		ear2 = "Moonshade Earring",
		head = empty,
		body = "Cohort Cloak +1",
		ring1 = "Freke Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},
	});

	
	sets.precast.WS['Aeolian Edge'] = {
		ammo = 'Pemphredo Tathlum',
		head = empty,
		neck = "Sibyl Scarf",
		ear1 = "Malignance Earring",
		ear2 = "Moonshade Earring",
		body = "Cohort Cloak +1",
		hands = gear.jhakri.hands,
		ring1 = "Freke Ring",
		ring2 = 'Karieyh Ring +1',
		back = gear.ambu.ws_int,
		waist = 'Eschan Stone',
		legs = "Nyame Flanchard",
		feet = "Amalric Nails +1",
	};
	sets.precast.WS['Red Lotus Blade'] = sets.precast.WS['Aeolian Edge']

	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {

		ammo = "Per. Lucky Egg",
		legs={ name="Merlinic Shalwar", augments={'Pet: "Mag.Atk.Bns."+11','Pet: DEX+10','"Treasure Hunter"+1','Accuracy+14 Attack+14','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		
	})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst = {
		head = "Bunzi's Hat", -- 7
		body = "Bunzi's Robe", -- 10
		hands = "Bunzi's Gloves", -- 8
		ring1 = "Mujin Band", -- 0/5
		legs = "Bunzi's Pants", -- 9
		feet = "Bunzi's Sabots",
	} -- 39/5
	
	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast.Cure = {
		main="Daybreak",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -3%',}},
		ammo="Hydrocera",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body="Vitiation Tabard +3",
		hands="Gende. Gages +1",
		legs="Warlock's Tights",
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+29','Magic Damage +3','MND+7','Mag. Acc.+14',}},
		neck="Imbodla Necklace",
		waist="Rumination Sash",
		ear1="Mendi. Earring",
		ear2="Snotra Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Solemnity Cape",
	}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {
		head = 'Vanya Hood',
		body = 'Viti. Tabard +3',
	})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = set_combine(sets.midcast.Cure, {
		waist = "Gishdubar Sash"
	})
	sets.Cure_Received = {
		waist = "Gishdubar Sash"
	}
	sets.Self_Refresh = {
		waist = "Gishdubar Sash"
	}

	sets.midcast['Enhancing Magic'] = {
		main = 'Pukulatmuj +1',
		sub = 'Ammurapi Shield',
		ammo = 'Pemphredo Tathlum',
		head="Befouled Crown",
		body="Vitiation Tabard +3",
		hands="Chironic Gloves",
		legs="Portent Pants",
		feet="Leth. Houseaux +2",
		neck="Enhancing Torque",
		waist="Embla Sash",
		ear1="Mendi. Earring",
		ear2="Loquac. Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Ghostfyre Cape",
	}

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = set_combine(sets.midcast['Enhancing Magic'], {
		head = 'Leth. Chappel +1',
		neck = 'Dls. Torque +2',
		body = 'Lethargy Sayon +2',
		legs = 'Leth. Fuseau +1 +1',
		feet = 'Leth. Houseaux +2',
	})
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = {
		main ="Pukulatmuj +1",
		sub ="Ammurapi Shield",
		ammo="Hydrocera",
		head="Befouled Crown",
		body="Vitiation Tabard +3",
		hands="Chironic Gloves",
		legs="Portent Pants",
		feet ="Leth. Houseaux +2",
		neck="Enhancing Torque",
		waist="Salire Belt",
		ear1="Mendi. Earring",
		ear2="Loquac. Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Ghostfyre Cape",
	}

	sets.midcast.Refresh = {
		body = 'Atrophy Tabard +3',
		legs = 'Leth. Fuseau +1',
	}

	sets.midcast.Aquaveil = {}
	sets.midcast.BarElement = {}
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Enspell = sets.midcast.Temper
	sets.midcast.BoostStat = {}
	sets.midcast.Stoneskin = {}
	sets.midcast.Protect = {}
	sets.midcast.Shell = {}
	sets.midcast.Phalanx = {
		main = "Sakpata's Sword",
		neck = "Enhancing Torque",
		head = { name="Chironic Hat", augments={'"Cure" spellcasting time -3%','Rng.Acc.+10 Rng.Atk.+10','Phalanx +3','Accuracy+19 Attack+19','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
		body = "Merlinic Jubbah",
		hands={ name="Chironic Gloves", augments={'AGI+3','Rng.Atk.+21','Phalanx +3','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		legs = "Taeon Tights",
	}
	
	-- Base set is potency+
	sets.midcast['Enfeebling Magic'] = {
		main = "Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphreddo Tathlum",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body = 'Lethargy Sayon +2',
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+26','"Cure" spellcasting time -11%','MND+7',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Rumination Sash",
		ear1 ="Malignance Earring",
		ear2 ="Snotra Earring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},
	}
	
	-- Frazzle2 cast in high acc to make it stick
	sets.midcast['Frazzle II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		body = "Atrophy Tabard +3",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},
	})
	sets.midcast.Dispel = sets.midcast['Enfeebling Magic']

	gear.frazDistractPot = {
		ear1 = "Vor Earring",
		hands = "Leth. Gantherots +2",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		waist = "Rumination Sash",
		legs = "Psycloth Lappas",
	}

	-- less MND and Skill, more Duration+
	sets.midcast.DurationOnlyEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {
		main = "Crocea Mors",
		range = "Ullr Bow",
		body = 'Atrophy Tabard +3',
		waist = "Obstin. Sash",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20',}},
	})
		
	sets.midcast.Silence = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Sleep = set_combine(sets.midcast.DurationOnlyEnfeebling, {})
	sets.midcast.Bind = set_combine(sets.midcast.DurationOnlyEnfeebling,{})
	sets.midcast.Break = set_combine(sets.midcast.DurationOnlyEnfeebling,{})
	
	-- Skill-based have variable potency based on skill
	
	sets.midcast.SkillBasedEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {
	})
	

	sets.midcast['Frazzle III'] = set_combine(sets.midcast.SkillBasedEnfeebling, gear.frazDistractPot)
	sets.midcast['Distract III'] = set_combine(sets.midcast.SkillBasedEnfeebling, gear.frazDistractPot)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	gear.diaDuration = {
		head = "Leth. Chappel +1",
		neck = "Dls. Torque +2",
		ear2 = "Snotra Earring",
		body = "Lethargy Sayon +2",
		hands = "Leth. Gantherots +2",
		ring1 = "Kishar Ring",
		wiast = "Obstin. Sash",
		legs = "Leth. Fuseau +1",
		feet = "Leth. Houseaux +2",
	}

	sets.midcast.Dia = set_combine(gear.diaDuration, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(gear.diaDuration, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(gear.diaDuration, sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(gear.diaDuration, {})
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast['Elemental Magic'] = {
		main = "Bunzi's Rod",
		sub = 'Ammurapi Shield',
		ammo = 'Pemphredo Tathlum',
		head = "Bunzi's Hat",
		neck = "Sibyl Scarf",
		ear1 = 'Malignance Earring',
		ear2 = 'Friomisi Earring',
		body = "Bunzi's Robe",
		hands = "Jhakri Cuffs +1",
		ring1 = "Metamor. Ring +1",
		ring2 = "Jhakri Ring +1",
		waist = "Refoccilation Stone",
		legs = "Amalric Slops +1",
		feet = "Vitiation Boots +3",
	}

	sets.midcast.Impact = set_combine(sets.midcast.DurationOnlyEnfeebling, { head = empty, body = "Twilight Cloak" })

	sets.midcast['Dark Magic'] = {}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main = "Rubicundity",
		head = "Pixie Hairpin +1",
		neck = "Erra Pendant",
		ear1 = "Malignance Earring",
		ear2 = "Loquac. Earring",
		ring1 = "Evanescence Ring",
		ring2 = "Archon Ring",
		back = "Aurist's Cape +1",
		waist = "Fucho-no-Obi",
	})

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = sets.midcast['Frazzle II']
		
	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {
		hands = 'Leth. Gantherots +2',
	}

	sets.HPCure = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	sets.idle = {
		ammo="Amar Cluster",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs={ name="Merlinic Shalwar", augments={'Phys. dmg. taken -2%','Accuracy+3','"Refresh"+2',}},
		feet={ name="Chironic Slippers", augments={'Pet: Attack+17 Pet: Rng.Atk.+17','Enmity-1','"Refresh"+2','Accuracy+4 Attack+4',}},
		neck="Elite Royal Collar",
		waist="Fucho-no-Obi",
		ear1="Infused Earring",
		ear2="Odnowa Earring +1",
		ring1 ="Defending Ring",
		ring2="Warden's Ring",
		back="Solemnity Cape",
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {
		main = 'Daybreak',
		ammo = 'Homiliary',
		body="Jhakri Robe +2",
		legs={ name="Merlinic Shalwar", augments={'Phys. dmg. taken -2%','Accuracy+3','"Refresh"+2',}},
		feet={ name="Chironic Slippers", augments={'Pet: Attack+17 Pet: Rng.Atk.+17','Enmity-1','"Refresh"+2','Accuracy+4 Attack+4',}},

	})

	sets.idle.DT = set_combine(sets.idle, {
	})

	sets.idle.DynaRP = set_combine(sets.idle, {
		neck = 'Dls. Torque +2',
		main = 'Crocea Mors',
	})

	sets.Kiting = {legs = 'Blood Cuisses'}
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets
	sets.weapons.Trials = { main = '', sub = 'Crocea Mors' }
	sets.weapons.SavageSpam = { main = 'Naegling', sub = 'Machaera +2' }
	sets.weapons.SeraphSpam = { main = 'Crocea Mors', sub = 'Daybreak' }
	sets.weapons.Enspell = { main = 'Crocea Mors', sub = 'Tauret' }  -- Crepuscular Knife
	sets.weapons.EnspellCheese = { main = 'Wind Knife', sub = 'Wind Knife' }
	sets.weapons.Bonk = { main = 'Maxentius', sub = 'Tauret', ammo = "Coiste Bodhar" }
	sets.weapons.Daggers = { main = 'Malevolence', sub = "Bunzi's Rod", ammo = "Coiste Bodhar" }
	sets.weapons.ProcZeni = { main = 'Wind Knife', sub = "Wind Knife", range = "Soultrapper 2000", ammo = "Blank Soulplate" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.Dagger.Accuracy.Evasion
	
	sets.engaged = {
		main = "Naegling",
		head = 'Malignance Chapeau',
		neck = 'Anu Torque',
		body = 'Malignance Tabard',
		hands = 'Malignance Gloves',
		ring1 = 'Chirich Ring',
		ring2 = 'Chirich Ring',
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},
		waist = 'Grunfeld Rope',
		legs = 'Malignance Tights',
		feet = 'Malignance Boots',
		ear1 = 'Sherida Earring',
		ear2 = 'Mache earring +1',
	}
	--sets.engaged = {
	--	ammo = 'Coiste Bodhar',
	--	head = 'Malignance Chapeau',
	--	neck = 'Anu Torque',
	--	ear1 = 'Sherida Earring',
	--	ear2 = 'Dedition Earring',
	--	body = 'Malignance Tabard',
	--	hands = 'Malignance Gloves',
	--	ring1 = 'Petrov Ring',
	--	ring2 = 'Chirich Ring +1',
	--	back = gear.ambu.tp,
	--	waist = 'Windbuffet Belt +1',
	--	legs = 'Malignance Tights',
	--	feet = 'Malignance Boots',
	--}
	
	sets.engaged.DW = set_combine(sets.engaged, {
	})

	sets.engaged.DW.Enspell = set_combine(sets.engaged, {
		ammo = "Sroda Tathlum",
		head = "Umuthi Hat",
		hands = "Aya. Manopolas +2",
		waist = "Hachirin-no-Obi",
	})

	sets.engaged.DW.EnspellOnly = set_combine(sets.engaged.DW, {
		head = "Umuthi Hat",
		neck = "Dls. Torque +2",
		ring1 = "Stikini Ring",
		waist = "Hachirin-no-Obi",
		legs = "Aya. Cosciales +2",
	})
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 1)
	else
		set_macro_page(1, 1)
	end
end

function user_job_buff_change(buff, gain)
	if buff:startswith('Addendum: ') or buff:endswith(' Arts') then
		style_lock = true
	end
end

function user_job_lockstyle()
		windower.chat.input('/lockstyleset 5')
end
