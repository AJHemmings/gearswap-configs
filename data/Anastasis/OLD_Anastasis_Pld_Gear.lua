function user_job_setup()
    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal', 'MEva')
	state.WeaponskillMode:options('Match')
	state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('BDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Refresh')
	state.Weapons:options('None', 'Sakpata', 'Burtgang', 'Cleave', 'DPS')
	state.SwampMode = M{['description']='Swamp Settings', 'None', 'Swamp'}
	state.ExtraDefenseMode = M{['description']='Shield','None', 'Aegis', 'Ochain', 'Srivatsa'}
	
	-- Additional local binds
	send_command('bind !f11 gs c toggle ExtraDefenseMode')
	send_command('bind !f12 gs c SwampSwap Engaged')
	send_command('bind f12 gs c SwampSwap Pulling')
	
	select_default_macro_book()
	update_defense_mode()
end

function user_job_self_command(commandArgs, eventArgs)
	local cmd = commandArgs[1];

	if cmd == 'SwampSwap' then
		local mode = commandArgs[2];
		
		windower.add_to_chat(127, 'SwampSwap: Change mode to '..mode)
		
		if mode == 'Pulling' then
			state.Weapons:set('Sakpata')
			state.ExtraDefenseMode:set('Srivatsa')
		elseif mode == 'Engaged' then
			state.Weapons:set('Malevolence')
			state.ExtraDefenseMode:set('Ochain')
		end
	end
end

function job_precast(spell, spellMap, eventArgs)
	refine_cure(spell, spellMap, eventArgs)

	if spell.english == 'Flash' then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		local spell_recasts = windower.ffxi.get_spell_recasts()

		if abil_recasts[80] < latency and not silent_check_amnesia() and spell_recasts[112] < spell_latency and state.AutoEmblem.value then
			eventArgs.cancel = true
			windower.chat.input('/ja "Divine Emblem" <me>')
			windower.chat.input:schedule(1,'/ma "Flash" '..spell.target.raw..'')
		end
	end
end

function job_customize_idle_set(idleSet)
	if state.ExtraDefenseMode.value ~= 'None' then
		idleSet = set_combine(idleSet, sets[state.ExtraDefenseMode.value])
	end

	return idleSet
end

function job_buff_change(buff, gain)
	if buff == "Sleep" then
		if gain then
			send_command('@input /p Slept, please wake.')
		else
			send_command('input /p '..player.name..' is no longer asleep.')
		end
	end
	
	if buff == "petrification" then
		if gain then    
            send_command('@input /p Petrification, please Stona.')		
		else
            send_command('input /p '..player.name..' is no longer petrified, thank you!')
		end
	end
				 
	if buff == "Charm" then
		if gain then  			
            send_command('@input /p Charmed, please sleep me.')		
		else	
			send_command('input /p '..player.name..' is no longer charmed, please wake me up!')
		end
	end
				
	if buff == "paralysis" then
        if gain then           
			send_command('@input /p '..player.name..' Paralysed, please Paralyna.')
        else                        
			send_command('input /p '..player.name..' is no longer paralysed, thank you!')
		end
	end
				
	if buff == "silence" then
		if gain then               
			send_command('@input /p '..player.name..' Silenced, please Silena.')
			send_command('@input /item "Echo Drops" <me>')
		else                        
            send_command('input /p '..player.name..' is no longer silenced, thank you!')
		end
	end
end

