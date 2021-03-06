-- DruidBalance.lua
-- June 2018

local addon, ns = ...
local Hekili = _G[ addon ]

local class = Hekili.Class
local state = Hekili.State

local PTR = ns.PTR


if UnitClassBase( 'player' ) == 'DRUID' then
    local spec = Hekili:NewSpecialization( 102, true )

    spec:RegisterResource( Enum.PowerType.LunarPower, {
        fury_of_elune = {            
            aura = "fury_of_elune_ap",

            last = function ()
                local app = state.buff.fury_of_elune_ap.applied
                local t = state.query_time

                return app + floor( ( t - app ) / 0.5 ) * 0.5
            end,

            interval = 0.5,
            value = 2.5
        }
    } )


    spec:RegisterResource( Enum.PowerType.Mana )
    spec:RegisterResource( Enum.PowerType.Energy )
    spec:RegisterResource( Enum.PowerType.ComboPoints )
    spec:RegisterResource( Enum.PowerType.Rage )
    
    -- Talents
    spec:RegisterTalents( {
        natures_balance = 22385, -- 202430
        warrior_of_elune = 22386, -- 202425
        force_of_nature = 22387, -- 205636

        tiger_dash = 19283, -- 252216
        renewal = 18570, -- 108238
        wild_charge = 18571, -- 102401

        feral_affinity = 22155, -- 202157
        guardian_affinity = 22157, -- 197491
        restoration_affinity = 22159, -- 197492

        mighty_bash = 21778, -- 5211
        mass_entanglement = 18576, -- 102359
        typhoon = 18577, -- 132469

        soul_of_the_forest = 18580, -- 114107
        starlord = 21706, -- 202345
        incarnation = 21702, -- 102560

        stellar_drift = 22389, -- 202354
        twin_moons = 21712, -- 279620
        stellar_flare = 22165, -- 202347

        shooting_stars = 21648, -- 202342
        fury_of_elune = 21193, -- 202770
        new_moon = 21655, -- 274281
    } )

    
    -- PvP Talents
    spec:RegisterPvpTalents( { 
        adaptation = 3543, -- 214027
        relentless = 3542, -- 196029
        gladiators_medallion = 3541, -- 208683

        celestial_downpour = 183, -- 200726
        celestial_guardian = 180, -- 233754
        crescent_burn = 182, -- 200567
        cyclone = 857, -- 209753
        deep_roots = 834, -- 233755
        dying_stars = 822, -- 232546
        faerie_swarm = 836, -- 209749
        ironfeather_armor = 1216, -- 233752
        moon_and_stars = 184, -- 233750
        moonkin_aura = 185, -- 209740
        prickling_thorns = 3058, -- 200549
        protector_of_the_grove = 3728, -- 209730
        thorns = 3731, -- 236696
    } )

    
    spec:RegisterPower( "lively_spirit", 279642, {
        id = 279648,
        duration = 20,
        max_stack = 1,
    } )


    -- Auras
    spec:RegisterAuras( {
        aquatic_form = {
            id = 276012,
        },
        astral_influence = {
            id = 197524,
        },
        barkskin = {
            id = 22812,
            duration = 12,
            max_stack = 1,
        },
        bear_form = {
            id = 5487,
            duration = 3600,
            max_stack = 1,
        },
        blessing_of_cenarius = {
            id = 238026,
            duration = 60,
            max_stack = 1,
        },
        blessing_of_the_ancients = {
            id = 206498,
            duration = 3600,
            max_stack = 1,
        },
        cat_form = {
            id = 768,
            duration = 3600,
            max_stack = 1,
        },
        celestial_alignment = {
            id = 194223,
            duration = 20,
            max_stack = 1,
        },
        dash = {
            id = 1850,
            duration = 10,
            max_stack = 1,
        },
        eclipse = {
            id = 279619,
        },
        empowerments = {
            id = 279708,
        },
        entangling_roots = {
            id = 339,
            duration = 30,
            type = "Magic",
            max_stack = 1,
        },
        feline_swiftness = {
            id = 131768,
        },
        flask_of_the_seventh_demon = {
            id = 188033,
            duration = 3600.006,
            max_stack = 1,
        },
        flight_form = {
            id = 276029,
        },
        force_of_nature = {
            id = 205644,
            duration = 15,
            max_stack = 1,
        },
        frenzied_regeneration = {
            id = 22842,
            duration = 3,
            max_stack = 1,
        },
        fury_of_elune_ap = {
            id = 202770,
            duration = 8,
            max_stack = 1,
    
            generate = function ()
                local foe = buff.fury_of_elune_ap
                local applied = action.fury_of_elune.lastCast
    
                if applied and now - applied < 8 then
                    foe.count = 1
                    foe.expires = applied + 8
                    foe.applied = applied
                    foe.caster = "player"
                    return
                end
    
                foe.count = 0
                foe.expires = 0
                foe.applied = 0
                foe.caster = "nobody"
            end,
        },
        growl = {
            id = 6795,
            duration = 3,
            max_stack = 1,
        },
        incarnation = {
            id = 102560,
            duration = 30,
            max_stack = 1,
            copy = "incarnation_chosen_of_elune"
        },
        ironfur = {
            id = 192081,
            duration = 7,
            max_stack = 1,
        },
        legionfall_commander = {
            id = 233641,
            duration = 3600,
            max_stack = 1,
        },
        lunar_empowerment = {
            id = 164547,
            duration = 45,
            type = "Magic",
            max_stack = 3,
        },
        mana_divining_stone = {
            id = 227723,
            duration = 3600,
            max_stack = 1,
        },
        mass_entanglement = {
            id = 102359,
            duration = 30,
            type = "Magic",
            max_stack = 1,
        },
        mighty_bash = {
            id = 5211,
            duration = 5,
            max_stack = 1,
        },
        moonfire = {
            id = 164812,
            duration = 22,
            tick_time = function () return 2 * haste end,
            type = "Magic",
            max_stack = 1,
        },
        moonkin_form = {
            id = 24858,
            duration = 3600,
            max_stack = 1,
        },
        prowl = {
            id = 5215,
            duration = 3600,
            max_stack = 1,
        },
        regrowth = {
            id = 8936,
            duration = 12,
            type = "Magic",
            max_stack = 1,
        },
        shadowmeld = {
            id = 58984,
            duration = 3600,
            max_stack = 1,
        },
        sign_of_the_critter = {
            id = 186406,
            duration = 3600,
            max_stack = 1,
        },
        solar_beam = {
            id = 81261,
            duration = 3600,
            max_stack = 1,
        },
        solar_empowerment = {
            id = 164545,
            duration = 45,
            type = "Magic",
            max_stack = 3,
        },
        stag_form = {
            id = 210053,
            duration = 3600,
            max_stack = 1,
            generate = function ()
                local form = GetShapeshiftForm()
                local stag = form and form > 0 and select( 4, GetShapeshiftFormInfo( form ) )
                
                local sf = buff.stag_form

                if stag == 210053 then
                    sf.count = 1
                    sf.applied = now
                    sf.expires = now + 3600
                    sf.caster = "player"
                    return
                end

                sf.count = 0
                sf.applied = 0
                sf.expires = 0
                sf.caster = "nobody"
            end,
        },
        starfall = {
            id = 191034,
            duration = function () return pvptalent.celestial_downpour.enabled and 16 or 8 end,
            max_stack = 1,

            generate = function ()
                local sf = buff.starfall

                if now - action.starfall.lastCast < 8 then
                    sf.count = 1
                    sf.applied = action.starfall.lastCast
                    sf.expires = sf.applied + 8
                    sf.caster = "player"
                    return
                end

                sf.count = 0
                sf.applied = 0
                sf.expires = 0
                sf.caster = "nobody"
            end
        },
        starlord = {
            id = 279709,
            duration = 20,
            max_stack = 3,
        },
        stellar_drift = {
            id = 202461,
            duration = 3600,
            max_stack = 1,
        },
        stellar_flare = {
            id = 202347,
            duration = 24,
            tick_time = function () return 2 * haste end,
            type = "Magic",
            max_stack = 1,
        },
        sunfire = {
            id = 164815,
            duration = 18,
            tick_time = function () return 2 * haste end,
            type = "Magic",
            max_stack = 1,
        },
        thick_hide = {
            id = 16931,
        },
        thorny_entanglement = {
            id = 241750,
            duration = 15,
            max_stack = 1,
        },
        thrash_bear = {
            id = 192090,
            duration = 15,
            max_stack = 3,
        },
        thrash_cat ={
            id = 106830, 
            duration = function()
                local x = 15 -- Base duration
                return talent.jagged_wounds.enabled and x * 0.80 or x
            end,
            tick_time = function()
                local x = 3 -- Base tick time
                return talent.jagged_wounds.enabled and x * 0.80 or x
            end,
        },
        --[[ thrash = {
            id = function ()
                if buff.cat_form.up then return 106830 end
                return 192090
            end,
            duration = function()
                local x = 15 -- Base duration
                return talent.jagged_wounds.enabled and x * 0.80 or x
            end,
            tick_time = function()
                local x = 3 -- Base tick time
                return talent.jagged_wounds.enabled and x * 0.80 or x
            end,
        }, ]]
        tiger_dash = {
            id = 252216,
            duration = 5,
            max_stack = 1,
        },
        travel_form = {
            id = 783,
            duration = 3600,
            max_stack = 1,
        },
        treant_form = {
            id = 114282,
            duration = 3600,
            max_stack = 1,
        },
        typhoon = {
            id = 61391,
            duration = 6,
            type = "Magic",
            max_stack = 1,
        },
        warrior_of_elune = {
            id = 202425,
            duration = 3600,
            type = "Magic",
            max_stack = 3,
        },
        wild_charge = {
            id = 102401,
        },
        yseras_gift = {
            id = 145108,
        },
        -- Alias for Celestial Alignment vs. Incarnation
        ca_inc = {
            alias = { "celestial_alignment", "incarnation" },
            aliasMode = "first", -- use duration info from the first buff that's up, as they should all be equal.
            aliasType = "buff",
            duration = function () return talent.incarnation.enabled and 30 or 20 end,
        },


        -- PvP Talents
        celestial_guardian = {
            id = 234081,
            duration = 3600,
            max_stack = 1,
        },

        cyclone = {
            id = 209753,
            duration = 6,
            max_stack = 1,
        },

        faerie_swarm = {
            id = 209749,
            duration = 5,
            type = "Magic",
            max_stack = 1,
        },

        moon_and_stars = {
            id = 234084,
            duration = 10,
            max_stack = 1,
        },

        moonkin_aura = {
            id = 209746,
            duration = 18,
            type = "Magic",
            max_stack = 3,
        },

        thorns = {
            id = 236696,
            duration = 12,
            type = "Magic",
            max_stack = 1,
        },


        -- Azerite Powers
        dawning_sun = {
            id = 276153,
            duration = 8,
            max_stack = 1,
        },

        sunblaze = {
            id = 274399,
            duration = 20,
            max_stack = 1
        },
    } )


    spec:RegisterStateFunction( "break_stealth", function ()
        removeBuff( "shadowmeld" )
        if buff.prowl.up then
            setCooldown( "prowl", 6 )
            removeBuff( "prowl" )
        end
    end )


    -- Function to remove any form currently active.
    spec:RegisterStateFunction( "unshift", function()
        removeBuff( "cat_form" )
        removeBuff( "bear_form" )
        removeBuff( "travel_form" )
        removeBuff( "moonkin_form" )
        removeBuff( "travel_form" )
        removeBuff( "aquatic_form" )
        removeBuff( "stag_form" )
        removeBuff( "celestial_guardian" )
    end )
    

    -- Function to apply form that is passed into it via string.
    spec:RegisterStateFunction( "shift", function( form )
        removeBuff( "cat_form" )
        removeBuff( "bear_form" )
        removeBuff( "travel_form" )
        removeBuff( "moonkin_form" )
        removeBuff( "travel_form" )
        removeBuff( "aquatic_form" )
        removeBuff( "stag_form" )
        applyBuff( form )
        
        if form == "bear_form" and pvptalent.celestial_guardian.enabled then
            applyBuff( "celestial_guardian" )
        end
    end )


    spec:RegisterHook( "runHandler", function( ability )
        local a = class.abilities[ ability ]
    
        if not a or a.startsCombat then
            break_stealth()
        end 
    end )


    spec:RegisterStateExpr( "ap_check", function ()
        local a = this_action
        a = a and action[ this_action ]
        a = a and a.ap_check
    
        return a == true
    end )


    -- Simplify lookups for AP abilities consistent with SimC.
    local ap_checks = { 
        "force_of_nature", "full_moon", "half_moon", "lunar_strike", "moonfire", "new_moon", "solar_wrath", "starfall", "starsurge", "sunfire"
    }

    for i, lookup in ipairs( ap_checks ) do
        spec:RegisterStateExpr( lookup, function ()
            return action[ lookup ]
        end )
    end

    spec:RegisterStateExpr( "active_moon", function ()
        return "new_moon"
    end )

    local function IsActiveSpell( id )
        local slot = FindSpellBookSlotBySpellID( id )
        if not slot then return false end

        local _, _, spellID = GetSpellBookItemName( slot, "spell" )
        return id == spellID 
    end

    state.IsActiveSpell = IsActiveSpell
    
    spec:RegisterHook( "reset_precast", function ()
        if IsActiveSpell( class.abilities.new_moon.id ) then active_moon = "new_moon"
        elseif IsActiveSpell( class.abilities.half_moon.id ) then active_moon = "half_moon"
        elseif IsActiveSpell( class.abilities.full_moon.id ) then active_moon = "full_moon"
        else active_moon = nil end

        -- UGLY
        if talent.incarnation.enabled then
            rawset( cooldown, "ca_inc", cooldown.incarnation )
        else
            rawset( cooldown, "ca_inc", cooldown.celestial_alignment )
        end
    end )


    spec:RegisterHook( "spend", function( amt, resource )
        if level < 116 and equipped.impeccable_fel_essence and resource == "astral_power" and cooldown.celestial_alignment.remains > 0 then
            setCooldown( "celestial_alignment", max( 0, cooldown.celestial_alignment.remains - ( amt / 12 ) ) )
        end 
    end )


    -- Legion Sets (for now).
    spec:RegisterGear( 'tier21', 152127, 152129, 152125, 152124, 152126, 152128 )
        spec:RegisterAura( 'solar_solstice', {
            id = 252767,
            duration = 6,
            max_stack = 1,
         } ) 

    spec:RegisterGear( 'tier20', 147136, 147138, 147134, 147133, 147135, 147137 )
    spec:RegisterGear( 'tier19', 138330, 138336, 138366, 138324, 138327, 138333 )
    spec:RegisterGear( 'class', 139726, 139728, 139723, 139730, 139725, 139729, 139727, 139724 )

    spec:RegisterGear( "impeccable_fel_essence", 137039 )    
    spec:RegisterGear( "oneths_intuition", 137092 )
        spec:RegisterAuras( {
            oneths_intuition = {
                id = 209406,
                duration = 3600,
                max_stacks = 1,
            },    
            oneths_overconfidence = {
                id = 209407,
                duration = 3600,
                max_stacks = 1,
            },
        } )

    spec:RegisterGear( "radiant_moonlight", 151800 )
    spec:RegisterGear( "the_emerald_dreamcatcher", 137062 )
        spec:RegisterAura( "the_emerald_dreamcatcher", {
            id = 224706,
            duration = 5,
            max_stack = 2,
        } )



    -- Abilities
    spec:RegisterAbilities( {
        barkskin = {
            id = 22812,
            cast = 0,
            cooldown = 60,
            gcd = "off",
            
            toggle = "defensives",
            defensive = true,

            startsCombat = false,
            texture = 136097,
            
            handler = function ()
                applyBuff( "barkskin" )
            end,
        },
        

        bear_form = {
            id = 5487,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            startsCombat = false,
            texture = 132276,

            noform = "bear_form",
            
            handler = function ()
                shift( "bear_form" )
            end,
        },
        

        cat_form = {
            id = 768,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            startsCombat = false,
            texture = 132115,

            noform = "cat_form",
            
            handler = function ()
                shift( "cat_form" )
            end,
        },
        

        celestial_alignment = {
            id = 194223,
            cast = 0,
            cooldown = 180,
            gcd = "spell",
            
            toggle = "cooldowns",

            startsCombat = true,
            texture = 136060,

            notalent = "incarnation",
            
            handler = function ()
                applyBuff( "celestial_alignment" )
                if pvptalent.moon_and_stars.enabled then applyBuff( "moon_and_stars" ) end
            end,

            copy = "ca_inc"
        },
        

        cyclone = {
            id = 209753,
            cast = 1.7,
            cooldown = 0,
            gcd = "spell",

            pvptalent = "cyclone",
            
            spend = 0.15,
            spendType = "mana",
            
            startsCombat = true,
            texture = 136022,
            
            handler = function ()
                applyDebuff( "target", "cyclone" )
            end,
        },
        

        dash = {
            id = 1850,
            cast = 0,
            cooldown = 120,
            gcd = "off",
            
            startsCombat = false,
            texture = 132120,

            notalent = "tiger_dash",
            
            handler = function ()
                if not buff.cat_form.up then
                    shift( "cat_form" )
                end
                applyBuff( "dash" )
            end,
        },
        

        --[[ dreamwalk = {
            id = 193753,
            cast = 10,
            cooldown = 60,
            gcd = "spell",
            
            spend = 4,
            spendType = "mana",
            
            toggle = "cooldowns",

            startsCombat = true,
            texture = 135763,
            
            handler = function ()
            end,
        }, ]]
        

        entangling_roots = {
            id = 339,
            cast = 1.7,
            cooldown = 0,
            gcd = "spell",
            
            spend = 0.18,
            spendType = "mana",
            
            startsCombat = false,
            texture = 136100,
            
            handler = function ()
                applyDebuff( "target", "entangling_roots" )
            end,
        },
        

        faerie_swarm = {
            id = 209749,
            cast = 0,
            cooldown = 30,
            gcd = "spell",
            
            pvptalent = "faerie_swarm",

            startsCombat = true,
            texture = 538516,
            
            handler = function ()
                applyDebuff( "target", "faerie_swarm" )
            end,
        },
        

        ferocious_bite = {
            id = 22568,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            spend = 50,
            spendType = "energy",
            
            startsCombat = true,
            texture = 132127,

            form = "cat_form",
            talent = "feral_affinity",
            
            usable = function () return combo_points.current > 0 end,
            handler = function ()
                --[[ if target.health.pct < 25 and debuff.rip.up then
                    applyDebuff( "target", "rip", min( debuff.rip.duration * 1.3, debuff.rip.remains + debuff.rip.duration ) )
                end ]]
                spend( combo_points.current, "combo_points" )
            end,
        },
        

        --[[ flap = {
            id = 164862,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            startsCombat = true,
            texture = 132925,
            
            handler = function ()
            end,
        }, ]]
        

        force_of_nature = {
            id = 205636,
            cast = 0,
            cooldown = 60,
            gcd = "spell",
            
            spend = -20,
            spendType = "astral_power",

            toggle = "cooldowns",

            startsCombat = true,
            texture = 132129,

            talent = "force_of_nature",

            ap_check = function()
                return astral_power.current - action.force_of_nature.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,
            
            handler = function ()
                summonPet( "treants", 10 )
            end,
        },
        

        frenzied_regeneration = {
            id = 22842,
            cast = 0,
            charges = 1,
            cooldown = 36,
            recharge = 36,
            gcd = "spell",
            
            spend = 10,
            spendType = "rage",
            
            startsCombat = false,
            texture = 132091,

            form = "bear_form",
            talent = "guardian_affinity",
            
            handler = function ()
                applyBuff( "frenzied_regeneration" )
                gain( 0.08 * health.max, "health" )
            end,
        },
        

        full_moon = {
            id = 274283,
            known = 274281,
            cast = 3,
            charges = 3,
            cooldown = 25,
            recharge = 25,
            gcd = "spell",
            
            spend = -40,
            spendType = "astral_power",

            texture = 1392542,
            startsCombat = true,

            talent = "new_moon",
            bind = "half_moon",

            ap_check = function()
                return astral_power.current - action.full_moon.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,            
            
            usable = function () return active_moon == "full_moon" end,
            handler = function ()
                spendCharges( "new_moon", 1 )
                spendCharges( "half_moon", 1 )

                -- Radiant Moonlight, NYI.
                active_moon = "new_moon"
            end,
        },
        

        fury_of_elune = {
            id = 202770,
            cast = 0,
            cooldown = 60,
            gcd = "spell",
            
            -- toggle = "cooldowns",

            startsCombat = true,
            texture = 132123,
            
            handler = function ()
                if not buff.moonkin_form.up then unshift() end
                applyDebuff( "target", "fury_of_elune_ap" )
            end,
        },
        

        growl = {
            id = 6795,
            cast = 0,
            cooldown = 8,
            gcd = "off",
            
            startsCombat = true,
            texture = 132270,

            form = "bear_form",
            
            handler = function ()
                applyDebuff( "target", "growl" )
            end,
        },
        

        half_moon = {
            id = 274282, 
            known = 274281,
            cast = 2,
            charges = 3,
            cooldown = 25,
            recharge = 25,
            gcd = "spell",

            spend = -20,
            spendType = "astral_power",
            
            texture = 1392543,
            startsCombat = true,

            talent = "new_moon",
            bind = "new_moon",
            
            ap_check = function()
                return astral_power.current - action.half_moon.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,
            
            usable = function () return active_moon == 'half_moon' end,
            handler = function ()
                spendCharges( "new_moon", 1 )
                spendCharges( "full_moon", 1 )

                active_moon = "full_moon"
            end,
        },
        

        hibernate = {
            id = 2637,
            cast = 1.5,
            cooldown = 0,
            gcd = "spell",
            
            spend = 0.15,
            spendType = "mana",
            
            startsCombat = false,
            texture = 136090,
            
            handler = function ()
                applyDebuff( "target", "hibernate" )
            end,
        },
        

        incarnation = {
            id = 102560,
            cast = 0,
            cooldown = 180,
            gcd = "spell",
            
            toggle = "cooldowns",

            startsCombat = false,
            texture = 571586,
            
            handler = function ()
                shift( "moonkin_form" )
                applyBuff( "incarnation" )

                if pvptalent.moon_and_stars.enabled then applyBuff( "moon_and_stars" ) end
            end,

            copy = "incarnation_chosen_of_elune"
        },
        

        innervate = {
            id = 29166,
            cast = 0,
            cooldown = 180,
            gcd = "spell",
            
            toggle = "cooldowns",

            startsCombat = false,
            texture = 136048,
            
            usable = function () return group end,
            handler = function ()
                active_dot.innervate = 1
            end,
        },
        

        ironfur = {
            id = 192081,
            cast = 0,
            cooldown = 0.5,
            gcd = "spell",
            
            spend = 45,
            spendType = "rage",
            
            startsCombat = true,
            texture = 1378702,
            
            handler = function ()
                applyBuff( "ironfur" )
            end,
        },
        

        lunar_strike = {
            id = 194153,
            cast = function () 
                if buff.warrior_of_elune.up then return 0 end
                return haste * ( buff.lunar_empowerment.up and 0.85 or 1 ) * 2.25 
            end,
            cooldown = 0,
            gcd = "spell",

            spend = function () return ( buff.warrior_of_elune.up and 1.4 or 1 ) * -12 end,
            spendType = "astral_power",
            
            startsCombat = true,
            texture = 135753,            

            ap_check = function()
                return astral_power.current - action.lunar_strike.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,            
            
            handler = function ()
                if not buff.moonkin_form.up then unshift() end
                removeStack( "lunar_empowerment" )
                removeStack( "warrior_of_elune" )

                if azerite.dawning_sun.enabled then applyBuff( "dawning_sun" ) end
            end,
        },
        

        mangle = {
            id = 33917,
            cast = 0,
            cooldown = 6,
            gcd = "spell",
            
            spend = -8,
            spendType = "rage",

            startsCombat = true,
            texture = 132135,

            talent = "guardian_affinity",
            form = "bear_form",
            
            handler = function ()
            end,
        },
        

        mass_entanglement = {
            id = 102359,
            cast = 0,
            cooldown = 30,
            gcd = "spell",
            
            startsCombat = false,
            texture = 538515,

            talent = "mass_entanglement",
            
            handler = function ()
                applyDebuff( "target", "mass_entanglement" )
                active_dot.mass_entanglement = max( active_dot.mass_entanglement, active_enemies )
            end,
        },
        

        mighty_bash = {
            id = 5211,
            cast = 0,
            cooldown = 50,
            gcd = "spell",
            
            startsCombat = true,
            texture = 132114,

            talent = "mighty_bash",
            
            handler = function ()
                applyDebuff( "target", "mighty_bash" )
            end,
        },
        

        moonfire = {
            id = 8921,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            spend = 0.06,
            spendType = "mana",
            
            startsCombat = true,
            texture = 136096,

            cycle = "moonfire",

            ap_check = function()
                return astral_power.current + 3 + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,                        
            
            handler = function ()
                if not buff.moonkin_form.up and not buff.bear_form.up then unshift() end
                applyDebuff( "target", "moonfire" )
                gain( 3, "astral_power" )
            end,
        },
        

        moonkin_form = {
            id = 24858,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            startsCombat = false,
            texture = 136036,

            noform = "moonkin_form",
            essential = true,
            
            handler = function ()
                shift( "moonkin_form" )
            end,
        },
        

        new_moon = {
            id = 274281, 
            cast = 1,
            charges = 3,
            cooldown = 25,
            recharge = 25,
            gcd = "spell",
            
            spend = -10,
            spendType = "astral_power",

            texture = 1392545,
            startsCombat = true,
            
            talent = "new_moon",
            bind = "full_moon",
            
            ap_check = function()
                return astral_power.current - action.new_moon.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,            
            
            usable = function () return active_moon == "new_moon" end,
            handler = function ()
                spendCharges( "half_moon", 1 )
                spendCharges( "full_moon", 1 )

                active_moon = "half_moon"
            end,
        },
        

        prowl = {
            id = 5215,
            cast = 0,
            cooldown = 6,
            gcd = "spell",
            
            startsCombat = true,
            texture = 514640,
            
            usable = function () return time == 0 end,
            handler = function ()
                shift( "cat_form" )
                applyBuff( "prowl" )
                removeBuff( "shadowmeld" )
            end,
        },
        

        rake = {
            id = 1822,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            spend = 35,
            spendType = "energy",
            
            startsCombat = true,
            texture = 132122,

            talent = "feral_affinity",
            form = "cat_form",
            
            handler = function ()
                applyDebuff( "target", "rake" )
            end,
        },
        

        --[[ rebirth = {
            id = 20484,
            cast = 2,
            cooldown = 600,
            gcd = "spell",
            
            spend = 0,
            spendType = "rage",
            
            -- toggle = "cooldowns",

            startsCombat = true,
            texture = 136080,
            
            handler = function ()
            end,
        }, ]]
        

        regrowth = {
            id = 8936,
            cast = 1.5,
            cooldown = 0,
            gcd = "spell",
            
            spend = 0.14,
            spendType = "mana",
            
            startsCombat = false,
            texture = 136085,
            
            handler = function ()
                if buff.moonkin_form.down then unshift() end
                applyBuff( "regrowth" )
            end,
        },
        

        rejuvenation = {
            id = 774,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            spend = 0.11,
            spendType = "mana",
            
            startsCombat = false,
            texture = 136081,

            talent = "restoration_affinity",
            
            handler = function ()
                if buff.moonkin_form.down then unshift() end
                applyBuff( "rejuvenation" )
            end,
        },
        

        remove_corruption = {
            id = 2782,
            cast = 0,
            cooldown = 8,
            gcd = "spell",
            
            spend = 0.06,
            spendType = "mana",
            
            startsCombat = true,
            texture = 135952,
            
            handler = function ()
            end,
        },
        

        renewal = {
            id = 108238,
            cast = 0,
            cooldown = 90,
            gcd = "spell",
            
            startsCombat = true,
            texture = 136059,

            talent = "renewal",
            
            handler = function ()
                -- unshift?
                gain( 0.3 * health.max, "health" )
            end,
        },
        

        --[[ revive = {
            id = 50769,
            cast = 10,
            cooldown = 0,
            gcd = "spell",
            
            spend = 0.04,
            spendType = "mana",
            
            startsCombat = true,
            texture = 132132,
            
            handler = function ()
            end,
        }, ]]
        

        rip = {
            id = 1079,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            spend = 30,
            spendType = "energy",
            
            startsCombat = true,
            texture = 132152,

            talent = "feral_affinity",
            form = "cat_form",

            usable = function () return combo_points.current > 0 end,
            handler = function ()
                spend( combo_points.current, "combo_points" )
                applyDebuff( "target", "rip" )
            end,
        },
        

        shred = {
            id = 5221,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            spend = 40,
            spendType = "energy",
            
            startsCombat = true,
            texture = 136231,

            talent = "feral_affinity",
            form = "cat_form",
            
            handler = function ()
                gain( 1, "combo_points" )
            end,
        },
        

        solar_beam = {
            id = 78675,
            cast = 0,
            cooldown = 60,
            gcd = "off",
            
            spend = 0.17,
            spendType = "mana",
            
            toggle = "interrupts",

            startsCombat = true,
            texture = 252188,
            
            debuff = "casting",
            readyTime = state.timeToInterrupt,

            handler = function ()
                if buff.moonkin_form.down then unshift() end
                interrupt()
            end,
        },
        

        solar_wrath = {
            id = 190984,
            cast = function () return haste * ( buff.solar_empowerment.up and 0.85 or 1 ) * 1.5 end,
            cooldown = 0,
            gcd = "spell",

            spend = -8,
            spendType = "astral_power",
            
            startsCombat = true,
            texture = 535045,
            
            ap_check = function()
                return astral_power.current - action.solar_wrath.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,            
            
            handler = function ()
                if not buff.moonkin_form.up then unshift() end
                removeStack( "solar_empowerment" )
                removeBuff( "dawning_sun" )
                if azerite.sunblaze.enabled then applyBuff( "sunblaze" ) end
            end,
        },
        

        soothe = {
            id = 2908,
            cast = 0,
            cooldown = 10,
            gcd = "spell",
            
            spend = 0.06,
            spendType = "mana",
            
            startsCombat = true,
            texture = 132163,
            
            usable = function () return debuff.dispellable_enrage.up end,
            handler = function ()
                if buff.moonkin_form.down then unshift() end
                removeDebuff( "target", "dispellable_enrage" )
            end,
        },
        

        stag_form = {
            id = 210053,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            startsCombat = false,
            texture = 1394966,

            noform = "travel_form",
            handler = function ()
                shift( "stag_form" )
            end,
        },
        

        starfall = {
            id = 191034,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            spend = function ()
                if buff.oneths_overconfidence.up then return 0 end
                return talent.soul_of_the_forest.enabled and 40 or 50
            end,
            spendType = "astral_power",
            
            startsCombat = true,
            texture = 236168,
            
            ap_check = function()
                return astral_power.current - action.starfall.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,            
            
            handler = function ()
                addStack( "starlord", buff.starlord.remains > 0 and buff.starlord.remains or nil, 1 )
                removeBuff( "oneths_overconfidence" )
                if level < 116 and set_bonus.tier21_4pc == 1 then
                    applyBuff( "solar_solstice" )
                end
            end,
        },
        

        starsurge = {
            id = 78674,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            spend = function ()
                if buff.oneths_intuition.up then return 0 end
                return 40 - ( buff.the_emerald_dreamcatcher.stack * 5 )
            end,
            spendType = "astral_power",
            
            startsCombat = true,
            texture = 135730,
            
            ap_check = function()
                return astral_power.current - action.starsurge.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,            
            
            handler = function ()
                addStack( "lunar_empowerment", nil, 1 )
                addStack( "solar_empowerment", nil, 1 )
                addStack( "starlord", buff.starlord.remains > 0 and buff.starlord.remains or nil, 1 )
                removeBuff( "oneths_intuition" )
                removeBuff( "sunblaze" )

                if pvptalent.moonkin_aura.enabled then
                    addStack( "moonkin_aura", nil, 1 )
                end

                if level < 116 and set_bonus.tier21_4pc == 1 then
                    applyBuff( "solar_solstice" )
                end
                if ( level < 116 and equipped.the_emerald_dreamcatcher ) then addStack( "the_emerald_dreamcatcher", 5, 1 ) end
            end,
        },
        

        stellar_flare = {
            id = 202347,
            cast = 1.5,
            cooldown = 0,
            gcd = "spell",

            spend = -8,
            spendType = "astral_power",
            
            startsCombat = true,
            texture = 1052602,
            cycle = "stellar_flare",

            talent = "stellar_flare",
            
            ap_check = function()
                return astral_power.current - action.stellar_flare.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,            
            
            handler = function ()
                applyDebuff( "target", "stellar_flare" )
            end,
        },
        

        sunfire = {
            id = 93402,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            spend = 0.12,
            spendType = "mana",
            
            startsCombat = true,
            texture = 236216,

            cycle = "sunfire",
            
            ap_check = function()
                return astral_power.current - action.sunfire.cost + ( talent.shooting_stars.enabled and 4 or 0 ) + ( talent.natures_balance.enabled and ceil( execute_time / 1.5 ) or 0 ) < astral_power.max
            end,            
            
            handler = function ()
                gain( 3, "astral_power" )
                applyDebuff( "target", "sunfire" )
            end,
        },
        

        swiftmend = {
            id = 18562,
            cast = 0,
            charges = 1,
            cooldown = 25,
            recharge = 25,
            gcd = "spell",
            
            spend = 0.14,
            spendType = "mana",
            
            startsCombat = false,
            texture = 134914,

            talent = "restoration_affinity",            
            
            handler = function ()
                if buff.moonkin_form.down then unshift() end
                gain( health.max * 0.1, "health" )
            end,
        },
        
        -- May want to revisit this and split out swipe_cat from swipe_bear.
        swipe = {
            known = 213764,
            cast = 0,
            cooldown = function () return haste * ( buff.cat_form.up and 0 or 6 ) end,
            gcd = "spell",

            spend = function () return buff.cat_form.up and 40 or nil end,
            spendType = function () return buff.cat_form.up and "energy" or nil end,
            
            startsCombat = true,
            texture = 134296,

            talent = "feral_affinity",

            usable = function () return buff.cat_form.up or buff.bear_form.up end,
            handler = function ()
                if buff.cat_form.up then
                    gain( 1, "combo_points" )
                end
            end,

            copy = { 106785, 213771 }
        },
        

        thrash = {
            id = 106832,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = -5,
            spendType = "rage",
            
            cycle = "thrash_bear",
            startsCombat = true,
            texture = 451161,

            talent = "guardian_affinity",
            form = "bear_form",
            
            handler = function ()
                applyDebuff( "target", "thrash_bear", nil, debuff.thrash.stack + 1 )
            end,
        },
        

        tiger_dash = {
            id = 252216,
            cast = 0,
            cooldown = 45,
            gcd = "off",
            
            startsCombat = false,
            texture = 1817485,

            talent = "tiger_dash",
            
            handler = function ()
                shift( "cat_form" )
                applyBuff( "tiger_dash" )
            end,
        },
        

        thorns = {
            id = 236696,
            cast = 0,
            cooldown = 45,
            gcd = "spell",

            pvptalent = "thorns",
            
            spend = 0.12,
            spendType = "mana",
            
            startsCombat = false,
            texture = 136104,
            
            handler = function ()
                applyBuff( "thorns" )
            end,
        },
        

        travel_form = {
            id = 783,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            startsCombat = false,
            texture = 132144,
            
            noform = "travel_form",
            handler = function ()
                shift( "travel_form" )
            end,
        },
        

        treant_form = {
            id = 114282,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            startsCombat = false,
            texture = 132145,
            
            handler = function ()
                shift( "treant_form" )
            end,
        },
        

        typhoon = {
            id = 132469,
            cast = 0,
            cooldown = 30,
            gcd = "spell",
            
            startsCombat = true,
            texture = 236170,

            talent = "typhoon",
            
            handler = function ()
                applyDebuff( "target", "typhoon" )
                if target.distance < 15 then setDistance( target.distance + 5 ) end
            end,
        },
        

        warrior_of_elune = {
            id = 202425,
            cast = 0,
            cooldown = 45,
            gcd = "spell",
            
            startsCombat = true,
            texture = 135900,

            talent = "warrior_of_elune",

            usable = function () return buff.warrior_of_elune.down end,
            handler = function ()
                applyBuff( "warrior_of_elune", nil, 3 )
            end,
        },
        

        --[[ wartime_ability = {
            id = 264739,
            cast = 0,
            cooldown = 0,
            gcd = "spell",
            
            startsCombat = true,
            texture = 1518639,
            
            handler = function ()
            end,
        }, ]]
        

        wild_charge = {
            id = function () return buff.moonkin_form.up and 102383 or 102401 end,
            known = 102401,
            cast = 0,
            cooldown = 15,
            gcd = "spell",
            
            startsCombat = false,
            texture = 538771,

            talent = "wild_charge",
            
            handler = function ()
                if buff.moonkin_form.up then setDistance( target.distance + 10 ) end
            end,

            copy = { 102401, 102383 }
        },
        

        wild_growth = {
            id = 48438,
            cast = 1.5,
            cooldown = 10,
            gcd = "spell",
            
            spend = 0.3,
            spendType = "mana",
            
            startsCombat = false,
            texture = 236153,

            talent = "wild_growth",
            
            handler = function ()
                unshift()
                applyBuff( "wild_growth" )
            end,
        },
    } )


    spec:RegisterOptions( {
        enabled = true,

        aoe = 3,
    
        nameplates = false,
        nameplateRange = 8,
        
        damage = true,
        damageDots = false,
        damageExpiration = 6,
    
        potion = "potion_of_rising_death",
    
        package = "Balance",        
    } )


    spec:RegisterPack( "Balance", 20190201.0110, [[dKefUaqiuHhHkYLePsBIQ0NOuIgLIYPuKwfiQEfLKzrv4wIu1UOYVaWWOk6yuclJs0ZuuzAGiUgLszBkI8nqKACkQY5OusRdeLENivK5HkQ7HkTpkvoOIOSqkPEiisMiikUiLsGnsPe6JukbDsfrvRuKmtrQO2jLIHksfwQIQYtb1uPu1Ej1Ff1Gv1HjwmepMIjd0Lr2ScFgKgTi60kTAfrLxlcZgLBtvTBv(njdhvDCfvvlxYZHA6cxhsBhe(oanEkLQZlsz9kcZhq7xQ1wOTxddkbPTXspTWw90spT05Pfw4Pf2QgosJN0W8IjHaL0WN4tAyRfMCgsdZlPXucO2EnmwHwgsdNmcEmKfaaGUrsueNr5daE9rzsSQZuYiaaV(gaqykeaqgs6bjiaGVuJLryashfnFYcIbiDmFzitHUGzRfMCgYHxFJggbDzXK)0iAyqjiTnw6Pf2QNw6PLopTWZ5zHLAybnsQknm86dP0Wjxqq60iAyqcB0WCQFRfMCgQFitHUGDko1FYi4Xqwaaa6gjrrCgLpa41hLjXQotjJaa86BaaHPqaaziPhKGaa(snwgHbiDu08jligG0X8LHmf6cMTwyYzihE9nDko1VTiHuOsLw)w6r)w6Pf2A)PVFp9eYABw0P6uCQFivs5GsyiBNIt9N((NmqqcSFyftQ(TMeFxNIt9N((HujLdkb2FifukY7OFJGjC)HQFtAggLdPGsb21P4u)PV)jdCYHIdcSF8ihsbLcC)qi1kimQ)HQ6xabvx)40UqSDxNIt9N((HxFE2osR)jBcQ2G6pkzJ(zkvcuEC)ZavNTm6hft9JEhzimwQ06hcPwbHr9Jt7cX2N66uCQ)03)8r(kiiW(tNxiiwA9dZV1g9Buh4gR66FOQ(HueJWXkS(Nm2c98PlsN6pnfQTKX6pPab1)g9RQ(ttH2pGQZwg9J3Zq9p5VJkiKG6FX9NCHMKQ(5RvvBKMtdZwCG12RHbPHGYcT9ABSqBVgwmXQonmwXKkJqIVgMobHrGAR1H2gl12RHPtqyeO2AnSP2GQv0WiOJHZi59mUI8L9W9Bx)tQFV9lMyHGY0r(lH7NB)wOHftSQtdZRIvD6qBZCA71W0jimcuBTgwmXQonmVkw1PHn1guTIggbDmCgjVNXvKVShUF76FsAyEvSQtdJirWOmVkw1LvJ8EbXyKj0H2girBVgMobHrGAR1WMAdQwrdJGogoJK3Z4q51WIjw1PHrykfyEGwPPdTn2M2EnmDccJa1wRHn1guTIggbDmCgjVNXHYRHftSQtdJqfMQe7bvhABMK2EnmDccJa1wRHn1guTIggbDmCgjVNXHYRHftSQtdlLrokhQQOl0H2giT2EnmDccJa1wRHn1guTIggbDmCgjVNXHYRHftSQtdZwOjdCEYHcc1NUqhABMN2EnmDccJa1wRHn1guTIggbDmCgjVNXHYRHftSQtdp2IqykfOo02yRA71W0jimcuBTg2uBq1kAye0XWzK8EghkVgwmXQonSCgchLWYgHX0H2gl8uBVgMobHrGAR1WN4tAyeHrJTOmsjNjPgwmXQonmIWOXwugPKZKudBQnOAfnmn)Olppb6qegn2IYiLCMK97TFJsXavaEoJK3Z4kYx2d3VD9pNN6qBJfwOTxdtNGWiqT1A4t8jnmyrcygktaxjufoJiGqjnSyIvDAyWIeWmuMaUsOkCgraHsAytTbvROHP5hD55jqhyrcygktaxjufoJiGqP(92VrPyGkapNrY7zCf5l7H73U(NZtDOTXcl12RHPtqyeO2An8j(KgwMaTOiPcNX7bLaZ8muFbkPHftSQtdltGwuKuHZ49GsGzEgQVaL0WMAdQwrdtZp6YZtGozc0IIKkCgVhucmZZq9fOu)E73OumqfGNZi59mUI8L9W9Bx)Z5Po02yXCA71W0jimcuBTg(eFsdhliHdv5NnkqY21WIjw1PHJfKWHQ8Zgfiz7AytTbvROHP5hD55jqxSGeouLF2OajBxhABSas02RHPtqyeO2AnSP2GQv0WgLIbQa8CgjVNXvKVShUF76Fop1WIjw1PHrXuEdYhRdTnwyBA71WIjw1PHbuQAvvwnYed9inmDccJa1wRdTnwmjT9Ay6eegbQTwdBQnOAfnSmbvBqo2cbXslJ53AdhDccJa73B)Z63OumqfGNBpJuNeR6Cf5l7H7NZ9Bz)ab2VrPyGkapNHyeowHLf2c98PlCf5l7H7NZ9BHL9pvdlMyvNgEVJkiKG0H2glG0A71W0jimcuBTg2uBq1kAybhLWY8kaPQF742pK4z)E7hufom6n2ICf5l7H73U(Nx)E7hufoFL6gBrUI8L9W9Bx)wyz)E7Fw)GQWHdIXKkpysrUI8L9W9Bx)tQFGa7NJ(dHrx4WbXysLhmPihDccJa7FQgwmXQon8EgPojw1PdTnwmpT9Ay6eegbQTwdBQnOAfnSGJsyzEfGu1VDC7hs8SFV9pRFo6xMGQnihBHGyPLX8BTHJobHrG9dey)iOJHJTqqS0Yy(T2WHY3)0(92)S(rqhdhoKIPkqhoetI(TJB)w2pqG9pR)z9Zr)HWOlC4qkMQaD0jimcSFGa7NJ(LjOAdYHJIKe7bnJdPWo6eegb2)0(92pOkCy0BSf5kYx2d3VD9Bz)E7hufoFL6gBrUynj2dA)E7Fw)GQWHdIXKkpysrUynj2dA)ab2ph9hcJUWHdIXKkpysro6eegb2)0(N2)unSyIvDAydXiCScllSf65txOdTnwyRA71W0jimcuBTg2uBq1kA4z9JGogoJK3Z4q57hiW(nkfdub45msEpJRiFzpC)21)CE2)0(92pwXKkdyjrsNWNnjjtcnSyIvDA4bALwwnYed9iDOTXsp12RHPtqyeO2AnSP2GQv0WZ6hbDmCgjVNXHY3pqG9BukgOcWZzK8Egxr(YE4(TR)58S)P97TFHpBssMeAyXeR60WdvzOSAKpjqlshABS0cT9Aye0XiFIpPHXHumvbQHPtqyeO2AnSP2GQv0WiOJHdhsXufORiFzpC)CU)51V3(5OFSIjvgWsIKoHpBssMeAyXeR60Wg5melJGog6qBJLwQTxdtNGWiqT1AytTbvROHN1pc6y4WHumvb6WHys0pN7FU(bcSFe0XWHdPyQc0vKVShUF742)86FA)E7hZtmwoKckf4(TJB)qi1kimYHh5qkOuG73B)Z6pKckfUy9PCOYGl1Vv9Br)t7hY7hZtmwoKckf4(TRFJch9NU9BPZ20WIjw1PHXHudHX0H2glNtBVgMobHrGAR1WMAdQwrdpR)qy0foCiftvGo6eegb2V3(N1pc6y4WHumvb6WHys0pN7FU(bcSFe0XWHdPyQc0vKVShUF742)863B)iOJHtkJCRjZJYWs5WHys0pN7FE9pTFGa7NJ(dHrx4WHumvb6Otqyey)E7Fw)iOJHtkJCRjZJYWs5WHys0pN7FE9dey)iOJHZi59mou((N2)0(92pMNySCifukWoCi1qyS(5C)qi1kimYHh5qkOuG73B)iOJHJHEsLjFEfGu5tx4WHys0Vv9JGogoSIjvM85vasLpDHdhIjr)CUFiPFV9JGogoSIjvM85vasLpDHdhIjr)CU)563B)iOJHJHEsLjFEfGu5tx4WHys0pN7FU(92)S(5OFzcQ2GC4OijXEqZ4qkSJobHrG9dey)C0pc6y4msEpJdLVFGa7NJ(5lcchoKcJwqP(N2pqG9hsbLcxS(uouzWL6NZC7NSDYGguowFQFiVFbhLWY8kaPQ)0TFiXZ(bcSFo6hRysLbSKiPt4ZMKKjHgwmXQonmoKcJwqjDOTXsirBVgMobHrGAR1WMAdQwrdx0OiCsbHr97T)z9l8ztsYKOFV9pykv1)S(dPGsHlwFkhQm4s9NU9pRFl7hY7hZtmwoPGdQ)P9pTFiVFmpXy5qkOuG73oU9dj9Bv)yEIXYHuqPa3V3(N1pMNySCifukW9Bx)w0Vv9hcJUWfaUx2xPoSJobHrG9dey)GQW5Ru3ylYfRjXEq7FA)E7Fw)C0VmbvBqoCuKKypOzCif2rNGWiW(bcSFo6hbDmCgjVNXHY3pqG9Zr)8fbHdJEJTO(N2)unSyIvDAym6n2I0WM0mmkhsbLcS2gl0H2glTnT9Ay6eegbQTwdBQnOAfnCrJIWjfeg1V3(N1VWNnjjtI(92)GPuv)Z6pKckfUy9PCOYGl1F62)S(TSFiVFmpXy5KcoO(N2)0(H8(X8eJLdPGsbUF742)K63B)Z6NJ(LjOAdYHJIKe7bnJdPWo6eegb2pqG9Zr)iOJHZi59mou((bcSFo6NViiC(k1n2I6FA)t1WIjw1PH9vQBSfPHnPzyuoKckfyTnwOdTnwojT9Ay6eegbQTwdBQnOAfnCrJIWjfeg1V3(N1VWNnjjtI(92)GPuv)Z6pKckfUy9PCOYGl1F62)S(TSFiVFmpXy5KcoO(N2)0(TJB)tQFV9pRFo6xMGQnihokssSh0moKc7Otqyey)ab2ph9JGogoJK3Z4q57hiW(5OF(IGWHdIXKkpysr9pT)PAyXeR60W4GymPYdMuKg2KMHr5qkOuG12yHo02yjKwBVgMobHrGAR1WMAdQwrdl8ztsYKqdlMyvNg(iaZ(k1PdTnwopT9Ay6eegbQTwdBQnOAfnSWNnjjtcnSyIvDA4KcBK9vQthABS0w12RHPtqyeO2AnSP2GQv0WcF2KKmj0WIjw1PHhOmw2xPoDOTzop12RHPtqyeO2AnSP2GQv0WiOJHdRysLjFEfGu5tx4WHys0pN7FU(92)S(f(Sjjzs0pqG9JGogog6jvM85vasLpDHdhIjr)C7FU(N2V3(N1)S(rqhdhGsvRQYQrMyOh5q57hiW(rqhdhd9Kkt(8kaPYNUWHY3pqG9J5jglhsbLcC)2XTFl73B)C0pc6y4WkMuzYNxbiv(0fou((N2V3(N1ph9ltq1gKdhfjj2dAghsHD0jimcSFGa7NJ(rqhdNrY7zCO89dey)Z6NJ(5lcchd9KkJJAtq97TFo6pegDHBpJuNeR6C0jimcSFGa7NViiCyftQmGLej7FA)t7hiW(LjOAdYHJIKe7bnJdPWo6eegb2V3(rqhdNrY7zCO897TF(IGWHvmPYawsKS)PAyXeR60Wm0tQmoQnbPdTnZzH2EnmDccJa1wRHn1guTIgwMGQnihokssSh0moKc7k5s0pN7FU(bcSFo6hbDmCgjVNXHY3pqG9Zr)8fbHdRysLbSKiPgwmXQonmwXKkdyjrsDOTzol12RHftSQtdJrVXwKgMobHrGAR1Ho0W8fzu(isOTxBJfA71W0jimcuBTo02yP2EnmDccJa1wRdTnZPTxdtNGWiqT16qBdKOTxddHWqjnSmbvBqoCuKKypOzCif2vYLqdtNGWiqT1AyXeR60Wqi1kimsddHu5t8jnSmrgJ1H2gBtBVggcHHsAyzcQ2GCszKBnzEugwkxjxcnmDccJa1wRHftSQtddHuRGWinmesLpXN0WYezHxhABMK2EnmDccJa1wRHv8AymfAyXeR60Wqi1kimsddHWqjnmK0Vv9pR)qy0fUaW9Y(k1HD0jimcSFV9pRFzcQ2GCszKBnzEugwkhDccJa7hiW(dHrx4WHumvb6Otqyey)t7FA)PV)z9Zr)YeuTb5KYi3AY8OmSuo6eegb2V3(5O)qy0foCiftvGo6eegb2V3(dHrx4WbXysLbRDeo6eegb2)unmesLpXN0W4roKckfyDOTbsRTxdlMyvNg2xPUe7LhQYxdtNGWiqT16qBZ802RHPtqyeO2ADOTXw12RHftSQtdZRIvDAy6eegbQTwhABSWtT9AyXeR60WyftQmGLej1W0jimcuBTo0Ho0WqqfEvN2gl90cB1tl90cNNEABwQHbuQBpOyn8K3Nxvbb2VL9lMyvx)SfhyxNsdZxQXYinmN63AHjNH6hYuOlyNIt9NmcEmKfaaGUrsueNr5daE9rzsSQZuYiaaV(gaqykeaqgs6bjiaGVuJLryashfnFYcIbiDmFzitHUGzRfMCgYHxFtNIt9BlsifQuP1VLE0VLEAHT2F673tpHS2MfDQofN6hsLuoOegY2P4u)PV)jdeKa7hwXKQFRjX31P4u)PVFivs5GsG9hsbLI8o63iyc3FO63KMHr5qkOuGDDko1F67FYaNCO4Ga7hpYHuqPa3pesTccJ6FOQ(fqq11poTleB31P4u)PVF41NNTJ06FYMGQnO(Js2OFMsLaLh3)mq1zlJ(rXu)O3rgcJLkT(HqQvqyu)40UqS9PUofN6p99pFKVcccS)05fcILw)W8BTr)g1bUXQU(hQQFifXiCScR)jJTqpF6I0P(ttHAlzS(tkqq9Vr)QQ)0uO9dO6SLr)49mu)t(7OccjO(xC)jxOjPQF(Av1gP56uDko1VTaBNmObb2pcnuf1Vr5Jir)ie09WU(NmJH4dC)N6sFsP8hOS(ftSQd3V6yP56uIjw1HD8fzu(isWDWeCIoLyIvDyhFrgLpIewXfGHsb2PetSQd74lYO8rKWkUaiOq9PlKyvxNQtXP(NSjOAdQFiKAfegH7uIjw1HD8fzu(isyfxaGqQvqyKhN4tCLjYyShqimuIRmbvBqoCuKKypOzCif2vYLOtjMyvh2XxKr5JiHvCbacPwbHrECIpXvMil8EaHWqjUYeuTb5KYi3AY8OmSuUsUeDQofN6hoKAimw)q0pCifgTGs9hsbLI(nOHAm6uIjw1HD8fzu(isyfxaGqQvqyKhN4tCXJCifukWEO45IPWdiegkXfsSAwim6cxa4EzFL6Wo6eegb6DMmbvBqoPmYTMmpkdlLJobHrGabgcJUWHdPyQc0rNGWiWPtt)moKjOAdYjLrU1K5rzyPC0jimc0lhHWOlC4qkMQaD0jimc0Bim6choigtQmyTJWrNGWiWPDkXeR6Wo(ImkFejSIla(k1LyV8qv(DQofN6h(eECsv0Fjly)iOJbb2poKa3pcnuf1Vr5Jir)ie09W9lhy)8fLEEve7bT)f3pO6ixNsmXQoSJViJYhrcR4ca(eECsvKXHe4oLyIvDyhFrgLpIewXfaEvSQRtjMyvh2XxKr5JiHvCbaRysLbSKizNQtXP(Tfy7KbniW(jiOkT(J1N6pss9lMqv9V4(fiKLjimY1PetSQdZfRysLriXVtjMyvh2kUaWRIvDESdUiOJHZi59mUI8L9W2njVIjwiOmDK)syUw0PetSQdBfxa4vXQopoXN4IirWOmVkw1LvJ8EbXyKj8yhCrqhdNrY7zCf5l7HTBsDkXeR6WwXfaeMsbMhOvAESdUiOJHZi59mou(oLyIvDyR4cacvyQsShup2bxe0XWzK8EghkFNsmXQoSvCbqkJCuouvrx4Xo4IGogoJK3Z4q57uIjw1HTIlaSfAYaNNCOGq9Pl8yhCrqhdNrY7zCO8DkXeR6WwXfGXwectPa9yhCrqhdNrY7zCO8DkXeR6WwXfa5meokHLncJ5Xo4IGogoJK3Z4q57uDko1pKcYG7uIjw1HTIlaOykVb57Xj(exeHrJTOmsjNjPh7Gln)Olppb6SW2S1jnNNEnkfdub45msEpJRiFzpSDZ5zNsmXQoSvCbaft5niFpoXN4cwKaMHYeWvcvHZiciuYJDWLMF0LNNaDwmjlSvpT0RrPyGkapNrY7zCf5l7HTBop7uIjw1HTIlaOykVb57Xj(exzc0IIKkCgVhucmZZq9fOKh7Gln)Olppb6SyswmhKgs71OumqfGNZi59mUI8L9W2nNNDkXeR6WwXfaumL3G894eFIBSGeouLF2OajB3JDWLMF0LNNaDwmjBZ2G0tQtjMyvh2kUaGIP8gKp2JDW1OumqfGNZi59mUI8L9W2nNNDkXeR6WwXfaaLQwvLvJmXqpQtjMyvh2kUaS3rfesqESdUYeuTb5yleelTmMFRnC0jimc07mJsXavaEU9msDsSQZvKVShMZwceOrPyGkapNHyeowHLf2c98PlCf5l7H5SfwoTtjMyvh2kUaSNrQtIvDESdUcokHL5vasLDCHep9cQchg9gBrUI8L9W2npVGQW5Ru3ylYvKVSh2olS07mqv4WbXysLhmPixr(YEy7MeqGCecJUWHdIXKkpysro6eegboTtjMyvh2kUayigHJvyzHTqpF6cp2bxbhLWY8kaPYoUqINENXHmbvBqo2cbXslJ53AdhDccJabcebDmCSfcILwgZV1gou(PENHGogoCiftvGoCiMe2X1sGaNnJJqy0foCiftvGo6eegbceihYeuTb5WrrsI9GMXHuyhDccJaN6fufom6n2ICf5l7HTZsVGQW5Ru3ylYfRjXEq9odufoCqmMu5btkYfRjXEqbcKJqy0foCqmMu5btkYrNGWiWPtN2PetSQdBfxagOvAz1itm0J8yhCNHGogoJK3Z4q5bc0OumqfGNZi59mUI8L9W2nNNt9IvmPYawsK0j8ztsYKOtjMyvh2kUamuLHYQr(KaTip2b3ziOJHZi59mouEGankfdub45msEpJRiFzpSDZ55uVcF2KKmj6uDko1pmpDGuH7uIjw1HTIlag5melJGogECIpXfhsXufOh7Glc6y4WHumvb6kYx2dZ555LdSIjvgWsIKoHpBssMeDkXeR6WwXfaCi1qymp2b3ziOJHdhsXufOdhIjbNNdiqe0XWHdPyQc0vKVSh2oUZBQxmpXy5qkOuGTJlesTccJC4roKckfyVZcPGsHlwFkhQm4swzXuihZtmwoKckfy7mkCKUw6SToLyIvDyR4caoKcJwqjp2b3zHWOlC4qkMQaD0jimc07me0XWHdPyQc0HdXKGZZbeic6y4WHumvb6kYx2dBh355fbDmCszKBnzEugwkhoetcopVPabYrim6choKIPkqhDccJa9odbDmCszKBnzEugwkhoetcoppGarqhdNrY7zCO8tN6fZtmwoKckfyhoKAimgNHqQvqyKdpYHuqPa7fbDmCm0tQm5ZRaKkF6choetcRqqhdhwXKkt(8kaPYNUWHdXKGZqIxe0XWHvmPYKpVcqQ8PlC4qmj48CErqhdhd9Kkt(8kaPYNUWHdXKGZZ5DghYeuTb5WrrsI9GMXHuyhDccJabcKde0XWzK8EghkpqGCWxeeoCifgTGstbcmKckfUy9PCOYGlXzUKTtg0GYX6tqUGJsyzEfGuLUqINabYbwXKkdyjrsNWNnjjtIovNIt9dzu2J7uIjw1HTIlay0BSf5HjndJYHuqPaZ1cp2b3IgfHtkimY7mHpBssMeEhmLQMfsbLcxS(uouzWLs3zwc5yEIXYjfCqtNc5yEIXYHuqPaBhxiXkmpXy5qkOuG9odZtmwoKckfy7SWQqy0fUaW9Y(k1HD0jimceiqqv48vQBSf5I1KypOt9oJdzcQ2GC4OijXEqZ4qkSJobHrGabYbc6y4msEpJdLhiqo4lcchg9gBrtN2PetSQdBfxa8vQBSf5HjndJYHuqPaZ1cp2b3IgfHtkimY7mHpBssMeEhmLQMfsbLcxS(uouzWLs3zwc5yEIXYjfCqtNc5yEIXYHuqPaBh3j5DghYeuTb5WrrsI9GMXHuyhDccJabcKde0XWzK8EghkpqGCWxeeoFL6gBrtN2PetSQdBfxaWbXysLhmPipmPzyuoKckfyUw4Xo4w0OiCsbHrENj8ztsYKW7GPu1SqkOu4I1NYHkdUu6oZsihZtmwoPGdA6u74ojVZ4qMGQnihokssSh0moKc7OtqyeiqGCGGogoJK3Z4q5bcKd(IGWHdIXKkpysrtN2P6uCQFBH0rLeQc3PetSQdBfxaocWSVsDESdUcF2KKmj6uIjw1HTIlajf2i7RuNh7GRWNnjjtIoLyIvDyR4cWaLXY(k15Xo4k8ztsYKOtjMyvh2kUaWqpPY4O2eKh7Glc6y4WkMuzYNxbiv(0foCiMeCEoVZe(Sjjzsaeic6y4yONuzYNxbiv(0foCiMeCNBQ3zZqqhdhGsvRQYQrMyOh5q5bcebDmCm0tQm5ZRaKkF6chkpqGyEIXYHuqPaBhxl9Ybc6y4WkMuzYNxbiv(0fou(PENXHmbvBqoCuKKypOzCif2rNGWiqGa5abDmCgjVNXHYde4mo4lcchd9KkJJAtqE5iegDHBpJuNeR6C0jimceiq(IGWHvmPYawsKC6uGaLjOAdYHJIKe7bnJdPWo6eegb6fbDmCgjVNXHY7LViiCyftQmGLejN2PetSQdBfxaWkMuzaljs6Xo4ktq1gKdhfjj2dAghsHDLCj48CabYbc6y4msEpJdLhiqo4lcchwXKkdyjrYofN63wuySizH2)qv97RGG8Pl6uIjw1HTIlay0BSfPHX8KrBJfEAPo0Hwd]] )

    
end