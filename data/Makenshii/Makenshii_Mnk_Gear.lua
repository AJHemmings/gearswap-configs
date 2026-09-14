function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.WeaponskillMode:options('Match','Normal')
	state.HybridMode:options('Normal', 'PDT')
	state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Vere', 'GodHands', 'Pole', 'Club')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}

    update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	-- sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
	-- sets.precast.JA['Boost'] = {} --hands="Anchorite's Gloves +1"
	-- sets.precast.JA['Boost'].OutOfCombat = {} --hands="Anchorite's Gloves +1", Remove Haste and Add Slow Gear.
	 sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +3"}
	-- sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
	-- sets.precast.JA['Counterstance'] = {} --feet="Hesychast's Gaiters +1"
	-- sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
	-- sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
	-- sets.precast.JA['Mantra'] = {feet="Mel. Gaiters +2"} --feet="Hesychast's Gaiters +1"

	sets.precast.JA['Chi Blast'] = {}
	
	 sets.precast.JA['Chakra'] = {
	-- 	head="Dampening Tam",
	 	body="Anchorite's Cyclas",
		hands="Melee Gloves +2",
	 	legs="Hes. Hose +1",
		feet="Anch. Gaiters +3",
	 }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	-- sets.precast.Waltz['Healing Waltz'] = {}

	-- sets.precast.Step = {ammo="Falcon Eye",
	-- 	head="Malignance Chapeau",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
	-- 	body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
	-- 	back="Segomo's Mantle",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet="Malignance Boots"}
		
	-- sets.precast.Flourish1 = {ammo="Falcon Eye",
	-- 	head="Malignance Chapeau",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
	-- 	body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
	-- 	back="Segomo's Mantle",waist="Olseni Belt",legs="Mummu Kecks +2",feet="Malignance Boots"}


	-- Fast cast sets for spells
	
	-- sets.precast.FC = {ammo="Impatiens",
	-- head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
	-- body="Dread Jupon",hands="Leyline Gloves",ring2="Lebeche Ring",ring2="Kishar Ring",
	-- legs="Rawhide Trousers"}

	-- sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Coiste Bodhar",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Bhikku Cyclas +2",
		hands="Ryuo Tekko",
		legs="Hiza. Hizayoroi +2",
		feet="Mummu Gamash. +1",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Rufescent Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},	
	}

	sets.precast.WS['Shijin Spiral'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Ken. Jinpachi +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+11','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+9','"Triple Atk."+4','Attack+13',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Mache Earring +1",
		left_ring="Rufescent Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10',}},
	}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring",ear2="Sherida Earring",}
	-- sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	
	-- Midcast Sets
	-- sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",
	-- 	head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
	-- 	body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
	-- 	back="Moonlight Cape",waist="Black Belt",legs=gear.herculean_dt_legs,feet="Hippo. Socks +1"}
		
	-- Specific spells
	-- sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	-- sets.resting = {body="Hesychast's Cyclas",ring2="Sheltered Ring"}
	

	-- Idle sets
	 sets.idle = {
		ammo="Amar Cluster",
		head="Nyame Helm",
		body="Malignance Tabard",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Herald's Gaiters",
		neck="Elite Royal Collar",
		waist="Moonbow Belt +1",
		left_ear="Ethereal Earring",
		right_ear="Infused Earring",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back="Solemnity Cape",
	 }

	-- sets.idle.Weak = {ammo="Staunch Tathlum +1",
	-- 	head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
	-- 	body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Sheltered Ring",
	-- 	back="Moonlight Cape",waist="Black Belt",legs=gear.herculean_dt_legs,feet="Hippo. Socks +1"}

	-- sets.idle.PDT = {ammo="Staunch Tathlum +1",
	-- 	head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
	-- 	body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
	-- 	back="Moonlight Cape",waist="Black Belt",legs=gear.herculean_dt_legs,feet="Hippo. Socks +1"}		

	-- -- Defense sets
	-- sets.defense.PDT = {ammo="Staunch Tathlum +1",
	-- 	head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
	-- 	body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
	-- 	back="Moonlight Cape",waist="Black Belt",legs=gear.herculean_dt_legs,feet="Malignance Boots"}
		
	-- -- Defense sets
	-- sets.defense.HP = {ammo="Staunch Tathlum +1",
	-- 	head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
	-- 	body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
	-- 	back="Segomo's Mantle",waist="Black Belt",legs=gear.herculean_dt_legs,feet="Hippo. Socks +1"}

	-- sets.defense.MDT = {ammo="Staunch Tathlum +1",
	-- 	head="Dampening Tam",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
	-- 	body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Shadow Ring",
	-- 	back="Moonlight Cape",waist="Flax Sash",legs=gear.herculean_dt_legs,feet="Hippo. Socks +1"}
		
	-- sets.defense.MEVA = {ammo="Staunch Tathlum +1",
	-- 	head=empty,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
	-- 	body="Respite Cloak",hands="Leyline Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
	-- 	back="Toro Cape",waist="Flax Sash",legs="Samnuha Tights",feet="Malignance Boots"}

	   sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Ken. Jinpachi +1",
		body="Bhikku Cyclas +2",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Malignance Tights",
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Epona's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10',}},
	}

	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {})

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Impetus = {body="Bhikku Cyclas"}
	sets.buff.Footwork = {feet="Shukuyu Sune-Ate"}
	sets.buff.Boost = {} --waist="Ask Sash"
	
	sets.FootworkWS = {feet="Shukuyu Sune-Ate"}
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {legs="Ryuo Hakama"}
	
	-- Weapons sets
	sets.weapons.Vere = {main="Verethragna"}
	sets.weapons.GodHands = {main="Godhands"}
	sets.weapons.Pole = {main="Lamia Staff"}
	sets.weapons.Club = {main="Ash Club"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 14)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 14)
	elseif player.sub_job == 'THF' then
		set_macro_page(1, 14)
	elseif player.sub_job == 'RUN' then
		set_macro_page(1, 14)
	else
		set_macro_page(1, 14)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 2')
end
