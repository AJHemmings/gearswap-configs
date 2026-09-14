-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('None', 'Normal')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'PDT')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')

  select_default_macro_book()

  -- Tells GearInfo to update settings.player
  send_command('gi ugs true')

  Notification_color = 200
  text_color = 160
  warning_text = 167

  old_inform = {}
  settings = load_settings()
  text_box = texts.new(settings.display)
  text_box:register_event('reload', initialize)

  initialize(text_box)

  local msg = ''
  msg = ('You have loaded Akyrey\'s WHM lua. Please use '):color(text_color) .. ('\"\/\/GS c help\" '):color(Notification_color) .. ('for a full list of key bound functions. Enjoy!'):color(text_color)
  add_to_chat(122, msg)
end

function select_default_macro_book()
  set_macro_page(1, 3)
end

function init_gear_sets()
  print('Ubra_WHM_gear.lua side_cart loaded')
  --------------------------------------
  -- AF - Relic - Empy
  --------------------------------------
  AF_head             ={ name="Theophany Cap" }
  AF_body             ={ name="Theo. Briault +1" }
  AF_hands            ={ name="Theophany Mitts +2" }
  AF_legs             ={ name="Theo. Pant. +1" }
  AF_feet             ={ name="Theo. Duckbills +1" }

  Relic_head          ={ name="Piety Cap", augments={'Enhances "Devotion" effect',}}
  Relic_body          ={ name="Piety Briault", augments={'Enhances "Benediction" effect',}}
  Relic_hands         ={ name="Piety Mitts", augments={'Enhances "Martyr" effect',}}
  Relic_legs          ={ name="Piety Pantaloons", augments={'Enhances "Shellra V" effect',}}
  Relic_feet          ={ name="Piety Duckbills", augments={'Enhances "Protectra V" effect',}}

  Empy_head           ={ name="Ebers Cap" }
  Empy_body           ={ name="Ebers Bliaud" }
  Empy_hands          ={ name="Ebers Mitts" }
  Empy_legs           ={ name="Ebers Pantaloons" }
  Empy_feet           ={ name="Ebers Duckbills" }

  --------------------------------------
  -- Augmented Gear
  --------------------------------------
  Arka_IV             ={ name="Arka IV", augments={'"Cure" potency +24%',}}
  Queller_rod         ={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}}

  Vanya_head_FC       ={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}
  Vanya_feet          ={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}
  Cure_pot_head       ={ name="Gende. Caubeen +1", augments={'Phys. dmg. taken -1%','"Cure" potency +6%',}}
  FC_hands            ={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -5%',}}

  Cure_back           ={ name="Alaunus's Cape", augments={'MND+20','Enmity-10','Spell interruption rate down-10%',}}

  ----
  -- items to get
  ---
  -- Regal pumps to +1
  -- kaykaus head path B, hands path A
  -- grioavolr (staff for FC) augmented
  -- Chironic head

  --------------------------------------
  -- Start defining the sets
  --------------------------------------

  -- Precast Sets

  -- Fast cast sets for spells
  -- Clerisy Strap          2% FC
  -- Incantor Stone         2% FC
  -- Vanya Hood             10% FC
  -- Orison Locket          5% FC
  -- Loquacious Earring     2% FC
  -- Inyanga Jubbah +2      13% FC
  -- Gendewitha Gages       7% FC
  -- Kishar Ring            4% FC
  -- Lebeche Ring                       2% QM
  -- Veela Cape             1% FC
  -- Witful Belt            3% FC
  -- Aya. Cosciales +1      5% FC
  -- Regal Pumps +1          3% FC
  ---------------------------------------------------------------
  -- Total =                57% FC      2% QM
  -------------------------------------------------------------------------------------------------------
  -- Total = 57% Cast Speed + 2% QM
  sets.precast.FC = {
    main={ name="Queller Rod", augments={'MP+80','"Cure" potency +15%','Enmity-5',}},
    ammo="Seraphic Ampulla",
    head="Nahtirah Hat",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','Song spellcasting time -4%',}},
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Voltsurge Torque",
    waist="Ninurta's Sash",
    left_ear="Mendi. Earring",
    right_ear="Etiolation Earring",
    left_ring="Rahab Ring",
    right_ring="Weather. Ring",
    back="Solemnity Cape",
}

  sets.precast.FC.Raise = set_combine(sets.precast.FC, {})

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

  sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Doyen pants", hands="Carapacho Cuffs"})

--64% FC + 13% healing cast time = 77%
  sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs=Empy_legs})

  sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