function init_gear_sets()
	sets.weapons.Sakpata = { main = "Sakpata's Sword" }
	sets.weapons.Burtgang = { main = "Burtgang" }
	sets.weapons.Cleave = { main = "Malevolence" }
	sets.weapons.DPS = { main = "Naegling" }


	sets.Aegis = { sub = "Aegis" }
	sets.Ochain = { sub = "Ochain" }
	sets.Srivatsa = { sub = "Srivatsa"}

	gear.ambu = {
		tank = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5'}},
		fc = { name="Rudianos's Mantle", augments={'"Fast Cast"+10'}},
		aeolian = { name="Rudianos's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%'}},
		cure = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Phys. dmg. taken-10%'}},
	}
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	sets.Enmity = {
	ammo="Sapience Orb",
    head={ name="Loess Barbuta +1", augments={'Path: A',}},
    body="Caballarius Surcoat",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs="Sakpata's Cuisses",
    feet={ name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Creed Baudrier",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Eihwaz Ring",
    right_ring="Apeile Ring +1",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10',}},
	} -- 133
	
	sets.Enmity.SIRD = set_combine(sets.Enmity, {
        ammo="Staunch Tathlum +1", --11 |
		head="Souv. Schaller +1", --20  |
		body="Yorium Cuirass", --10
        legs="Founder's Hose", --30     |
		--hands="Regal Gauntlets", --10
        feet="Odyssean Greaves", --20   |
		neck="Unmoving collar +1",
		left_ear={name="Tuisto Earring", priority=2},
		right_ear={name="Odnowa Earring +1", priority=3},
		left_ring={name="Moonbeam Ring", bag="wardrobe3", priority=1},
		right_ring={name="Moonbeam Ring", bag="wardrobe4", priority=4},
		waist="Audumbla sash", --10
        back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}) -- 81
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Invincible'] = set_combine(sets.Enmity, {}) -- legs="Cab. Breeches"
	sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, { feet = 'Cab. Leggings +3' })
	sets.precast.JA['Rampart'] = set_combine(sets.Enmity, { head = "Cab. Coronet +2" })
	sets.precast.JA['Fealty'] = set_combine(sets.Enmity, {}) -- body="Cab. Surcoat"
	sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Majesty'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Cover'] = set_combine(sets.Enmity, {}) --head="Rev. Coronet +1",

	-- add mnd for Chivalry
	sets.precast.JA['Chivalry'] = set_combine(sets.Enmity, {})

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, { hands = "Cab. Gauntlets +2" })		
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	-- Fast cast sets for spells
    
	sets.precast.FC = {
		ammo="Sapience Orb", --2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --14
        body="Sakpata's Plate",
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs="Sakpata's Cuisses",
		feet="Carmine Greaves +1", --8
        back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10',}},
        neck="Bathy Choker",
	} -- 62
		
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { })
	sets.precast.FC['Cure IV'] = set_combine(sets.precast.FC, {
		ear2 = "Nourish. Earring +1", -- 4
		neck = "Diemer Gorget", -- 4
	}) -- 66
  
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
        ammo="Coiste Bodhar",
		head="Odyssean helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs={ name="Valorous Hose", augments={'Weapon skill damage +4%','Pet: Haste+2','Accuracy+18 Attack+18','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
        feet="Sulevia's Leggings +2",
        neck="Caro Necklace",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
        back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        waist="Sailfi belt +1",
	}

	sets.precast.WS['Chant du Cygne'] = {
        ammo="Coiste Bodhar",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
        legs="Nyame flanchard",
        feet="Nyame sollerets",
        neck="Caro Necklace",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
		left_ring="Karieyh Ring",
		right_ring="Epaminondas's Ring",
        back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        waist="Sailfi belt +1",
	}

	sets.precast.WS['Aeolian Edge'] = {
		ammo = "Pemphredo Tathlum",
		head = empty,
		neck = "Sibyl Scarf",
		ear1 = "Friomisi Earring",
		ear2 = "Moonshade Earring",
		body = "Cohort Cloak +1",
		hands = "Nyame Gauntlets",
		ring1 = "Metamor. Ring +1",
		ring2 = "Karieyh Ring",
	    back = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10',}},
		waist = "Eschan Stone",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
	}

	-- sets.precast.WS.Atonement = sets.Enmity;
	sets.precast.WS.Atonement = set_combine(sets.Enmity, {})

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = sets.precast.FC
		
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Poisonga = set_combine(sets.Enmity, {})
	sets.midcast.Utsusemi = sets.Enmity.SIRD;
	sets.midcast.Crusade = sets.Enmity.SIRD;
	sets.midcast.Banishga = sets.Enmity.SIRD;
	sets.midcast.Raise = sets.Enmity.SIRD;
	sets.midcast['Blue Magic'] = sets.Enmity;
	sets.midcast['Sheep Song'] = sets.Enmity.SIRD;
	sets.midcast['Geist Wall'] = sets.Enmity.SIRD;
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Protect = set_combine(sets.Enmity.SIRD, { sub = "Priwen" })

	sets.midcast.Cure = set_combine(sets.Enmity, {
		ear1 = 'Nourish. Earring +1',
		ear2 = 'Odnowa Earring +1',
		hands = 'Macabre Gaunt. +1',
		ring1 = "Eihwaz ring",
		back= gear.ambu.cure,
	})

	sets.midcast['Cure IV'] = {
		ammo = "Staunch Tathlum +1",
		head = "Souv. Schaller +1",
		neck = "Unmoving Collar +1",
		ear1 = "Nourish. Earring +1",
		ear2 = { name = "Odnowa earring +1", priority = 3 },
		body = "Souv. Cuirass +1",
		hands = "Macabre Gaunt. +1",
		ring1 = "Defending Ring",
		ring1 = { name = "Gelatinous Ring +1", priority= 4 },
		ring2 = "Apeile Ring +1",
		back= gear.ambu.cure,
		waist = "Audumbla Sash",
		legs = "Founder's Hose",
		feet = "Odyssean Greaves",
	}
	
	sets.midcast.Reprisal = set_combine(sets.Enmity, {
		sub = "Priwen",
		body = "Sacro Breastplate",
		waist = "Sailfi Belt +1"
	})

	sets.Self_Healing = sets.midcast.Cure

	sets.Cure_Received = {}
	sets.Self_Refresh = {
		waist = "Gishdubar Sash",
	}

	sets.midcast['Enhancing Magic'] = {
		neck = "Incanter's Torque",
		ear1 = 'Mimir Earring',
		ear2 = 'Andoaa Earring',
		-- hands = "Regal Gauntlets",
		ring1 = 'Stikini Ring',
		ring2 = 'Stikini Ring',
		waist = 'Olympus Sash',
	}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Phalanx = set_combine(sets.Enmity.SIRD, {
		main = "Sakpata's Sword", -- 5
		sub = "Priwen", -- 2
		ammo = "Staunch Tathlum +1",
		head={ name="Valorous Mask", augments={'"Avatar perpetuation cost" -1','CHR+3','Phalanx +4','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}, -- 4  Odyssean Helm is  +5
		neck = "Unmoving Collar +1",
		ear1 = "Mimir Earring",
		ear2 = { name = "Odnowa Earring +1", priority = 3 },
		body= { name="Yorium Cuirass", augments={'Phalanx +3',}}, --3
		hands = "Souv. Handsch. +1", -- 5
		ring1 = { name = "Gelatinous Ring +1", priority = 2 },
		ring2 = { name = "Moonbeam Ring", priority = 4 },
		back = "Weard Mantle", -- 4
		waist = "Audumbla Sash",
		legs = "Sakpata's Cuisses", -- 5
		feet = "Odyssean Greaves", -- 4                            Souv shoes are +5
	}) -- 34


	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Idle sets

	sets.idle = {
		main = "Burtgang",
		sub = "Ochain",
		ammo = "Eluder's Sachet",
		head = "Sakpata's Helm",
		neck = "Unmoving Collar +1",
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		body = "Sakpata's Plate",
		hands = "Sakpata's Gauntlets",
		ring1 = { name = "Gelatinous Ring +1", priority = 1 },
		ring2 = { name = "Archon Ring", priority = 4 },
		back = gear.ambu.tank,
		waist = "Carrier's Sash",
		legs = "Sakpata's Cuisses",
		feet = "Sakpata's Leggings",
	}

	sets.idle.Refresh = {
		main = "Burtgang",
		ammo = 'Homiliary',
		head = 'Nyame Helm',
		ear1 = 'Tuisto Earring',
		ear2 = 'Odnowa Earring +1',
		body = "Sakpata's Plate",
		hands = 'Nyame Gauntlets',
		ring2 = { name = "Moonbeam Ring", priority = 4 },
		ring1 = { name = "Gelatinous Ring +1", priority = 1 },
		--back = gear.ambu.tank,
		waist = "Creed Baudrier",
		legs = "Sakpata's Cuisses",
		feet = 'Nyame Sollerets',
	}

	sets.Kiting = {legs="Carmine Cuisses +1"} -- 

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
	-- Defense sets
	--------------------------------------
    
	
	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {
		ammo = "Coiste Bodhar",
		head = "Sakpata's Helm",
		neck = "Sanctity Necklace",
		ear1 = 'Telos Earring',
		ear2 = 'Mache Earring +1',
		body = "Hjarrandi Breast.",
		hands = "Sakpata's Gauntlets",
		ring1 = 'Moonbeam Ring',
		ring2 = 'Chirich Ring +1',
		back = gear.ambu.tank,
		waist = 'Sailfi Belt +1',
		legs = "Sakpata's Cuisses",
		feet = "Flam. Gambieras +2",
	}

	sets.engaged.MEva = {
		ammo = "Coiste Bodhar",
		head = "Nyame Helm",
		neck = "Sanctity Necklace",
		ear1 = 'Telos Earring',
		ear2 = 'Crep. Earring',
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = 'Moonbeam Ring',
		ring2 = 'Chirich Ring +1',
		back = gear.ambu.tank,
		waist = 'Sailfi Belt +1',
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
	}
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff.Cover = {}
end

function user_job_lockstyle()
		windower.chat.input('/lockstyleset 6')
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 4)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4) --War/Etc
    end
