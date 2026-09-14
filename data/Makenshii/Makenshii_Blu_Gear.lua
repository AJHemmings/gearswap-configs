function user_job_setup()
	-- Options: Override default values
	autows = 'Savage Blade'
		
	state.OffenseMode:options('Normal','FullAcc')
	state.HybridMode:options('Normal','DT')
	state.WeaponskillMode:options('Match', 'AtkCapped')
	state.CastingMode:options('Normal','Resistant')
	state.IdleMode:options('Normal','PDT','AzureAilments')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('SlashNormal', 'SlashAcc', 'BluntNormal', 'BluntAcc', 'Nuking', 'NukingDT', 'LowDmg', 'Tizona')

	-- Additional local binds
	send_command('bind !` input /ja "Burst Affinity" <me>')

	select_default_macro_book()
end

function user_job_self_command(commandArgs, eventArgs)
	local cmd = commandArgs[1];

	if cmd == 'FullBuff' then
			windower.add_to_chat(127, 'Performing full buff...')
			return send_command('exec blu/FullBuff.txt')
	end

	if cmd == 'Rebuff' then
			windower.add_to_chat(127, 'Performing full buff...')
			return send_command('exec blu/FullBuff.txt')
	end

	if cmd == 'CrowdControl' then
		return send_command('input /ma "Dream Flower" <t>')
	end
end

function user_job_lockstyle()
		windower.chat.input('/lockstyleset 4')
end

