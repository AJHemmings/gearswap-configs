function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'SkillUp')
	state.WeaponskillMode:options('Match')
	state.HybridMode:options('Normal')
	state.IdleMode:options('Normal')
	state.Weapons:options('Sword & Board', 'Club & Board', 'Great Axe', 'Great Sword', 'Spear', 'Axe', 'Sword DPS')

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
	sets.precast.JA['Tomahawk'] = {}  ammo="Thr. Tomahawk"
	sets.precast.JA['Retaliation'] = {}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {}
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
        left_ring="Niqmaddu Ring",
        right_ring="Epaminondas's Ring",
		hands={ name="Valorous Mitts", augments={'Accuracy+25 Attack+25','Weapon skill damage +5%','AGI+6','Accuracy+15','Attack+11',}},
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		waist = "Sailfi Belt +1",
		legs = "Sakpata's Cuisses",
		feet = "Sulev. Leggings +2",
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
           
	-- Idle sets
	sets.idle = {}

	sets.Kiting = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Flam. Gambieras +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}, -- AF feet BiS
	}

	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons['Sword & Board'] = { main = "Naegling", sub = "Blurred Shield +1" }
	sets.weapons['Club & Board'] = { main = "Loxotic Mace", sub = "Blurred Shield +1" }
	sets.weapons['Great Axe'] = { main = "Reikiono", sub = "Utu Grip" }
	sets.weapons['Great Sword'] = { main = "Montante +1", sub = "Utu Grip" }
	sets.weapons['Spear'] = { main = "Shining One", sub = "Utu Grip" }
	sets.weapons['Axe'] = { main = "Bronze Axe", sub = "Blurred Shield +1" }

end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(3, 3)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    else
        set_macro_page(5, 3)
    end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 1')	
end