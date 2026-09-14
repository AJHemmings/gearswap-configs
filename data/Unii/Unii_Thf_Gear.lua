-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    autows = 'Evisceration'
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
	state.IdleMode:options('Normal', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Default', 'Domain Invasion', 'Cleaving', 'TH')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWMax','Parry'}
	state.AmbushMode = M(false, 'Ambush Mode')

    -- Additional local binds
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = {}
    sets.ExtraRegen = {}
    sets.Kiting = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	
    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.Parry = {}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
	-- Weapons sets
	sets.weapons.Default = {main="Tauret", sub="Shijo"}
    sets.weapons['Domain Invasion'] = {main="Tauret", sub="Voluspa Knife"}
    sets.weapons.Cleaving = {main="Tauret", sub = "Levante Dagger"}
    sets.weapons.TH = {main="Tauret", sub = "Taming Sari"}
	
    -- Actions we want to use to tag TH.
    sets.precast.Step = {}
		
    sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {}
    sets.precast.JA['Accomplice'] = {}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}
    sets.precast.JA['Conspirator'] = {} 
    sets.precast.JA['Steal'] = {hands="Pill. Armlets +1"}
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets"}
    sets.precast.JA['Feint'] = {}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

	sets.Self_Waltz = {}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
        head = "Herculean Helm",
        ear2 = 'Etiolation Earring',
        ring1 = "Weather. Ring",
        ring2 = "Kishar Ring",
        legs = "Rawhide Trousers",
    }

    sets.precast.FC.Utsusemi = {}


    -- Ranged snapshot gear
    sets.precast.RA = {
        head = "Pursuer's Beret",
        feet = "Pursuer's Gaiters"
    }


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})

    sets.precast.WS['Aeolian Edge'] = {
        ammo = 'Grenade Core',
        head = gear.herculean_mag_wsd_head,
        neck = 'Sanctity Necklace',
        ear1 = "Friomisi Earring",
        ear2 = 'Moonshade Earring',
        waist = 'Eschan Stone',
        legs = gear.herculean_mab_wsd_legs,
        ring1 = "Dingir Ring",
        ring2 = 'Arvina Ringlet +1',
    }

    sets.precast.WS["Rudra's Storm"] = {
        ear1 = 'Sherida Earring',
        ear2 = 'Moonshade Earring',
        body = gear.meg.body,
        hands = gear.meg.hands,
        ring1 = 'Ilabrat Ring',
        ring2 = 'Apate Ring',
        feet = gear.meg.feet,
    }

    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {
        legs = "Pil. Culottes +1"
    })

    sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]
    sets.precast.WS['Mandalic Stab'].SA = sets.precast.WS["Rudra's Storm"].SA

    sets.precast.WS.Evisceration = {
        head = "Adhemar Bonnet +1",
        neck = "Fotia Gorget",
        ear1 = "Mache Earring +1",
        ear2 = "Moonshade Earring",
        body = gear.mummu.body,
        hands = "Adhemar Wrist. +1",
        ring1 = 'Ilabrat Ring',
        waist = "Fotia Belt",
        legs = gear.mummu.legs,
        feet = gear.mummu.feet,
    }

    sets.precast.WS.Evisceration.SA = set_combine(sets.precast.WS.Evisceration, {
        hands = gear.meg.hands,
    })

    sets.precast.WS.Exenterator = {
        head = "Adhemar Bonnet +1",
        neck = "Fotia Gorget",
        ear1 = "Brutal Earring",
        body = gear.meg.body,
        hands = gear.meg.hands,
        ring1 = 'Ilabrat Ring',
        waist = "Fotia Belt",
        legs = gear.meg.legs,
        feet = gear.meg.feet,
    }

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {
        head = "Pursuer's Beret",
        feet = "Pursuer's Gaiters"
    }

    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        neck = "Loricate Torque +1",
        body = 'Malignance Tabard',
        ring1 = 'Defending Ring',
        ring2 = "Warden's Ring",
        feet = "Pill. Poulaines +1"
    }

    sets.idle.Refresh = set_combine(sets.idle, {
        legs = 'Nyame Flanchard'
    })

	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.ExtraRegen = {}

    -- Defense sets

    sets.defense.PDT = {
        head = gear.meg.head,
        neck = 'Loricate Torque +1',
        body = gear.meg.body,
        hands = gear.meg.hands,
        ring1 = "Defending Ring",
        ring2 = "Warden's Ring",
        legs = gear.meg.legs,
        feet = gear.meg.feet,
    }

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
        ammo = "Hagneia Stone",
        head = "Adhemar Bonnet +1",
        neck = 'Erudit. Necklace',
        ear1 = 'Sherida Earring',
        ear2 = 'Dedition Earring',
        body = "Malignance Tabard",
        hands = 'Adhemar Wrist. +1',
        ring1 = 'Rajas Ring',
        ring2 = 'Petrov Ring',
        back = 'Bleating Mantle',
        waist = 'Kentarch Belt +1',
        legs = 'Samnuha Tights',
        feet = gear.herculean_ta_feet,
    }

    sets.engaged.DT = set_combine(sets.engaged, {
        ear2 = 'Odnowa Earring +1',
        neck = "Loricate Torque +1",
        ring2 = 'Defending Ring',
        legs = gear.meg.legs,
        feet = "Malignance Boots"
    })
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 12)
    else
        set_macro_page(1, 12)
    end
end

--Job Specific Trust Override
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[993] < spell_latency and not have_trust("ArkEV") then
					windower.chat.input('/ma "AAEV" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[955] < spell_latency and not have_trust("Apururu") then
					windower.chat.input('/ma "Apururu (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.chat.input('/ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
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