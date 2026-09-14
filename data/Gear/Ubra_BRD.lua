-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('None', 'Normal', 'Acc')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'PDT')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')

  state.Pianissimo          = M(false, 'Pianissimo All Songs')
  state.SingingMode:set('Extra_Length')

  MA_needed = 0
  H2H = false

  send_command('gi update')
  update_combat_form()

  -- Additional local binds
	--send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	--send_command('bind ^` gs c toggle Pianissimo')
	--send_command('bind ^] gs c cycle SingingMode')
	--send_command('bind ^e gs c cycle ExtraSongsMode')
  	--send_command('alias follow input //exec followu.txt')
	--send_command('bind ^f follow')
	--send_command('@wait 5;input /lockstyleset 96')
	--send_command('alias warp input //exec warp.txt')
	--send_command('gi ugs true')

  select_default_macro_book()

  old_inform = {}
  settings = load_settings()
  text_box = texts.new(settings.display)
  text_box:register_event('reload', initialize)

  initialize(text_box)

  local msg = ''
  msg = ('You have loaded Akyrey\'s BRD lua. Please use '):color(text_color) .. ('\"\/\/GS c help\" '):color(Notification_color) .. ('for a full list of key bound functions. Enjoy!'):color(text_color)
  add_to_chat(122, msg)
end

function user_unload()
  --send_command('unbind !`')
  --send_command('unbind ^`')
  --send_command('unbind ^]')
  --send_command('unbind ^e')
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  set_macro_page(1, 10)
end