--26% cure cast time + 13% healing cast time + 49% FC = 88% FC (80% cap) + 4% quick
  sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
    ammo="Staunch Tathlum",
    head="Nahtirah Hat",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','Song spellcasting time -4%',}},
    legs="Ebers Pant. +1",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
    neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Mendi. Earring",
    right_ear="Etiolation Earring",
    left_ring="Kishar Ring",
    right_ring="Warden's Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},})

  sets.precast.FC.Curaga = sets.precast.FC.Cure

  sets.precast.FC.CureSolace = sets.precast.FC.Cure

  -- CureMelee spell map should default back to Healing Magic.

  -- Precast sets to enhance JAs
  sets.precast.JA['Benediction'] = {body=Relic_body}
  sets.precast.JA['Devotion'] = {head=Relic_head}
  sets.precast.JA['Martyr'] = {hands=Relic_hands}

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {}


  -- Weaponskill sets

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {}

  sets.precast.WS['Flash Nova'] = {}


  -- Midcast Sets

  sets.midcast.FastRecast = set_combine(sets.precast.FC, {
    main={ name="Queller Rod", augments={'MP+80','"Cure" potency +15%','Enmity-5',}},
    ammo="Sapience Orb",
    head="Haruspex Hat",
    body="Witching Robe",
    hands="Gende. Gages +1",
    legs="Praeco Slacks",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
    neck="Eddy Necklace",
    waist="Penitent's Rope",
    left_ear="Nourish. Earring",
    right_ear="Mendi. Earring",
    left_ring="Purity Ring",
    right_ring="Warden's Ring",
    back="Pahtli Cape",
})

  -- Cure sets
  sets.midcast.Cure = {
    main="Queller Rod",
    ammo="Seraphic Ampulla",
    head="Vanya Hood",
    body="Ebers Bliaud +1",
    hands="Gende. Gages +1",
    legs="Ebers Pantaloons +1",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
    neck="Eddy Necklace",
    waist="Luminary Sash",
    left_ear="Nourish. Earring",
    right_ear="Mendi. Earring",
    left_ring="Purity Ring",
    right_ring="Warden's Ring",
    back="Solemnity Cape",
}

  sets.midcast.Curaga = sets.midcast.Cure

  sets.midcast['Cure With Weather'] = set_combine(sets.midcast.Cure, {
    main="Chatoyant Staff",sub={name="Verse Strap +1", priority=-1},
    waist="Hachirin-no-Obi"})

  sets.midcast['Curaga With Weather'] = set_combine(sets.midcast['Cure With Weather'], {})

  sets.midcast.Cursna = {
    main="Beneficus",sub={name="Genbu's Shield",priority=-1},ammo="Incantor Stone",
    head=Vanya_head_FC,neck="Colossus's Torque",left_ear="Loquac. Earring",
    body=Empy_body,hands=AF_hands,left_ring="Ephedra Ring",right_ring="Ephedra Ring",
    back="Alaunus's Cape",waist="Austerity Belt",legs=Relic_legs,feet=Vanya_feet}

  sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast,{head=Empy_head,hands=Empy_hands,legs=Empy_legs})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
  sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
    main="Daybreak",sub={name="Ammurapi Shield",priority=-1},
    hands="Augur's Gloves",
    feet=Empy_feet})

  sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",
    head="Inyanga Tiara +1",
    body=Relic_body,hands=Empy_hands})

  sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod"})

  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
    neck="Nodens Gorget",right_ear="Earthcry Earring",
    waist="Siegel Sash",legs="Haven Hose"})

  sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
    main="Beneficus",sub={name="Genbu's Shield",priority=-1},
    head=Empy_head,
    body="Blessed Briault",hands=Empy_hands,
    legs=Relic_legs,feet=Empy_feet})

  sets.midcast.bar_status  = sets.midcast.BarElement

  sets.midcast['Auspice'] = set_combine(sets.midcast['Enhancing Magic'], {feet=Empy_feet})

  -- no skill bassed buffs
  sets.midcast['Haste'] = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast['Reraise'] = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast['Sneak'] = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast['Invisible'] = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast['Erase'] = set_combine(sets.midcast['Enhancing Magic'], {neck="Cleric's Torque"})

  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'],{ring1="Sheltered Ring"})
  sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{ring1="Sheltered Ring",feet=Relic_feet})
  sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'],{ring1="Sheltered Ring"})
  sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{ring1="Sheltered Ring",legs=Relic_legs})

  sets.midcast.Trust = set_combine(sets.midcast.FastRecast, {body="Apururu Unity Shirt"})


  sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast,{})

  sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast,{})

  -- Custom spell classes
  sets.midcast.MndEnfeebles = {
    main="Grioavolr",sub={name="Clerisy Strap",priority=-1},
    head="Inyanga Tiara +1",neck="Erra Pendant",left_ear="Gwati Earring",
    body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",left_ring="Kishar Ring",right_ring="Sangoma Ring",
    back="Veela Cape",waist="Salire Belt",legs="Inyanga Shalwar +2",feet="Inyan. Crackows +1"}

  sets.midcast.IntEnfeebles = set_combine( sets.midcast.MndEnfeebles, {})


  -- Sets to return to when not performing an action.

  -- Resting sets
  sets.resting = {
    main="Chatoyant Staff",sub={name="Irenic Strap",priority=-1},ammo="Clarus Stone",
    head="Oracle's Cap",neck="Eidolon Pendant",left_ear="Infused Earring",right_ear="Relaxing Earring",
    body=AF_body,hands="Oracle's Gloves",left_ring="Sheltered Ring",right_ring="Paguroidea Ring",
    back="Vita Cape",waist="Austerity Belt",legs="Assid. Pants +1",feet="Avocat Pigaches"}


  -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
  sets.idle = {
    main={ name="Queller Rod", augments={'MP+80','"Cure" potency +15%','Enmity-5',}},
    ammo="Staunch Tathlum",
    head="Inyanga Tiara +2",
	body="Witching Robe",
    hands="Inyanga Dastanas +2",
    legs="Assid. Pants +1",
    feet="Inspirited Boots",
    neck="Loricate Torque +1",
    waist="Fucho-no-obi",
    left_ear="Mendi. Earring",
    right_ear="Nourish. Earring",
    left_ring="Rahab Ring",
    right_ring="Inyanga Ring",
    back="Thauma. Cape",
}

  sets.idle.PDT = {
    main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Homiliary",
    head="Aya. Zucchetto +2",
    body="Inyanga Jubbah +2",
    hands="Aya. Manopolas +2",
    legs="Assid. Pants +1",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Defending Ring",
    right_ring="Warden's Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
}

  sets.idle.Town = set_combine(sets.idle, {})

  sets.idle.Weak = {
    main="Daybreak",sub={name="Genbu's Shield",priority=-1},ammo="Homiliary",
    head="Inyanga Tiara +1",neck="Loricate Torque +1",left_ear="Infused Earring",right_ear="Ethereal Earring",
    body=AF_body,hands="Serpentes Cuffs",left_ring="Sheltered Ring",right_ring="Paguroidea Ring",
    back="Solemnity Cape",legs="Assid. Pants +1",feet="Herald's Gaiters"}

  -- Defense sets

  sets.defense.PDT = {
    main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Homiliary",
    head="Aya. Zucchetto +2",
    body="Inyanga Jubbah +2",
    hands="Aya. Manopolas +2",
    legs="Assid. Pants +1",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Defending Ring",
    right_ring="Warden's Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
}

  sets.defense.MDT = {
    main="Chatoyant Staff",sub={name="Irenic Strap",priority=-1},ammo="Homiliary",
    head="Inyanga Tiara +1",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Merman's Earring",
    body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",left_ring="Minerva's Ring",right_ring=Dark_ring_MDT,
    back="Solemnity Cape",legs="Inyanga Shalwar +2",feet="Inyan. Crackows +1"}

  sets.Kiting = {feet="Herald's Gaiters"}

  sets.latent_refresh = {waist="Fucho-no-obi"}

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Basic set for if no TP weapon is defined.
  sets.engaged = {
    main="Werebuster",sub={name="Genbu's Shield",priority=-1},
    head="Aya. Zucchetto +1",neck="Asperity Necklace",left_ear="Brutal Earring",right_ear="Cessance Earring",
    body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",left_ring="Rajas Ring",right_ring="Apate Ring",
    waist="Witful Belt",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}

  -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
  sets.JSE_neck = {neck="Cleric's Torque"}
end