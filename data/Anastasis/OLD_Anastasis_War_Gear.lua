function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Hybrid') --F9
    state.WeaponskillMode:options('Normal', 'AtkCap')
	state.HybridMode:options('Normal')
	state.IdleMode:options('Normal')
	state.Weapons:options('Sword & Board', 'Club & Board', 'Great Axe', 'Great Sword', 'Spear', 'Axe', 'Chaos') --F7

	-- Additional local binds
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	gear.ambu = {
		tp = { name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}},
		str_ws = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	
	sets.Enmity = {}
	sets.Knockback = {}
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = { back= "Cichol's Mantle", body = 'Pumm. Lorica +3', feet = 'Agoge Calligae +1' }
	sets.precast.JA['Warcry'] = { head = "Agoge Mask +3" }
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = { head = "Pumm. Mask +1", body = "Agoge Lorica +1" }
	sets.precast.JA['Mighty Strikes'] = {}
	sets.precast.JA["Warrior's Charge"] = {}
	sets.precast.JA['Tomahawk'] = { ammo="Thr. Tomahawk" }
	sets.precast.JA['Retaliation'] = {}
	sets.precast.JA['Restraint'] = { hands = "Boii Mufflers +3" }
	sets.precast.JA['Blood Rage'] = { body = "Boii Lorica +2"}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
                   
	-- Fast cast sets for spells
	sets.precast.FC = {}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Midcast Sets
	sets.midcast.FastRecast = sets.precast.FC
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo = "Knobkierrie",
		head = "Agoge Mask +3",
		neck = "War. Beads +2",
		ear1 = "Moonshade Earring",
		ear2 = "Ishvara Earring",
		body = "Pummeler's Lorica +3",
        left_ring="Cornelia's Ring",
        right_ring="Epaminondas's Ring",
		hands = "Nyame Gauntlets",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		waist = "Sailfi Belt +1",
		legs={ name="Valorous Hose", augments={'Weapon skill damage +4%','Pet: Haste+2','Accuracy+18 Attack+18','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		feet = "Nyame Sollerets",
	}

    sets.precast.WS.AtkCap = {
		ammo = "Knobkierrie",
		head = "Agoge Mask +3",
		neck = "War. Beads +2",
		ear1 = "Moonshade Earring",
		ear2 = "Ishvara Earring",
		body = "Pummeler's Lorica +3",
        left_ring="Cornelia's Ring",
        right_ring="Epaminondas's Ring",
		hands = "Sakpata's Gauntlets",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		waist = "Sailfi Belt +1",
		legs = "Sakpata's Cuisses",
		feet = "Nyame Sollerets",
        
    }  

	sets.precast.WS['Judgment'] = {
		ammo = "Knobkierrie",
		head = "Agoge Mask +3",
		neck = "War. Beads +2",
		ear1 = "Moonshade Earring",
		ear2 = "Ishvara Earring",
		body = "Pummeler's Lorica +3",
        left_ring="Cornelia's Ring",
        right_ring="Epaminondas's Ring",
		hands = "Nyame Gauntlets",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		waist = "Sailfi Belt +1",
		legs={ name="Valorous Hose", augments={'Weapon skill damage +4%','Pet: Haste+2','Accuracy+18 Attack+18','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		feet = "Nyame Sollerets",	
	}

	sets.precast.WS['Savage Blade'] = {
		ammo = "Knobkierrie",
		head = "Agoge Mask +3",
		neck = "War. Beads +2",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = "Pummeler's Lorica +3",
        left_ring="Cornelia's Ring",
        right_ring="Regal Ring",
		hands = "Boii Mufflers +3",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		waist = "Sailfi Belt +1",
		legs ="Nyame Flanchard",
		feet = "Nyame Sollerets",
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
           
	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Hermes' Sandals",
		neck="Elite Royal Collar",
		waist="Platinum Moogle Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Hearty Earring",
		left_ring="Warden's Ring",
		right_ring="Fortified Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}

	sets.Kiting = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Pummeler's Cuisses +3",
		feet="Pummeler's Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear="Boii Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}, -- AF feet BiS
	}

	sets.engaged.Hybrid = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body="Boii Lorica +2",
		hands="Sakpata's Gauntlets",
		legs="Pummeler's Cuisses +3",
		feet="Flam. Gambieras +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Regal Ring",
		right_ring="Chirich Ring +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}

	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {

		ammo = "Per. Lucky egg",
	})
	
	-- Weapons sets
	sets.weapons['Sword & Board'] = { main = "Naegling", sub = "Blurred Shield +1" }
	sets.weapons['Club & Board'] = { main = "Loxotic Mace +1", sub = "Blurred Shield +1" }
	sets.weapons['Great Axe'] = { main = "Reikiono", sub = "Utu Grip" }
	sets.weapons['Great Sword'] = { main = "Montante +1", sub = "Utu Grip" }
	sets.weapons['Spear'] = { main = "Shining One", sub = "Utu Grip" }
	sets.weapons['Axe'] = { main = "Bronze Axe", sub = "Blurred Shield +1" }
	sets.weapons['Chaos'] = { main = "Laphria", sub = "Utu Grip" }
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 6)
    else
        set_macro_page(1, 6)
    end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 1')	
end