end

local cure_targets = {
	I   =   150,
	II  =   300,
	III =   500,
	IV  =   700
}
local cure_costs = {
	I   = 8,
	II  = 24,
	III = 46,
	IV  = 88
}

function refine_cure(spell, spellMap, eventArgs)
	if spell.name:startswith('Cure') then
	
			local newCure = spell.english
			
			local missingHP
			local currentHeal = 0
			
			-- If curing ourself, get our exact missing HP
			if spell.target.type == "SELF" then
					missingHP = player.max_hp - player.hp
			-- If curing someone in our alliance, we can estimate their missing HP
			elseif spell.target.isallymember then
					local target = find_player_in_alliance(spell.target.name)
					local est_max_hp = target.hp / (target.hpp/100)
					missingHP = math.floor(est_max_hp - target.hp)
			end

			for level, health in pairs(cure_targets) do
					if missingHP > health and currentHeal < health and player.mp >= cure_costs[level] then
							currentHeal = health
							if level == 'I' then
									newCure = 'Cure'
							else
									newCure = 'Cure '..level
							end
					end
			end

			if newCure ~= spell.english then
					send_command('@input /ma "'..newCure..'" '..tostring(spell.target.raw))
					eventArgs.cancel = true
			else
					if missingHP and missingHP > 0 then
							add_to_chat(122,'Trying to cure '..tostring(missingHP)..' HP using '..newCure..'.')
					end
			end
	end
end