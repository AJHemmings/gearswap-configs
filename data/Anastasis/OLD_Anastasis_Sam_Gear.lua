-- Setup vars that are user-dependent.
function user_job_setup()
    autows = 'Tachi: Fudo'
    autofood = 'Carbonara'

    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','MAXAcc','SubtleBlow')
    state.HybridMode:options('Normal','DTLite')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
    state.RangedMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'DynaRP')
	state.Weapons:options('None', 'Masamune', 'Doji', 'Piercing','ProcWeapon','Bow','MultiStep')

	gear.ws_jse_back = {name="Smertrios's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+9', 'Weapon skill damage +10%',}}
	--gear.stp_jse_back = {name="Smertrios's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%'}}
 
    -- Additional local binds
	send_command('bind !@^` gs c cycle Stance')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +2",hands="Sakonji Kote +1",back=gear.ws_jse_back}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +2"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}
	-- sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +1"}
	
    sets.precast.Step = {}
    sets.precast.JA['Violent Flourish'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ear1 = 'Etiolation Earring',
        ear2 = 'Loquac. Earring',
        hands = 'Leyline Gloves',
        ammo = 'Sapience Orb',
        ring1 = 'Prolix Ring',
    }
	   
    -- Ranged snapshot gear
    -- sets.precast.RA = {
    --     head = gear.acro_rng_head,
    --     body = gear.acro_rng_body,
    --     hands = gear.acro_rng_hands,
    --     legs = gear.acro_rng_legs,
    --     feet = gear.acro_rng_feet,
    -- }
	   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body="Sakonji Domaru +3",
        hands = "Nyame Gauntlets",
        legs="Wakido Haidate +3",
        feet="Nyame Sollerets",
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Thrud Earring",
        ear2={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
        left_ring="Cornelia's Ring",
        right_ring="Epaminondas's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body="Sakonji Domaru +3",
        hands = "Nyame Gauntlets",
        legs="Wakido Haidate +3",
        feet="Nyame Sollerets",
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Thrud Earring",
        ear2={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
        left_ring="Cornelia's Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    })
	
    sets.precast.WS['Tachi: Kasha'] = sets.precast.WS['Tachi: Fudo']
    sets.precast.WS['Tachi: Gekko'] = sets.precast.WS['Tachi: Fudo']
    sets.precast.WS['Tachi: Yukikaze'] = sets.precast.WS['Tachi: Fudo']
    sets.precast.WS['Tachi: Rana'] = sets.precast.WS['Tachi: Fudo']
    sets.precast.WS['Impulse Drive'] = sets.precast.WS['Tachi: Fudo']
    sets.precast.WS['Sonic Thrust'] = sets.precast.WS['Tachi: Fudo']

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body="Sakonji Domaru +3",
        hands = "Nyame Gauntlets",
        legs="Wakido Haidate +3",
        feet="Nyame Sollerets",
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Thrud Earring",
        ear2={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
        left_ring="Niqmaddu Ring",
        right_ring="Cornelia's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
        head="Mpaca's Cap",
        body="Flamma Korazin +2",
        hands="Nyame Gauntlets",
        legs={ name="Valorous Hose", augments={'Accuracy+23 Attack+23','Weapon Skill Acc.+14','CHR+7','Accuracy+2',}},
        feet="Flam. Gambieras +2",
        neck="Sanctity Necklace",
        waist={ name="Sailfi Belt +1 +1", augments={'Path: A',}},
        ear1={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
        ear2="Thrud Earring",
        left_ring="Karieyh Ring",
        right_ring={ name="Beithir Ring", augments={'Path: A',}},
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    })
		
    
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
        ammo = "Knobkierrie",
        head = "Nyame Helm",
        neck = "Sam. Nodowa +2",
        ear1 = "Friomisi Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Cornelia's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        waist = "Sailfi Belt +1 +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
    })

    sets.precast.WS['Tachi: Hobaku'] = sets.precast.WS['Tachi: Jinpu']
    sets.precast.WS['Tachi: Koki'] = sets.precast.WS['Tachi: Jinpu']

    sets.precast.WS['Apex Arrow'] = {
        feet = 'Wakido Sune. +2',
    }
    sets.precast.WS['Empyrean Arrow'] = {
        feet = 'Wakido Sune. +2',
    }

    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        ammo = "Knobkierrie",
        head = "Mpaca's Cap",
        neck = "Sam. Nodowa +2",
        ear1 = "Schere Earring",
        ear2 = "Moonshade Earring",
        body = "Sakonji Domaru +3",
        hands = "Valorous Mitts",
        ring1 = "Regal Ring",
        ring2 = "Niqmaddu Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        waist = "Fotia Belt",
        legs = "Wakido Haidate +3",
        feet = "Valorous Greaves",
    })

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.AccMaxTP = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.AccDayMaxTPWSEars = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.DayMaxTPWSEars = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.AccDayWSEars = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.DayWSEars = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	
    -- Midcast Sets
    --sets.midcast.FastRecast = sets.precast.FC
		
    -- Specific spells
    --sets.midcast.Utsusemi = sets.precast.FC
	
		
    -- Ranged gear
    sets.midcast.RA = {
        ear1 = 'Telos Earring',
        neck = 'Sam. Nodowa +1',
        hands = "Kasuga Kote +1",
        legs = 'Wakido Haidate +3',
        feet = 'Wakido Sune. +2',
        ring1 = 'Cacoethic Ring +1',
        ring2 = "Regal Ring",
    }

    sets.midcast.RA.Acc = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	sets.Kiting = {}
    sets.Reraise = {}
	sets.Skillchain = {}
	
    sets.idle = {
        ammo="Staunch Tathlum +1",
        head={ name="Loess Barbuta +1", augments={'Path: A',}},
        body="Kasuga Domaru +2",
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs="Kasuga Haidate +2",
        feet="Danzo Sune-Ate",
        neck="Elite Royal Collar",
        waist="Plat. Mog. Belt",
        left_ear="Hearty Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Chirich Ring +1",
        right_ring="Karieyh Ring",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.idle.DynaRP = set_combine(sets.idle, {
        neck = "Sam. Nodowa +2",
    })

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
    ammo="Coiste Bodhar",
    head="Flam. Zucchetto +2",
    body="Kasuga Domaru +2",
    hands="Wakido Kote +3",
    legs="Kasuga Haidate +2",
    feet={ name="Ryuo Sune-Ate +1", augments={'STR+12','DEX+12','Accuracy+20',}},
    neck="Sam. Nodowa +2",
    waist="Ioskeha Belt +1",
	ear1="Schere Earring",
    ear2="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Chirich Ring +1",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.engaged.SomeAcc = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body="Kasuga Domaru +2",
        hands="Wakido Kote +3",
        legs="Kasuga Haidate +2",
        feet={ name="Ryuo Sune-Ate +1", augments={'STR+12','DEX+12','Accuracy+20',}},
        neck="Sam. Nodowa +2",
        waist="Ioskeha Belt +1",
        ear1="Schere Earring",
        ear2="Telos Earring",
        left_ring="Regal Ring",
        right_ring="Chirich Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.engaged.Acc = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body="Kasuga Domaru +2",
        hands="Wakido Kote +3",
        legs="Kasuga Haidate +2",
        feet={ name="Ryuo Sune-Ate +1", augments={'STR+12','DEX+12','Accuracy+20',}},
        neck="Sam. Nodowa +2",
        waist="Ioskeha Belt +1",
        ear1="Schere Earring",
        ear2="Telos Earring",
        left_ring="Regal Ring",
        right_ring="Chirich Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.engaged.FullAcc = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body="Ken. Samue +1",
        hands="Wakido Kote +3",
        legs="Kasuga Haidate +2",
        feet={ name="Ryuo Sune-Ate +1", augments={'STR+12','DEX+12','Accuracy+20',}},
        neck="Sam. Nodowa +2",
        waist="Ioskeha Belt +1",
        ear1="Mache Earring +1",
        ear2="Telos Earring",
        left_ring="Regal Ring",
        right_ring="Chirich Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.engaged.MAXAcc = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body="Kasuga Domaru +2",
        hands="Wakido Kote +3",
        legs="Kasuga Haidate +2",
        feet={ name="Ryuo Sune-Ate +1", augments={'STR+12','DEX+12','Accuracy+20',}},
        neck="Sam. Nodowa +2",
        waist="Ioskeha Belt +1",
        ear1="Schere Earring",
        ear2="Telos Earring",
        left_ring="Regal Ring",
        right_ring="Chirich Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.engaged.SubtleBlow = {
        head = "Flam. Zucchetto +2",
        neck = "Bathy Choker",
        ear1 = "Telos Earring",
        ear2 = "Schere Earring",         --Dedition Earring
        body = "Flamma Korazin +2",           --Dagon Breast.
        hands = "Wakido Kote +3",
        ring1 = "Niqmaddu Ring",
        ring2 = "Chirich Ring +1",
        back = gear.stp_jse_back,
        legs = "Mpaca's Hose",
        waist = "Sailfi Belt +1 +1",
        feet = "Ryuo Sune-ate +1",
    }

	sets.engaged.DTLite = set_combine(sets.engaged, {
        ammo="Staunch Tathlum +1",
        head="Nyame Helm",
        body="Kasuga Domaru +2",
        hands="Wakido Kote +3",
        legs="Kasuga Haidate +2",
        feet="Nyame Sollerets",
        neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
        waist="Ioskeha Belt +1",
        left_ear={ name="Schere Earring", augments={'Path: A',}},
        right_ear="Telos Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Chirich Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    })
    sets.engaged.SomeAcc.DTLite = set_combine(sets.engaged.SomeAcc, {
        ear2 = "Odnowa Earring +1",
        body = "Wakido Domaru +3",
        ring2 = "Defending Ring",
    })		
    sets.engaged.Acc.DTLite = set_combine(sets.engaged.Acc, {
        ear2 = "Odnowa Earring +1",
        body = "Wakido Domaru +3",
        ring2 = "Defending Ring",
    })		
    sets.engaged.FullAcc.DTLite = set_combine(sets.engaged.FullAcc, {
        ear2 = "Odnowa Earring +1",
        body = "Wakido Domaru +3",
        ring2 = "Defending Ring",
    })		
    sets.engaged.MAXAcc.DTLite = set_combine(sets.engaged.MAXAcc, {
        ear2 = "Odnowa Earring +1",
        body = 'Wakido Domaru +3',
        ring1 = 'Defending Ring',
    })
    sets.engaged.SubtleBlow.DTLite = set_combine(sets.engaged.SubtleBlow, {
        ear2 = "Odnowa Earring +1",
        body = 'Ken. Samue +1',
        ring1 = 'Defending Ring',
    })

	-- Weapons sets
    sets.weapons.Masamune = { main="Masamune", sub="Utu Grip", range = empty }
	sets.weapons.Doji = { main="Dojikiri Yasutsuna", sub="Utu Grip", range = empty }
    sets.weapons.Piercing = { main = "Shining One", sub="Utu Grip", range = empty }
	sets.weapons.ProcWeapon = {main="Zanmato",sub="Utu Grip", range="Kaja Bow",ammo="Eminent Arrow"}
	sets.weapons.Bow = {main="Ichigohitofuri",sub="Utu Grip", range="Kaja Bow",ammo="Eminent Arrow"}
	sets.weapons.MultiStep = { main="Soboro Sukehiro", sub="Utu Grip", range = empty }
	-- Buff sets
	sets.Cure_Received = {}
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff.Hasso = {hands="Wakido Kote +3"}
	sets.buff['Third Eye'] = {legs="Sakonji Haidate +2"}
    sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {} -- feet="Kas. Sune-Ate +1"
    sets.buff['Meikyo Shisui'] = {} -- feet="Sak. Sune-Ate +1"
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'DRG' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

function user_job_lockstyle()
		windower.chat.input('/lockstyleset 2')	
end