function init_gear_sets()

		-- Weapons sets
		sets.weapons.SlashNormal = {main="Naegling",sub="Thibron"}
		sets.weapons.SlashAcc = {main="Naegling",sub="Sakpata's Sword"}
		sets.weapons.BluntNormal = {main="Maxentius",sub="Thibron"}
		sets.weapons.BluntAcc = {main="Maxentius",sub="Sakpata's Sword"}
		sets.weapons.Nuking = {main="Maxentius",sub="Bunzi's Rod"}
		sets.weapons.NukingDT = {main="Bunzi's Rod",sub="Sakpata's Sword"}
		sets.weapons.LowDmg = {main="Ibushi Shinai",sub="Ash Club"}
		sets.weapons.Tizona = {main="Tizona",sub="Thibron"}
	--------------------------------------
	-- Start defining the sets
	--------------------------------------    

	gear.ambuWSD = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%', 'STR+10'}}
	gear.ambuTP =  { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}

	sets.buff['Burst Affinity'] = {} 
	sets.buff['Chain Affinity'] = {feet="Assim. Charuqs +2"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
	sets.buff.Efflux = {} --legs="Hashishin Tayt +1"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {} -- hands="Luh. Bazubands +1"


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		ammo = "Crepuscular Pebble",
		head = "Nyame Helm",
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		body = "Gleti's Cuirass",
		hands = "Nyame Gauntlets",
		ring1 = "Supershear Ring",
		ring2 = "Metamor. Ring +1",
		back = "Swith Cape",
		waist = "Chaac Belt",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
	}
	
	-- Fast cast sets for spells

	sets.precast.FC = {
		ammo="Amar Cluster",
		head={ name="Herculean Helm", augments={'"Triple Atk."+4','STR+10','Attack+12',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+9','"Fast Cast"+2',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+1','Mag. Acc.+5','"Mag.Atk.Bns."+5','"Fast Cast"+1',}},
		legs="Aya. Cosciales +2",
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck="Twilight Torque",
		waist="Rumination Sash",
		left_ear="Loquac. Earring",
		right_ear="Ethereal Earring",
		left_ring="Prolix Ring",
		right_ring="Stikini Ring +1",
		back="Swith Cape",
	} 

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {
		body = "Hashishin Mintan +1", -- 14 (5)
	}) -- 60


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo = "Coiste Bodhar",
		head = gear.herculean_ws_head,
		neck = "Rep. Plat. Medal",
		ear1 = "Moonshade Earring",
		ear2 = "Ishvara Earring",
		body = "Nyame Mail",
		hands = gear.jhakri.hands,
		ring1 = "Karieyh Ring +1",
		ring2 = "Shukuyu Ring",
		back = gear.ambuWSD,
		waist = "Sailfi Belt +1",
		legs = "Nyame Flanchard",
		feet = gear.herculean_wsd_feet,
	}
	
	sets.precast.WS.AtkCapped = set_combine(sets.precast.WS, {
		body = "Gleti's Cuirass",
		legs = "Gleti's Breeches",
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {
		ammo = "Hydrocera",
		head = gear.jhakri.head,
		neck = "Fotia Gorget",
		left_ear = "Moonshade Earring",
		right_ear = "Brutal Earring",
		body = gear.jhakri.body,
		hands = gear.jhakri.hands,
		ring2 = "Metamor. Ring +1",
		ring1 = "Epona's Ring",
		waist = "Fotia Belt",
		legs= gear.jhakri.legs,
		feet = gear.jhakri.feet,
	}

	sets.precast.WS['Savage Blade'] ={}

	sets.precast.WS['Chant du Cygne'] = {
		ammo = "Jukukik Feather",
		head = "Adhemar Bonnet +1",
		neck = "Mirage Stole +1",
		left_ear = "Odr Earring",
		body = "Gleti's Cuirass",
		hands = "Adhemar Wrist. +1",
		ring1 = "Epona's Ring",
		ring2 = "Begrudging Ring",
		waist = "Fotia Belt",
		legs = "Gleti's Breeches",
		feet = "Thereoid Greaves",
	}

	sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.Requiescat, {
		head = "Pixie Hairpin +1",
		neck = "Sibyl Scarf",
		ear1 = "Friomisi Earring",
		ear2 = "Novio Earring",
		body = gear.jhakri.body,
		ring1 = "Karieyh Ring +1",
		ring2 = "Archon Ring",
		waist = "Eschan Stone",
		legs = "Nyame Flanchard",
		feet = "Amalric Nails +1",
	})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring", ear2="Brutal Earring"}
	sets.AccMaxTP = {}

	-- Midcast Sets
	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast['Blue Magic'] = {
		ammo = "Falcon Eye",
		head = "Malignance Chapeau",
		neck = "Mirage Stole +1",
		ear1 = "Telos Earring",
		ear2 = "Odr Earring",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Eschan Stone",
		legs = gear.jhakri.legs,
		feet = "Malignance Boots",
	}

	-- Physical Spells --

	sets.midcast['Blue Magic'].Physical = set_combine(sets.midcast['Blue Magic'], {
		ring1 = "Shukuyu Ring",
	})

	-- Magical Spells --

	sets.midcast['Blue Magic'].Magical = {
		ammo = "Pemphredo Tathlum",
		head = empty,
		neck = "Sibyl Scarf",
		ear1 = "Friomisi Earring",
		ear2 = "Malignance Earring",
		body = "Cohort Cloak +1",
		hands = "Amalric Gages +1",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Toro Cape",
		waist = "Eschan Stone",
		legs = "Amalric Slops +1",
		feet = "Nyame Sollerets",
	}
					 
	sets.midcast['Enfeebling Magic'] = sets.midcast['Blue Magic']
	sets.midcast['Dark Magic'] = sets.midcast['Blue Magic']

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast['Blue Magic'], {
		ear1 = 'Mimir Earring',
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
	})
		
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		main = "Sakpata's Sword",
		sub = "Pukulatmuj +1",
		body = gear.taeon_phalanx_body,
		hands = gear.herculean_phalanx_hands,
		legs = gear.taeon_phalanx_legs,
		feet = "Taeon Boots",
	})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		waist = "Gishdubar Sash",
	})

	sets.element.Dark = {head = "Pixie Hairpin +1", ring2="Archon Ring"}

	sets.midcast.Cure = {
		head = "Telchine Cap",
		legs = "Telchine Braconi",
	}

	-- Physical Added Effect Spells most notably "Stun" spells --
	-- -- Never casting physical magic for the damage so just use that
	sets.midcast['Blue Magic'].Stun = sets.midcast['Blue Magic'].Physical

	-- Other Specific Spells --
	sets.midcast['Blue Magic'].Healing = {
		head = "Telchine Cap",
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		waist = "Gishdubar Sash",
		legs = "Telchine Braconi",
	}

	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {}

	sets.midcast['Blue Magic'].SkillBasedBuff = {
		-- head = "Mirage Keffiyeh",
		neck = "Mirage Stole +1",
		body = "Assim. Jubbah +2",
		-- hands = "Hashi. Bazu. +1",
		-- legs = "Hashishin Tayt +1",
		back = "Cornflower Cape",
		feet = "Luhlaza Charuqs",
	}

	-- Sets to return to when not performing an action.

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {}

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {
		ammo = "Staunch Tathlum +1",
		head = "Rawhide Mask",
		neck = "Bathy Choker +1",
		ear1 = "Etiolation Earring",
		ear2 = "Infused Earring",
		body = gear.jhakri.body,
		hands = "Malignance Gloves",
		ring1 = 'Defending Ring',
		ring2 = "Warden's Ring",
		back = 'Solemnity Cape',
		waist = "Fucho-no-Obi",
		legs = 'Carmine Cuisses +1',
		feet = "Nyame Sollerets",
	}
	
	sets.idle.PDT = set_combine(sets.idle, {
		head = "Malignance Chapeau",
		neck = "Loricate Torque +1",
		body = "Gleti's Cuirass",
		hands = "Malignance Gloves",
		back = 'Solemnity Cape',
	})

	sets.idle.AzureAilments = {
		main = "Sakpata's Sword",
		sub = "Bunzi's Rod",
		ammo = "Crepuscular Pebble",
		head = empty,
		neck = "Loricate Torque +1",
		ear1 = "Odnowa Earring +1",
		ear2 = "Ethereal Earring",
		body = empty,
		hands = empty,
		ring1 = "Defending Ring",
		ring2 = "Warden's Ring",
		back = "Solemnity Cape",
		waist = "Tempus Fugit",
		legs = empty,
		feet = empty,
	}

	-- Defense sets
	sets.defense.PDT = sets.idle.PDT

	sets.defense.MDT = sets.idle.PDT

	sets.defense.MEVA = sets.idle.PDT

	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = { legs = "Blood Cuisses"}

	-- Engaged sets
	sets.engaged = {
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1",
		neck = "Mirage Stole +1",
		ear1 = "Suppanomimi",
		ear2 = "Dedition Earring",
		body = "Malignance Tabard",
		hands = 'Adhemar Wrist. +1',
		ring1 = "Petrov Ring",
		ring2 = "Epona's Ring",
		back = gear.ambuTP,
		waist = "Windbuffet Belt +1",
		legs = 'Samnuha Tights',
		feet = gear.herculean_ta_feet,
	}
	
	gear.DTSwaps = {
		ear1 = "Telos Earring",
		head = "Malignance Chapeau",
		ring1 = 'Defending Ring',
		hands = "Malignance Gloves",
		feet = "Malignance Boots",
	}

	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
		ammo = "Falcon Eye",
		head = "Malignance Chapeau",
		ear2 = "Telos Earring",
		hands = "Malignance Gloves",
		feet = "Malignance Boots",
	});
	
	sets.engaged.DT = set_combine(sets.engaged, gear.DTSwaps)
	sets.engaged.FullAcc.DT = set_combine(sets.engaged.FullAcc, gear.DTSwaps)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(10, 9)
	elseif player.sub_job == 'NIN' then
		set_macro_page(10, 9)
	elseif player.sub_job == 'WAR' then
		set_macro_page(10, 9)
	elseif player.sub_job == 'RUN' then
		set_macro_page(10, 9)
	elseif player.sub_job == 'THF' then
		set_macro_page(10, 9)
	elseif player.sub_job == 'RDM' then
		set_macro_page(10, 9)
	else
		set_macro_page(10, 9)
	end
end

function user_job_lockstyle()
		windower.chat.input('/lockstyleset 4')
end