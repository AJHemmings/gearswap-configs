-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc')
	state.WeaponskillMode:options('Normal', 'AtkCapped')
	state.HybridMode:options('Normal', 'DTLite')
	state.Weapons:options('Spear', 'Pole', 'Sword')

	select_default_macro_book()
	
	-- Additional local binds
	send_command('bind @f7 gs c toggle AutoJumpMode')
	send_command('bind @` gs c cycle SkillchainMode')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	gear.JumpSet = set_combine(sets.engaged, { body = "Vishap Mail +1", hands = "Vishap F. G. +1", legs = "Ptero. Brais +3" })
	gear.ambu = {
		wsd = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}},
		tp = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	}

	sets.precast.JA.Angon = {ammo="Angon",hands="Ptero. Fin. G. +2"}
	sets.precast.JA.Jump = gear.JumpSet
	sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +1"} --
	sets.precast.JA['High Jump'] = gear.JumpSet
	sets.precast.JA['Soul Jump'] = gear.JumpSet
	sets.precast.JA['Spirit Jump'] = gear.JumpSet
	sets.precast.JA['Super Jump'] = {}
	sets.precast.JA['Spirit Link'] = {hands = "Pel. Vambraces"} --head="Vishap Armet",hands="Lnc. Vmbrc. +2",head="Vishap Armet +1"
	sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +1"} --
	sets.precast.JA['Deep Breathing'] = {hands="Ptero. Armet +1"} --
	sets.precast.JA['Spirit Surge'] = {body="Ptero. Mail +1"} --
	sets.precast.JA['Steady Wing'] = {}
	
	-- Breath sets
	sets.precast.JA['Restoring Breath'] = {}
	sets.precast.JA['Smiting Breath'] = {}
	sets.HealingBreath = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {}
		
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {
		ammo = "Knobkierrie",
		head = "Lustratio Cap +1",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Dagon Breast.",
		hands = "Sulev. Gauntlets +2",
		ring1 = "Niqmaddu Ring",
		ring2 = "Regal Ring",
		back = gear.ambu.wsd,
		waist = "Fotia Belt",
		legs = "Sulev. Cuisses +2",
		feet = "Lustra. Leggings +1"
	}

	sets.precast.WS.Stardiver = sets.precast.WS

	sets.precast.WS.Stardiver.AtkCapped = set_combine(sets.precast.WS.Stardiver, {
		head = "Flam. Zucchetto +2",
		body = "Gleti's Cuirass",
		legs = "Gleti's Breeches",
		feet = "Flam. Gambieras +2"
	})

	sets.precast.WS["Camlann's Torment"] = {
		ammo = "Knobkierrie",
		head = gear.valorous_wsd_head,
		neck = "Rep. Plat. Medal",
		ear1 = "Ishvara Earring",
		ear2 = "Thrud Earring",
		body = "Nyame Mail",
		hands = "Ptero. Fin. G. +2",
		ring1 = "Niqmaddu Ring",
		ring2 = "Karieyh Ring +1",
		back = gear.ambu.wsd,
		waist = "Fotia Belt",
		legs = "Nyame Flanchard",
		feet = "Sulev. Leggings +2"
	}

	sets.precast.WS["Camlann's Torment"].AtkCapped = set_combine(sets.precast.WS["Camlann's Torment"], {
		head = "Gleti's Mask",
		body = "Gleti's Cuirass",
		legs = "Gleti's Breeches",
	})

	sets.precast.WS["Sonic Thrust"] = set_combine(sets.precast.WS["Camlann's Torment"], {
		neck = "Fotia Gorget",
		body = "Dagon Breast.",
	})

	sets.precast.WS["Sonic Thrust"].AtkCapped = sets.precast.WS["Camlann's Torment"].AtkCapped

	sets.precast.WS["Impulse Drive"] = {
		ammo = "Knobkierrie",
		head = "Gleti's Mask",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Gleti's Cuirass",
		hands = "Nyame Gauntlets",
		ring1 = "Niqmaddu Ring",
		ring2 = "Regal Ring",
		back = gear.ambu.wsd,
		waist = "Sailfi Belt +1",
		legs = "Sulev. Cuisses +2",
		feet = "Sulev. Leggings +2"
	}

	sets.precast.WS["Impulse Drive"].AtkCapped = set_combine(sets.precast.WS["Impulse Drive"], {
		head = "Gleti's Mask",
		body = "Gleti's Cuirass",
		hands = "Gleti's Gauntlets",
		ring2 = "Epaminondas's Ring",
		legs = "Gleti's Breeches",
	})

	sets.precast.WS.Drakesbane = {
		ammo = "Knobkierrie",
		head = "Gleti's Mask",
		neck = "Fotia Gorget",
		ear1 = "Thrud Earring",
		ear2 = "Sherida Earring",
		body = "Hjarrandi Breast.",
		hands = "Gleti's Gauntlets",
		ring1 = "Niqmaddu Ring",
		ring2 = "Regal Ring",
		back = gear.ambu.wsd,
		waist = "Sailfi Belt +1",
		legs = "Pelt. Cuissots +1",
		feet = "Sulev. Leggings +2"
	}

	sets.precast.WS.Drakesbane.AtkCapped = set_combine(sets.precast.WS.Drakesbane, {
		ammo = "Crepuscular Pebble",
		head = "Gleti's Mask",
		body = "Gleti's Cuirass",
		hands = "Gleti's Gauntlets",
		legs = "Gleti's Breeches",
	})

	sets.precast.WS['Savage Blade'] = {
		ammo = "Knobkierrie",
		head = "Nyame Helm",
		neck = "Rep. Plat. Medal",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = "Gleti's Cuirass",
		hands = "Nyame Gauntlets",
		ring1 = "Epaminondas's Ring",
		ring2 = "Cornelia's Ring",
		back = gear.ambu.wsd,
		waist = "Sailfi Belt +1",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
	}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {}
		
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck = "Vim Torque +1"}
	
	-- Weapons sets
	sets.weapons.Spear = {main="Shining One",sub="Utu Grip"}
	sets.weapons.Pole = {main="Malignance Pole",sub="Utu Grip"}
	sets.weapons.Sword = {main="Naegling",sub=empty}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Sherida Earring",}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group

	sets.engaged = {
		ammo = "Coiste Bodhar",
		head = "Flam. Zucchetto +2",
		neck = "Lissome Necklace",
		ear1 = "Telos Earring",
		ear2 = "Sherida Earring",
		body = "Flamma Korazin +2",
		hands = "Sulevia's Gauntlets +2",
		ring1 = "Niqmaddu Ring",
		ring2 = "Chirich Ring +1",
		back = gear.ambu.tp,
		waist = "Ioskeha Belt +1",
		legs = "Flam. Dirs +2",
		feet = "Flam. Gambieras +2"
	}

	sets.engaged.Sword = set_combine(sets.engaged, {
		hands = "Sulev. Gauntlets +2",
	})
end

sets.engaged.DTLite = set_combine(sets.engaged, {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Sulev. Gauntlets +2",
    legs="Nyame Flanchard",
    feet="Flam. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Chirich Ring +1",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
})
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(5, 13)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 13)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 13)
    else
        set_macro_page(5, 13)
    end
end