function init_gear_sets()
  print('Akyrey_BRD_Gear.lua sidecar loaded')
  --------------------------------------
  -- AF - Relic - Empy
  --------------------------------------
  AF_head             ={ name="Brioso Roundlet +3" }
  AF_body             ={ name="Brioso Justaucorps" }
  AF_hands            ={ name="Brioso Cuffs" }
  AF_legs             ={ name="Brioso Cannions +2" }
  AF_feet             ={ name="Brioso Slippers +1" }

  Relic_head          ={ name="Bihu Roundlet +3", augments={'Enhances "Foe Sirvente" effect',}}
  Relic_body          ={ name="Bihu Justaucorps +3", augments={'Enhances "Troubadour" effect',}}
  Relic_hands         ={ name="Bihu Cuffs +3", augments={'Enh. "Adventurer\'s Dirge" effect',}}
  Relic_legs          ={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}}
  Relic_feet          ={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}}

  Empy_head           ={ name="Fili Calot +1" }
  Empy_body           ={ name="Fili Hongreline +1" }
  Empy_hands          ={ name="Fili Manchettes" }
  Empy_legs           ={ name="Fili Rhingrave" }
  Empy_feet           ={ name="Fili Cothurnes" }

  --------------------------------------
  -- Augemnted Gear
  --------------------------------------
  -- Grioavolr_Enh    ={ name="Grioavolr", augments={'Enh. Mag. eff. dur. +9','Mag. Acc.+20','"Mag.Atk.Bns."+9','Magic Damage +9',}}
  -- Kali_Macc      ={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}} --Path D

  Arka_IV             ={ name="Arka IV", augments={'"Cure" potency +24%',}}
  Vanya_head_FC       ={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}
  Vanya_body          ={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
  Vanya_feet          ={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}
  Cure_pot_head       ={ name="Gende. Caubeen +1", augments={'Phys. dmg. taken -1%','"Cure" potency +6%',}}

  FC_hands            ={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -5%',}}

  FC_back             ={ name="Swith Cape", 

  --------------------------------------
  -- Start defining the sets
  --------------------------------------

  -- Precast Sets

  -- Precast sets to enhance JAs
  sets.precast.JA.Nightingale = {feet=Relic_feet}
  sets.precast.JA.Troubadour = {body=Relic_body}
  sets.precast.JA['Soul Voice'] = {legs=Relic_legs}

  -- Fast cast sets for spells
  -- Kali                   7% FC
  -- Vanya Hood             10% FC
  -- Loquacious Earring     2% FC
  -- Inyanga Jubbah +2      13% FC
  -- Gendewitha Gages       7% FC
  -- Kishar Ring            4% FC
  -- Lebeche Ring                       2% QM
  -- Intarabus's Cape       10% FC
  -- Witful Belt            3% FC
  -- Aya. Cosciales +2      5% FC
  -- Rostrum Pumps          3% FC
  ---------------------------------------------------------------
  -- Total =                64% FC      2% QM
  -------------------------------------------------------------------------------------------------------
  -- Total = 64% Cast Speed + 2% QM
  sets.precast.FC = {
    main="Kali",
    --sub="Ajja Knife",
    range="Daurdabla",
    head="Nahtirah Hat",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','Song spellcasting time -4%',}},
    legs="Aya. Cosciales +2",
    feet=Relic_feet,
    neck="Voltsurge Torque",
    waist="Dynamic Belt",
    right_ear="Ethereal Earring",
    left_ear="Etiolation Earring",
    left_ring="Weather. Ring",
    right_ring="Inyanga Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
}

  -- Fast cast set for songs
  -- Kali                     7% FC
  -- Fili Calot +1                           -13% SScT
  -- Aoidos' Matinee                      -3% SScT
  -- Loquacious Earring       2% FC
  -- Inyanga Jubbah +2        13% FC
  -- Gendewitha Gages +1      7% FC       -5% SScT
  -- Kishar Ring              4% FC
  -- Lebeche Ring                                       2% QM
  -- Intarabus's Cape         10% FC
  -- Witful Belt              3% FC
  -- Aya. Cosciales +2        5% FC
  -- Bihu Slippers +1                     -8% SScT
  ---------------------------------------------------------------
  -- Total                    51% FC      -29% SScT     2% QM
  -------------------------------------------------------------------------------------------------------
  -- Total = 80% Cast Speed + 2% QM
  sets.precast.FC.BardSong = {
	range="Daurdabla",
    head="Fili Calot +1",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','Song spellcasting time -4%',}},
    legs="Aya. Cosciales +2",
    feet=Relic_feet,
    neck="Voltsurge Torque",
    waist="Embla Sash",
    right_ear="Ethereal Earring",
    left_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
}


  sets.precast.FC.BardSong['Honor March'] = set_combine(sets.precast.FC.BardSong, {range={name='Marsyas',priority = 16},})


  -- Fast cast sets for spells
  -- Base FC                64% FC                      2% QM
  -- Pahtli Cape                          -8% CScT
  -- Vanya Clogs                          -15% CScT
  ---------------------------------------------------------------
  -- Total =                64% FC        -23% CScT     2% QM
  -------------------------------------------------------------------------------------------------------
  -- Total = 86% Cast Speed + 2% QM
  sets.precast.FC.Cure = set_combine(sets.precast.FC, {back="Pahtli Cape",feet=Vanya_feet})

  sets.precast.FC.Raise = set_combine(sets.precast.FC, {right_ring="Veneficium Ring"})


  -- Base FC                64% FC                      2% QM
  -- Siegel Sash =                        -8% EMcT
  ---------------------------------------------------------------
  -- Total =                64% FC        -8% EMcT      2% QM
  -------------------------------------------------------------------------------------------------------
  -- Total = 71% Cast Speed + 2% QM
  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})


  -- Base FC                71% FC                      2% QM
  -- Carapacho Cuffs                      -15% SScT
  ---------------------------------------------------------------
  -- Total =                71% FC        -15% EMcT     2% QM
  -------------------------------------------------------------------------------------------------------
  -- Total = 86% Cast Speed + 2% QM
  sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {hands="Carapacho Cuffs"})

  sets.precast.FC.Daurdabla = {range={name='Daurdabla',priority = 16},}

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {}


  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
	range={ name="Linos", augments={'Accuracy+10 Attack+10','Weapon skill damage +2%','Quadruple Attack +3',}},
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Mache Earring +1",
    right_ear="Mache Earring +1",
    left_ring="Ilabrat Ring",
    right_ring="Petrov Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  sets.precast.WS['Evisceration'] = {
	range={ name="Linos", augments={'Accuracy+10 Attack+10','Weapon skill damage +3%','STR+5 DEX+5',}},
    head="Aya. Zucchetto +2",
    body=Relic_body,
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Mache Earring +1",
    right_ear="Mache Earring +1",
    left_ring="Ilabrat Ring",
    right_ring="Petrov Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

  sets.precast.WS["Rudra's Storm"] = {
	range={ name="Linos", augments={'Accuracy+10 Attack+10','Weapon skill damage +3%','STR+5 DEX+5',}},
	head="Aya. Zucchetto +2",
    body=Relic_body,
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Bard's Charm +1",
    waist="Grunfeld Rope",
    left_ear="Moonshade Earring",
    right_ear="Mache Earring +1",
    left_ring="Ilabrat Ring",
    right_ring="Petrov Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

  sets.precast.WS['Mordant Rime'] = {
	range={ name="Linos", augments={'Accuracy+14','Weapon skill damage +2%','STR+6 CHR+6',}},
    head=Relic_head,neck="Bard's Charm +1",ear1="Ishvara Earring",ear2="Regal Earring",
    body=Relic_body,hands=Relic_hands,ring1="Metamorph Ring +1",ring2="Carbuncle Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Damage taken-5%',}},
	waist="Aristo Belt",legs=Relic_legs,feet=Relic_feet}


  -- Midcast Sets

  -- General set for recast times.
  sets.midcast.FastRecast = {
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','Song spellcasting time -4%',}},
    legs="Aya. Cosciales +2",
    feet=Relic_feet,
    neck="Moonbow Whistle +1",
    waist="Dynamic Belt",
    left_ear="Ethereal Earring",
    right_ear="Infused Earring",
    left_ring="Ayanmo Ring",
    right_ring="Inyanga Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
}

  sets.midcast['Enfeebling Magic'] = {
    head=AF_head,
    body=AF_body,
    hands=AF_hands,
    legs=AF_legs,
    feet=AF_feet,
    neck="Moonbow Whistle +1",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring",  --Metamorph ring +1
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}

  sets.midcast['Dia'] = set_combine(sets.midcast['Enfeebling Magic'], {})

  sets.midcast.SongRecast = {
	range={name='Gjallarhorn',priority = 16},
    head=Vanya_head_FC,neck="Moonbow Whistle +1",left_ear="Loquac. Earring",
    body=Relic_body,hands=Empy_hands,left_ring="Lebeche Ring",right_ring="Kishar Ring",
    back=FC_back,waist="Witful Belt",legs=Empy_legs,feet=Relic_feet}

  sets.midcast['Buff'] = {
	main="Carnwenhan", 
    range="Gjallarhorn",
    head=Empy_head,
    body=Empy_body,
    hands=Empy_hands,
    legs="Inyanga Shalwar +2",
    feet=AF_feet,
    neck="Moonbow Whistle +1",
    waist="Embla Sash",
    left_ear="Ethereal Earring",
    right_ear="Infused Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
}
	
	
  sets.midcast['Buff']['Paeon'] = set_combine(sets.midcast['Buff'], {head=AF_head})
  sets.midcast['Buff']['March'] = set_combine(sets.midcast['Buff'], {hands=Empy_hands})
  sets.midcast['Buff']['Honor March'] = set_combine(sets.midcast['Buff']['March'], {range={name='Marsyas',priority = 1}})
  sets.midcast['Buff']['Minuet'] = set_combine(sets.midcast['Buff'], {body=Empy_body})
  sets.midcast['Buff']['Madrigal'] = set_combine(sets.midcast['Buff'], {head=Empy_head})
  sets.midcast['Buff']['Ballad'] = set_combine(sets.midcast['Buff'], {legs=Empy_legs})
  sets.midcast['Buff']["Sentinel's Scherzo"] = set_combine(sets.midcast['Buff'], {feet=Empy_feet})
  sets.midcast['Buff']['Extra Length'] = set_combine(sets.midcast['Buff'], {})
  sets.midcast['Buff']['Extra Length']['Paeon'] = set_combine(sets.midcast['Buff']['Paeon'], {})
  sets.midcast['Buff']['Extra Length']['March'] = set_combine(sets.midcast['Buff']['March'], {})
  sets.midcast['Buff']['Extra Length']['Honor March'] = set_combine(sets.midcast['Buff']['Honor March'], {})
  sets.midcast['Buff']['Extra Length']['Minuet'] = set_combine(sets.midcast['Buff']['Minuet'], {body=Empy_body})
  sets.midcast['Buff']['Extra Length']['Madrigal'] = set_combine(sets.midcast['Buff']['Madrigal'], {head=Empy_head})
  sets.midcast['Buff']['Extra Length']['Ballad'] = set_combine(sets.midcast['Buff']['Ballad'], {legs=Empy_legs})
  sets.midcast['Buff']['Extra Length']["Sentinel's Scherzo"] = set_combine(sets.midcast['Buff']["Sentinel's Scherzo"], {feet=Empy_feet})

  sets.midcast['Debuff'] = {
    main="Carnwenhan",
    range="Gjallarhorn",
    head=AF_head,
    body=AF_body,
    hands=AF_hands,
    legs=Relic_legs,
    feet=AF_feet,
    neck="Moonbow Whistle +1",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring",  --Metamorph ring +1
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
}
	

	
	sets.precast.Lullaby = {
	range="Daurdabla",
    head="Nahtirah Hat",
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs=AF_legs,
    feet=AF_feet,
    neck="Voltsurge Torque",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Digni. Earring",
    left_ring="Weather. Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}
  sets.midcast['Debuff'].Resistant = set_combine(sets.midcast['Debuff'], {})
  sets.midcast['Debuff']['F-Lullaby'] = set_combine(sets.midcast['Debuff'], {hands=AF_hands})
  sets.midcast['Debuff']['F-Lullaby'].Resistant = set_combine(sets.midcast['Debuff']['F-Lullaby'], {})
  sets.midcast['Debuff']['H-Lullaby'] = set_combine(sets.midcast['Debuff']['F-Lullaby'], {range="Blurred harp"})
  sets.midcast['Debuff']['H-Lullaby'].Resistant = set_combine(sets.midcast['Debuff']['F-Lullaby'].Resistant, {range="blurred harp"})

  -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
  sets.midcast['Dummy'] = {
    range={name='Daurdabla',priority = 16},
    head=Vanya_head_FC,neck="Aoidos' Matinee",left_ear="Loquac. Earring",
    body="Inyanga Jubbah +2",hands=FC_hands,ring1="Kishar Ring",ring2="Lebeche Ring",
    back=FC_back,waist="Witful Belt",legs=Empy_legs,feet=Relic_feet}

    -- Other general spells and classes.
  sets.midcast.Cure = {
    main="Daybreak",
    sub="Ammurapi Shield",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Vanya Robe",
    hands="Inyan. Dastanas +2",
    legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
    neck="Loricate Torque +1",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Mendi. Earring",
    left_ring="Rahab Ring",
    right_ring="Kishar Ring",
    back="Solemnity Cape",
}

  sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {})

  sets.midcast['Cure day / weather'] = set_combine(sets.midcast.Cure, {back="Twilight Cape",waist="Hachirin-no-Obi"})

  sets.midcast.Curaga = sets.midcast.Cure

  sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {
    main=Grioavolr_Enh,
    head=Kaykaus_head,neck="Incanter's Torque",ear1='Healing Earring',
    ring1="Ephedra Ring",ring2="Ephadra Ring",
    waist="Bishop's Sash",feet=Gendewitha_feet})

  sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
    main=Grioavolr_Enh,sub={name="Fulcio Grip",priority=-1},
    head=Telch_head_Enh,neck="Incanter's Torque",ear1='Andoaa Earring',
    body=Telch_body_Enh,hands=Telch_hands_Enh,
    back='Merciful Cape',waist="Olympus Sash",legs=Telch_legs_Enh,feet=Telch_Feet_Enh})

  sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +1"})

  sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {head=Chironic_head_Refr,waist="Emphatikos Rope"})

  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear1='Earthcry Earring',waist="Siegel Sash",legs="Haven Hose"})

  -- no skill bassed buffs
  sets.midcast['Haste'] = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast['Reraise'] = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast['Sneak'] = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast['Invisible'] = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {})

  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'],{ring1="Sheltered Ring"})
  sets.midcast.Protectra = sets.midcast.Protect
  sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'],{ring1="Sheltered Ring"})
  sets.midcast.Shellra = sets.midcast.Shell

  sets.midcast.Trust = set_combine(sets.midcast.FastRecast, {body="Apururu Unity Shirt"})


  -- Sets to return to when not performing an action.

  -- Resting sets
  sets.resting = set_combine(sets.idle.Weak, {
    main=gear.Staff.HMP,body="Inyanga Jubbah +2",range="Daurdabla",
    legs="Assiduity Pants +1"})

  -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
  sets.idle = {
    range="Gjallarhorn",
    head="Inyanga Tiara +2",neck="Bard's Charm +1",ear1="Etiolation Earring",ear2="Infused Earring",
    body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Inyanga Ring",ring2="Ayanmo Ring",
    back="Moonbeam Cape",waist="Fucho-no-Obi",legs="Assiduity Pants +1",feet=Empy_feet}

  sets.idle.PDT = {
    range="Gjallarhorn",
    head="Aya. Zucchetto +2",
    body="Inyanga Jubbah +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Ethereal Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Patricius Ring",
    back="Moonbeam Cape",
}

  sets.idle.Weak = {
    range="Gjallarhorn",
    head="Ayanmo Zucchetto",neck="Bard's Charm +1",ear1="Ethereal Earring",ear2="Infused Earring",
    body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Ayanmo Ring",ring2="Inyanga Ring",
    back="Moonbow Cape",waist="Chaac Belt",legs="Inyanga Shalwar +2",feet=Empy_feet}

  sets.idle.Town = set_combine(sets.idle, {range="Gjallarhorn"})


  -- Defense sets

  sets.defense.PDT = {
	main="Daybreak",
    range="Gjallarhorn",
    head="Aya. Zucchetto +2",
    body="Inyanga Jubbah +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Ethereal Earring",
    right_ear="Etiolation Earring",
    left_ring="Ayanmo Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}

  sets.defense.MDT = {
    range="Gjallarhorn",
    head="Inyanga Tiara +2",
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs="Inyanga Shalwar +2",
    feet=Relic_feet,
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Ethereal Earring",
    right_ear="Etiolation Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}

  sets.Kiting = {feet=Empy_feet}
  sets.CP = {back="Aptitude Mantle"}
  sets.latent_refresh = {waist="Fucho-no-obi"}

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Basic set for if no TP weapon is defined.
  sets.engaged = {
	main="Carnwenhan", 
	sub="Blurred Knife +1",
    range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +2',}},
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="bard's charm +1",
    waist="Windbuffet Belt +1",
	--right_ear="Mache Earring +1",
	--left_ear="Mache Earring +1",
    left_ear="Suppanomimi",  --nin sub w/o haste samba
    right_ear="Eabani Earring", --nin sub w/o haste samba
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

  sets.engaged.Acc = {
    main="Carnwenhan",
    --sub={ name="Skinflayer", augments={'Crit. hit damage +7%','DEX+5','Accuracy+15','Attack+17','DMG:+6',}},
    range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +2',}},
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Bard's Charm +1",
    waist="Grunfeld Rope",
    left_ear="Mache Earring +1",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

  sets.engaged.DW = {
    range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +2',}},
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="bard's charm +1",
    waist="Windbuffet Belt +1",
	--right_ear="Mache Earring +1",
	--left_ear="Mache Earring +1",
    left_ear="Suppanomimi",  --nin sub w/o haste samba
    right_ear="Eabani Earring", --nin sub w/o haste samba
    left_ring="Petrov Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

  sets.engaged.DW.Acc = {
	range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +2',}},
    head="Aya. Zucchetto +2",neck="Bard's Charm +1",ear1="Telos Earring",ear2="Cessance Earring",
    body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	waist="Windbuffet Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

  sets.buff.Reive = {neck="Adoulin's Refuge +1"}

  sets.Locked_Main_Sub = {main="Carnwenhan",sub={name="Culminus",priority=-1}}
  sets.Locked_Main_Sub_DW = {main="Carnwenhan",sub={name="Blurred Knife +1",priority=-1}}
end
