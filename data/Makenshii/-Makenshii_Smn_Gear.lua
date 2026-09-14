-- Setup vars that are user-dependent.  Can override this function in a sidecar.
function user_job_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal','PDT')
	state.Weapons:options('None')

    gear.perp_staff = {}
	
    send_command('bind @` input /ja "Release" <me>;input /macro book 18;wait 1;input /macro set 1')
	send_command('bind !` input /ja "Assault" <t>')
	send_command('bind ^` gs c toggle PactSpamMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	
    select_default_macro_book()
end

function user_job_lockstyle()
		windower.chat.input('/lockstyleset 7')
end

function user_job_self_command(commandArgs, eventArgs)
    local cmd = commandArgs[1];

    if cmd == 'FullBuff' then
    end

    if cmd == 'Rebuff' then
    end

    if cmd == 'CrowdControl' then
        return send_command('input /shocksquall')
    end

    if cmd == 'Nuke1' then
        currentAvatar = pet.name
        nukePact = pacts.magical[currentAvatar]

        if nukePact then
            send_command('input /' .. nukePact .. ' <bt>')
        end
    end

    if cmd == 'Nuke2' then
        return send_command('gs c elemental helix')
    end
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    gear.ambu = {
        phys = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10'}},
        mag = { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10',}}
    }
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {  } --head = "Glyphic Horn"
    
    sets.precast.JA['Elemental Siphon'] = sets.precast.BloodPactWard

    sets.precast.JA['Mana Cede'] = {}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {
        main = "Espiritus", 
        sub = "Vox Grip",
        ammo="Sancus Sachet +1",
        head="Con. Horn +1",
        body={ name="Apo. Dalmatica +1", augments={'Pet: Attack+25','Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+8',}},
        hands={ name="Glyphic Bracers", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
        legs="Beck. Spats +1",
        feet="Beck. Pigaches",
        neck="Caller's Pendant",
        waist="Lucidity Sash",
        left_ear="Evans Earring",
        right_ear="Caller's Earring",
        left_ring="Evoker's Ring",
        right_ring="Stikini Ring +1",
        back="Samanisi Cape",
    } 
		
    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        main={ name="Grioavolr", augments={'Blood Pact Dmg.+7','Pet: VIT+2','Pet: Mag. Acc.+25','Pet: "Mag.Atk.Bns."+13','DMG:+4',}},
        sub="Magic Strap",
        ammo="Pemphredo Tathlum",
        head="Nahtirah Hat",
        body="Shango Robe",
        hands={ name="Glyphic Bracers", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
        legs={ name="Lengo Pants", augments={'INT+9','Mag. Acc.+15','"Mag.Atk.Bns."+14',}},
        feet="Regal Pumps",
        neck="Caller's Pendant",
        waist="Channeler's Stone",
        left_ear="Loquac. Earring",
        right_ear="Infused Earring",
        left_ring="Prolix Ring",
        right_ring="Stikini Ring +1",
        back="Samanisi Cape",,
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {})       
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {})
	
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}
	
    sets.midcast.Cure = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        head = "Vanya Hood",
        neck = "Nodens Gorget",
        ear1 = "Mendicant's Earring",
        ear2 = "Magnetic Earring",
        body = "Zendik Robe",
        hands = gear.inyanga.hands,
        ring1 = "Lebeche Ring",
        ring2 = "Kuchekula Ring",
        back = "Thauma. Cape",
        legs = "Lengo Pants",
        feet = "Vanya Clogs"
    }
		
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Summoning Magic'] = {}
		
	sets.midcast['Elemental Magic'] = {}
		
	sets.midcast['Elemental Magic'].Resistant = {}
		
    sets.midcast['Elemental Magic'].OccultAcumen = {}
		
	sets.midcast.Impact = {}
		
	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})

    sets.midcast['Divine Magic'] = {}
		
    sets.midcast['Dark Magic'] = {}
	
	sets.midcast.Drain = {}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
    sets.midcast.Stun = {}
		
    sets.midcast.Stun.Resistant = {}
		
	sets.midcast['Enfeebling Magic'] = {}
		
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
		
	sets.midcast['Enhancing Magic'] = {}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { neck="Nodens Gorget", waist="Siegel Sash" })
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {
        main = "Espiritus",
        sub = "Vox Grip",
        ammo = "Sancus Sachet +1",
        head = "Beckoner's Horn +1",
        neck = "Incanter's Torque",
        ear1 = "C. Palug Earring",
        ear2 = "Lodurr Earring",
        body = "Baayami Robe",
        hands = "Baayami Cuffs",
        ring1 = "Evoker's Ring",
        ring2 = "Stikini Ring",
        back = "Conveyance Cape",
        waist = "Lucidity Sash",
        legs = "Baayami Slops",
        feet = "Baayami Sabots",
    }

    sets.midcast.Pet.DebuffBloodPactWard = sets.midcast.Pet.BloodPactWard
    sets.midcast.Pet.PhysicalBloodPactRage = {
        main = "Gridarvor",
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = "Helios Band",
        neck = "Shulmanu Collar",
        ear1 = "Gelos Earring",
        ear2 = "Lugalbanda Earring",
        body = "Con. Doublet +3",
        hands = gear.merlinic_physpact_hands,
        ring1 = "C. Palug Ring",
        ring2 = "Varar Ring +1",
        back = gear.ambu.phys,
        waist = "Incarnation Sash",
        legs = "Apogee Slacks +1",
        feet = "Helios Boots",
    }

    sets.midcast.Pet.MagicalBloodPactRage = {
        main = "Grioavolr",
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = "C. Palug Crown",
        neck = "Adad Amulet",
        ear1 = "Gelos Earring",
        ear2 = "Lugalbanda Earring",
        body = "Con. Doublet +3",
        hands = gear.merlinic_magpact_hands,
        ring1 = "Varar Ring +1",
        ring2 = "Varar Ring +1",
        back = gear.ambu.mag,
        waist = "Regal Belt",
        legs = "Enticer's Pants",
        feet = "Apogee Pumps +1",
    }

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {} --legs="Summoner's Spats"
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {}) --legs="Summoner's Spats"
	sets.midcast.Pet['Impact'] = sets.midcast.Pet.DebuffBloodPactWard
	sets.midcast.Pet['Flaming Crush'] = {
        main = "Grioavolr",
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = "C. Palug Crown",
        neck = "Adad Amulet",
        ear1 = "Gelos Earring",
        ear2 = "Lugalbanda Earring",
        body = "Apo. Dalmatica +1",
        ring1 = "Varar Ring +1",
        ring2 = "Varar Ring +1",
        back = gear.ambu.mag,
        waist = "Regal Belt",
        legs = "Apogee Slacks +1",
        feet = "Apogee Pumps +1",
    }
    sets.midcast.Pet['Burning Strike'] = sets.midcast.Pet['Flaming Crush']
	sets.midcast.Pet['Mountain Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {})
	sets.midcast.Pet['Rock Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {})
	sets.midcast.Pet['Crescent Fang'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {})
	sets.midcast.Pet['Eclipse Bite'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {})
	sets.midcast.Pet['Blindside'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {})

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {
        main = "Malignance Pole",
        sub = "Mensch Strap",
        head = "Beckoner's Horn +1",
        ear1 = "C. Palug Earring",
        ear2 = "Odnowa Earring +1",
        body = "Apo. Dalmatica +1",
        hands = gear.merlinic_refresh_hands,
        ring1 = "Defending Ring",
        ring2 = "Varar Ring +1",
        back = gear.ambu.phys,
        waist = "Fucho-no-obi",
        legs = "Assid. Pants +1",
        feet = "Apogee Pumps +1",
    }

    sets.idle.PDT = sets.idle;
		
    sets.idle.Avatar = set_combine(sets.idle, {
        main = "Gridarvor",
        ammo = "Sancus Sachet +1",
        neck = "Caller's Pendant",
        ring2 = "Evoker's Ring",
        waist = "Isa Belt",
    });
    sets.idle.PDT.Avatar = set_combine(sets.idle.PDT, {
        main = "Gridarvor",
        ammo = "Sancus Sachet +1",
        neck = "Caller's Pendant",
        waist = "Isa Belt",
        feet = "Apogee Pumps +1",
    })
    sets.idle.Spirit = sets.idle.Avatar
    sets.idle.PDT.Spirit = sets.idle.PDT.Avatar
		
    sets.idle.Avatar.Engaged = sets.idle.Avatar
        
    sets.perp = sets.idle.Avatar
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

    -- Defense sets
    sets.defense.PDT = sets.idle.PDT
    sets.defense.MDT = sets.idle.PDT
    sets.defense.MEVA = sets.idle.PDT
		
    sets.Kiting = {}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.HPDown = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}

	-- Weapons sets

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {
        head = "Blistering Sallet +1",
        neck = 'Sanctity Necklace',
        ear1 = 'Mache Earring +1',
        ear2 = 'Brutal Earring',
        body = gear.jhakri.body,
        hands = gear.jhakri.hands,
        ring1 = 'Petrov Ring',
        ring2 = 'Rajas Ring',
        waist = 'Windbuffet Belt +1',
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
    }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 18)
end