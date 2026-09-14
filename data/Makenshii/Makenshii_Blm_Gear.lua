function user_job_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal','OccultAcumen','Proc')
	state.OffenseMode:options('Normal')
	state.IdleMode:options('Normal','PDT')
	state.Weapons:options('None','Marin','ProcZeni','Melee')

    gear.obi_low_nuke_waist = "Eschan Stone"
	gear.obi_high_nuke_waist = "Eschan Stone"
	gear.nuke_jse_back = {name="Taranus's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.stp_jse_back = {name="Taranus's Cape",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode') 
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
    
	select_default_macro_book()
end

function user_job_self_command(commandArgs, eventArgs)
    local cmd = commandArgs[1];

    if cmd == 'FullBuff' then
    end

    if cmd == 'Rebuff' then
    end

    if cmd == 'CrowdControl' then
    end

    if cmd == 'Nuke1' then
        send_command('gs c elemental nuke')
    end

    if cmd == 'Nuke2' then
        return send_command('gs c elemental nuke')
    end

    if cmd == 'Dispel' then
        return send_command('input /dispel')
    end
end

function init_gear_sets()
    sets.weapons.Marin = { main = "Marin Staff +1", sub = "Enki Strap" }
    sets.weapons.Melee = { main = "Khatvanga", sub = "Dilet.'s Grip +1" }
    sets.weapons.ProcZeni = { main = 'Wind Knife', sub = "Wind Knife", range = "Soultrapper 2000", ammo = "H.S. Soul Plate" }
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	-- Weapons sets
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}	
	
	-- Treasure Hunter
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {back=gear.nuke_jse_back,feet="Wicce Sabots +1"}

    sets.precast.JA.Manafont = {} --body="Sorcerer's Coat +2"
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
        main = "Malevolence", -- 2
        head = "Nahtirah Hat", -- 10
        ear1 = "Malignance Earring", -- 4
        ear2 = "Etiolation Earring", -- 1
        body = "Zendik Robe", -- 13
        ring1 = "Kishar Ring", -- 4
        ring2 = "Weather. Ring", -- 5
        back = "Fi Follet Cape +1", -- 10
        waist = "Embla Sash", -- 5
        legs = "Agwu's Slops", -- 7
        feet = "Amalric Nails +1", -- 6
    } -- 65
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Doyen Pants"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        neck = "Stoicheion Medal", -- 3
        ear2 = "Barkaro. Earring", -- 3
    }) -- 67

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    sets.precast.WS.Myrkr = {
        ammo = "Ghastly Tathlum +1",
        head = "Pixie Hairpin +1",
        neck = "Sanctity Necklace",
        ear1 = "Moonshade Earring",
        ear2 = "Etiolation Earring",
        body = "Agwu's Robe",
        ring1 = "Mephitas's Ring",
        ring2 = "Mephitas's Ring +1",
        back = "Fi Follet Cape +1",
        waist = "Shinjutsu-no-Obi +1",
        legs = "Amalric Slops +1",
        feet = "Nyame Sollerets"
    }
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = sets.precast.FC

	sets.midcast['Enhancing Magic'] = {}
    
    sets.midcast['Enfeebling Magic'] = {}
		
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {
        main = "Rubicundity",
        sub = "Ammurapi Shield",
        ammo = "Ombre Tathlum +1",
        head = "Pixie Hairpin +1",
        neck = "Erra Pendant",
        ear1 = "Malignance Earring",
        ear2 = "Regal Earring",
        hands = "Amalric Gages +1",
        ring1 = "Evanescence Ring",
        ring2 = "Archon Ring",
        waist = "Fucho-no-obi",
    }
    
    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Stun = {}

	sets.midcast.Impact = {
		head = empty,
        body = "Twilight Cloak",
    }
		
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
        main = "Marin Staff +1",
        sub = "Enki Strap",
        ammo = "Ghastly Tathlum +1",
        head = gear.jhakri.head,
        neck = "Sibyl Scarf",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = "Mallquis Saio +2",
        hands = "Amalric Gages +1",
        ring1 = "Mallquis Ring",
        ring2 = "Metamor. Ring +1",
        waist = gear.ElementalObi.name,
        legs = "Amalric Slops +1",
        feet = "Amalric Nails +1",
    }
		
    sets.midcast['Elemental Magic'].Proc = {}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
        body = "Agwu's Robe",
        ring1 = "Freke Ring",
    })
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {}
		
    sets.midcast['Elemental Magic'].OccultAcumen = set_combine(sets.midcast['Elemental Magic'], {
        head = 'Mall. Chapeau +2',
        body = gear.merlinic_occult_body,
        ear1 = "Crepuscular Earring",
        ear2 = "Dedition Earring",
        ring1 = "Rajas Ring",
        ring2 = "Petrov Ring",
        legs = "Perdition Slops",
    })
		
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Twilight Cloak"})
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {
        main = "Bolelabunga",
        sub = "Genmei Shield",
        ammo = "Ombre Tathlum +1",
        head = "Blistering Sallet +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Infused Earring",
        body = "Shamash Robe",
        hands = gear.merlinic_refresh_hands,
        ring1 = "Defending Ring",
        ring2 = "Mephitas's Ring +1",
        waist = "Shinjutsu-no-Obi +1",
        legs = "Assiduity Pants +1",
        feet = "Nyame Sollerets",
    }

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = set_combine(sets.idle, {
        main = "Malignance Pole",
        sub = "Mensch Strap",
    })
		
    -- Defense sets

	sets.Kiting = {}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Mana Wall'] = {}
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spae. Coat +1"}
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
        head = "Agwu's Cap",
        neck = "Argute Stole +1",
        body = "Agwu's Robe",
        hands = "Amalric Gages +1",
        ring2 = "Mujin Band",
        legs = "Agwu's Slops",
        feet = "Amalric Nails +1",
    }
	
	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}

	--Situational sets: Gear that is equipped on certain targets
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 7)
end