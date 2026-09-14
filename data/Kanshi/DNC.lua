-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "2"
MacroBook = "6"
MacroSet = "1"

--Uses Items Automatically
AutoItem = true

--Upon Job change will use a random lockstyleset
Random_Lockstyle = true

--Lockstyle sets to randomly equip
Lockstyle_List = {16,17,18}

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them
state.OffenseMode:options('DT', 'TP', 'SB')
state.OffenseMode:set('DT')

state.WeaponMode:options('Twashtar','Tauret', 'Unlocked')
state.WeaponMode:set('Twashtar')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()

	sets.Weapons = {}
	sets.Weapons['Tauret'] = {main="Tauret", sub="Gleti's Knife",}
	-- sets.Weapons['Terpsichore'] = {}
	sets.Weapons['Twashtar'] = {
		main="Twashtar", 
		sub="Fusetto +2",
	}
	-- sets.Weapons['Aeneas'] = {main="Aeneas", sub="Gleti's Knife",}
	-- sets.Weapons['Karambit'] = {main="Karambit",}
	-- sets.Weapons['Unlocked'] = {main="", sub="",}
	sets.Weapons.Shield = {}
	sets.Weapons.Sleep = {}

	-- Standard Idle set with -DT, Refresh, Regen and movement gear
	sets.Idle = {
	ammo="Staunch Tathlum",
    head="Gleti's Mask",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Elite Royal Collar",
    waist="Plat. Mog. Belt",
    left_ear="Infused Earring",
    right_ear="Alabaster Earring",
    left_ring="Murky Ring",
    right_ring="Moonlight Ring",
    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		--ammo="Staunch Tathlum +1",
		--head="Malignance Chapeau",
		--body="Malignance Tabard",
		--hands="Malignance Gloves",
		--legs="Malignance Tights",
		--feet="Malignance Boots",
		--neck="Warder's Charm +1",
		--waist="Carrier's Sash",
		--left_ear="Sanare Earring",
		--right_ear="Eabani Earring",
		--left_ring="Moonlight Ring",
		--right_ring="Moonlight Ring",
		--back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}},
	}
	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {})
	sets.Idle.Resting = set_combine(sets.Idle, {})

	sets.Movement = {
	feet="Tandava Crackows",
	}

	-- Set to be used if you get cursna casted on you
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe3", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe4", priority=1},
		waist="Gishdubar Sash",
	}

	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	-- sets.OffenseMode = {
    -- ammo="Coiste Bodhar",
    -- head="Maculele Tiara +3",
    -- body="Malignance Tabard",
    -- hands="Malignance Gloves",
    -- legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    -- feet="Nyame Sollerets",
    -- neck={ name="Etoile Gorget +2", augments={'Path: A',}},
    -- waist="Sailfi Belt",
    -- left_ear="Digni. Earring",
    -- right_ear="Sherida Earring",
    -- left_ring="Epona's Ring",
    -- right_ring="Ephramad's Ring",
    -- back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	-- }

	sets.OffenseMode.DT = {
    ammo="Coiste Bodhar",
    head="Maculele Tiara +3",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Gleti's Breeches",
    feet="Nyame Sollerets",
    neck={ name="Etoile Gorget +2", augments={'Path: A',}},
    waist="Sailfi Belt +1",
    left_ear="Digni. Earring",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Moonlight Ring",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		--head="Malignance Chapeau",
		--body="Malignance Tabard",
		--hands="Malignance Gloves",
		--legs="Malignance Tights",
		--feet="Malignance Boots",
		--neck="Anu Torque",
		--waist="Reiki Yotai",
		--left_ear="Sherida Earring",
		--right_ear="Telos Earring",
		--left_ring="Moonlight Ring",
		--right_ring="Moonlight Ring",
		--back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	--Base TP set to build off
	sets.OffenseMode.TP = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Maculele Tiara +3",
	    body="Malignance Tabard",
    	hands="Malignance Gloves",
    	legs="Samnuha Tights", 
    	feet="Geliti's Boots",
    	neck={ name="Etoile Gorget +2", augments={'Path: A',}},
    	waist="Sailfi Belt +1",
    	left_ear="Digni. Earring",
    	right_ear="Sherida Earring",
    	left_ring="Chirich Ring +1",
    	right_ring="Epona's Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	-- Subtle Blow Cap at 50 and II at 25 for a Total of 75.
	-- DNC Subtle Blow = 20/50 w/ Traits. Need +30 in Gear for SBI Cap.
	-- Subtle Blow I: 50/50 | Subtle Blow II:05/25 | DT:50/50 | ACC: High
	sets.OffenseMode.SB = {
		ammo="Yamarang",
    	head="Malignance Chapeau",
    	body="Malignance Tabard",
    	hands="Malignance Gloves",
    	legs="Malignance Tights",
    	feet="Malignance Boots",
    	neck={ name="Etoile Gorget +2", augments={'Path: A',}},
    	waist="Ninurta's Sash",
    	left_ear="Sherida Earring", -- SBII+5
    	right_ear="Telos Earring",
    	left_ring="Chirich Ring +1", -- SB+10
    	right_ring="Epona's Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	-- sets.OffenseMode.ACC = {}

	-- sets.OffenseMode.MEVA = {
	--     ammo={ name="Coiste Bodhar", augments={'Path: A',}},
	-- 	head="Malignance Chapeau",
	-- 	body="Malignance Tabard",
	-- 	hands="Malignance Gloves",
	-- 	legs="Malignance Tights",
	-- 	feet="Malignance Boots",
	-- 	neck="Warder's Charm +1",
	-- 	waist="Reiki Yotai",
	-- 	left_ear="Sherida Earring",
	-- 	right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
	-- 	left_ring="Moonlight Ring",
	-- 	right_ring="Lehko's Ring",
	-- 	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}},
	-- }

	--Dual Wield
	-- sets.DualWield = {
	-- 	waist="Reiki Yotai",
	-- 	--left_ear="Eabani Earring",
	-- }

	sets.Precast = {}

	sets.Precast.FastCast = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'"Subtle Blow"+1','STR+3','"Treasure Hunter"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    	hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    	neck="Baetyl Pendant",
    	waist="Hachirin-no-Obi",
    	left_ear="Etiolation Earring",
    	right_ear="Enchntr. Earring +1",
    	right_ring="Rahab Ring",
	}

	sets.Enmity = {}
	sets.Midcast = {}
	sets.Midcast.SIRD = {}
	sets.Midcast.Cure = {}
	sets.Midcast.Enhancing = {}
	sets.Midcast.Enfeebling = {}
	sets.Midcast["Stoneskin"] = {}
	-------------------------------------------------------------------------------
	---------------------------------  JA Sets  -----------------------------------
	-- When you combine with idle during JA's you'll get ~2 sec of high defense --- 
	-------------------- if not overwritten by specified gear ---------------------
	-------------------------------------------------------------------------------
	sets.JA = {}

	sets.JA["Trance"] = {head="Horos Tiara +1",}
	sets.JA["Contradance"] = {}
	sets.JA["Saber Dance"] = {legs="Horos Tights +4",}
	sets.JA["Fan Dance"] = {hands="Horos Bangles",}
	sets.JA["No Foot Rise"] = {body="Horos Casaque",}
	sets.JA["Presto"] = {}
	sets.JA["Grand Pas"] = {}
	-------------------------------------------------------------------------------
	-- Flourishes provide buffs to the Dancer and debuffs to the target monster. --
	-------------------------------------------------------------------------------
	sets.Flourish = set_combine(sets.Idle.DT, {head="Nyame Helm",})
																								-- Flourishes I : Monster Control
	sets.Flourish["Animated Flourish"] = set_combine(sets.Flourish, sets.Enmity) 				-- Volatile Enmity spike like Provoke
	sets.Flourish["Desperate Flourish"] = {} 													-- Gravity effect 
	sets.Flourish["Violent Flourish"] = {} 														-- Stun effect 
																								-- Flourishes II : Skillchain Enhancers
	sets.Flourish["Reverse Flourish"] = {} 														-- Returns TP in exchange for Finishing Moves
	sets.Flourish["Building Flourish"] = {head="Nyame Helm",}									-- Increases the strength of the next Weapon Skill
	sets.Flourish["Wild Flourish"] = {}															-- Readies target for Skillchain
																								-- Flourishes III : Weapon Skill Buffs
	sets.Flourish["Climactic Flourish"] = {{ammo="Charis Feather",head="Maculele Tiara +3"}}	-- Forces Critical Hit(s) on the next attack(s) 
	sets.Flourish["Striking Flourish"] = {head="Nyame Helm",}									-- Forces a Double Attack on the next swing 
	sets.Flourish["Ternary Flourish"] = {}														-- Forces a Triple Attack on the next swing
	-------------------------------------------------------------------------------
	-- Waltz Potency gear caps at 50%, while Waltz received potency caps at 30%. -- 
	-------------------------------------------------------------------------------
	sets.Waltz = {    
		ammo="Yamarang",
    	head={ name="Horos Tiara +1", augments={'Enhances "Trance" effect',}},
    	body="Maxixi Casaque +3",
    	hands={ name="Horos Bangles", augments={'Enhances "Fan Dance" effect',}},
    	legs="Dashing Subligar",
    	feet="Maxixi Toe Shoes +2",
    	neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    	waist="Chaac Belt",
    	left_ear="Enchntr. Earring +1",
    	right_ear="Cryptic Earring",
    	left_ring="Metamorph Ring",
    	right_ring="Carb. Ring +1",
    	back="Moonlight Cape",
	}
	sets.Waltz["Curing Waltz"] = sets.Waltz
	sets.Waltz["Curing Waltz II"] = sets.Waltz
	sets.Waltz["Curing Waltz III"] = sets.Waltz
	sets.Waltz["Curing Waltz IV"] = sets.Waltz
	sets.Waltz["Curing Waltz V"] = sets.Waltz
	sets.Waltz["Divine Waltz"] = sets.Waltz
	sets.Waltz["Divine Waltz II"] = sets.Waltz
	sets.Waltz["Healing Waltz"] = sets.Waltz
	-------------------------------------------------------------------------------
	---------- Samba duration can be increased using various equipment. -----------
	-------------------------------------------------------------------------------
	sets.Samba = set_combine(sets.Idle.DT, {head="Maxixi Tiara +2",}) --  Missing Ambu Cape for +15
	
	sets.Samba["Haste Samba"] = {}
	sets.Samba["Aspir Samba"] = {}
	sets.Samba["Aspir Samba II"] = {}
	sets.Samba["Drain Samba"] = {}
	sets.Samba["Drain Samba II"] = {}
	sets.Samba["Drain Samba III"] = {}
	-------------------------------------------------------------------------------
	----------- Jigs duration can be increased using various equipment. ----------- 
	-------------------------------------------------------------------------------
	sets.Jig = set_combine(sets.Idle.DT, {legs="Horos Tights +4",feet="Maxixi Toe Shoes +2",}) -- Horos Tights +4 and Maxixi Toe Shoes +3

	sets.Jig["Spectral Jig"] = sets.Jig
	sets.Jig["Chocobo Jig"] = sets.Jig
	sets.Jig["Chocobo Jig II"] = sets.Jig
	-------------------------------------------------------------------------------
	----- Step Accuracy depends on your melee hit rate (including your normal -----
	---- Accuracy equipment). All Steps tested have shown an innate 10 Accuracy --- 
	-- bonus, which can be further enhanced through various pieces of equipment, -- 
	----------------------------- merits, and Presto. -----------------------------
	-------------------------------------------------------------------------------
	sets.Step = {
		ammo="Yamarang",
    	head="Malignance Chapeau",
    	body="Malignance Tabard",
    	hands="Maxixi Bangles +4",
    	legs="Malignance Tights",
    	feet="Malignance Boots",
    	neck="Etoile Gorget +2",
    	waist="Reiki Yotai",
    	left_ear="Odr Earring",
    	right_ear="Telos Earring",
    	left_ring="Chirich Ring +1",
    	right_ring="Chirich Ring +1",
    	back="Sacro Mantle",
	}
	
	sets.JA["Quickstep"] = sets.Step
	sets.JA["Box Step"] = sets.Step
	sets.JA["Stutter Step"] = sets.Step
	sets.JA["Feather Step"] = set_combine(sets.Idle.DT, {})

	--Default WS set base
	sets.WS = {
    ammo="Oshasha's Treatise",
    head="Maculele Tiara +3",
    body="Nyame Mail",
    hands="Maxixi Bangles +4",
    legs="Horos Tights +4",
    feet="Nyame Sollerets",
    neck={ name="Etoile Gorget +2", augments={'Path: A',}},
    waist="Cornelia's Belt",
    left_ear="Moonshade Earring",
    right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Store TP"+3',}},
    left_ring="Ephramad's Ring",
    right_ring="Beithir Ring",
    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = {}
	--WS Sets
	-- Dagger WS
	sets.WS["Wasp Sting"] = {}
	sets.WS["Viper Bite"] = {}
	sets.WS["Shadowstich"] = {}
	sets.WS["Gust Slash"] = {}
	sets.WS["Cyclone"] = {}
	sets.WS["Energy Steal"] = {}
	sets.WS["Energy Drain"] = {}
	sets.WS["Dancing Edge"] = {}
	sets.WS["Shark Bite"] = {}
	sets.WS["Evisceration"] = {
    ammo="Charis Feather",
    head="Gleti's Mask",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Odr Earring",
    right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Store TP"+3',}},
    left_ring="Ephramad's Ring",
    right_ring="Beithir Ring",
    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	sets.WS["Exenterator"] = {
	ammo="Charis Feather",
    head="Adhemar Bonnet +1",
    body="Meg. Cuirie +2",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Store TP"+3',}},
    left_ring="Ephramad's Ring",
    right_ring="Beithir Ring",
    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},

	}
	sets.WS["Aeolian Edge"] = {}
	sets.WS["Rudra's Storm"] = {
	ammo="Oshasha's Treatise",
    head="Maculele Tiara +3",
    body="Nyame Mail",
    hands="Maxixi Bangles +4",
    legs="Horos Tights +4",
    feet="Nyame Sollerets",
    neck={ name="Etoile Gorget +2", augments={'Path: A',}},
    waist="Sailfi Belt +1",
    left_ear="Moonshade Earring",
    right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Store TP"+3',}},
    left_ring="Ephramad's Ring",
    right_ring="Beithir Ring",
    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	-- Hand to Hand WS
	sets.WS["Combo"] = {}
	sets.WS["Shoulder Tackle"] = {}
	sets.WS["Backhand Blow"] = {}
	sets.WS["Asuran Fists"] = {} 	-- Only if Karambit Weapon Equipt
	sets.WS["Dragon Kick"] = {} 	-- Only if Hepatizon Baghnakhs NQ/+1 Weapon Equipt
	sets.WS["One Inch Punch"] = {} 	-- Must Sub MNK
	sets.WS["Raging Fists"] = {} 	-- Must Sub MNK
	sets.WS["Tornado Kick"] = {} 	-- Must Sub MNK

	sets.TreasureHunter = {
		ammo="Per. Lucky Egg",    
		body="Volte Jupon",
		waist="Chaac Belt",}
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end
--Adjust custom precast actions
function pretarget_custom(spell,action)
	
end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return Weapon_Check(equipSet)
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return Weapon_Check(equipSet)
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when a self command is issued
function self_command_custom(command)

end
--Function is called when a lua is unloaded
function user_file_unload()

end

--Function used to automate Job Ability use
function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	if player.sub_job == 'SAM' and player.sub_job_level > 8 then
		if not buffactive['Hasso'] and not buffactive['Seigan'] and ja_recasts[138] == 0 then
			buff = "Hasso"
		elseif not buffactive['Meditate'] and ja_recasts[134] == 0 then
			buff = "Meditate"
		end
	end

	if player.sub_job == 'WAR' and player.sub_job_level > 8 then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end

	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end

function Weapon_Check(equipSet)
	equipSet = set_combine(equipSet,sets.Weapons[state.JobMode.value])

	return equipSet
end