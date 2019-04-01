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

        if buff.warrior_of_elune.up then
            setCooldown( "warrior_of_elune", 3600 ) 
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
                gain( 40, "astral_power" )
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

            talent = "incarnation",

            handler = function ()
                shift( "moonkin_form" )
                
                applyBuff( "incarnation" )
                gain( 40, "astral_power" )

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

                if buff.warrior_of_elune.up then
                    removeStack( "warrior_of_elune" )
                    if buff.warrior_of_elune.down then
                        setCooldown( "warrior_of_elune", 45 ) 
                    end
                end

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


    spec:RegisterPack( "Balance", 20190401.1437, [[dGu4Raqii0JaixseL2evPpPisJsr1PaWQavYROeMfLKBPOu7Ik)cu1WePCmkrlte5zkctJsrxtru2MiQ(MIighaLZbQuRdGQEhavAEGkUheTpQchKsblKQOhQOetuefDrfrL2OikKpkIc1jvevTsrYmfrb7KsQLQiQ4PGmvkL2lf)vudwLdtAXq6XiMmbxg1Mv4ZGYOPuDALwnav8Ary2eDBQQDRQFJ0Wj0XvuslxQNd10fUoqBhc(UI04PuOZls16vumFaTFjBS0yRbsqd2yDsPzjCNMntZsNL2CIjXMWTbksxKnqIkjHcJnqV6ZgipvP(e2ajQPlPQGXwdeMc2e2azpcrmGhE4HTHDquhH6dpE9bLAS0N06iGhV(e4nqOGRmM8Vb1ajObBSoP0SeUtZMPzPZsBoXKyZKBGuWWoTnqqR)SyGSVcc8BqnqcmMyGauDEQs9jCDjZgCfQuaQo7riIb8WdpSnSdI6iuF4XRpOuJL(Kwhb841NaFLcq1zdI9kRZsRQlP0SeURB21LgCd4TzAvQkfGQBwSRpmgd4RuaQUzxNniiWc1brLAxNNS67QuaQUzx3SyxFySqDH2W4iVJ6ikMX1f06iPtKCo0gghyxLcq1n76SbbahqCWc1Hh5qByCGRdbTxfvY1nODDQGa9RdN(hQn6QuaQUzxh06lk3r61zdZW9gCDrRBuNKstakIRBUa9N0Ooqmxh4)mHXyTtVoe0Evujxho9puBeaxLcq1n76MCyFkcSqDjdlcSm96Ge3EJ6i0xyJL(1nODDZclzCSQSoBqUWEF(da36sNcoPszD2ve462OoAxx6uW6Ms)jnQdVpHRBY)p3iObx3IRZ(cZo31j2lT3iDNbsU4aBS1ajWdfuggBnwBPXwdKsIL(gimvQDgLvFde)kQKfmEAcJ1jzS1aXVIkzbJNgisVb3RAGqbhdhrZ7tCn7R7JRZJ6sEDERtjXIaN5N9xgxhY6S0aPKyPVbsKgl9nHX6jm2AG4xrLSGXtdeP3G7vnqOGJHJO59jUM919X15rDj3ajsJL(giuncjNfPXs)mDK3pyPKjHbsjXsFdKinw6BcJ120yRbIFfvYcgpnqKEdUx1aHcogoIM3N4afnqkjw6BGqLuQqEa2PBcJ1tMXwde)kQKfmEAGi9gCVQbcfCmCenVpXbkAGusS03aHYnM7e7dZegRtUXwde)kQKfmEAGi9gCVQbcfCmCenVpXbkAGusS03aPnrFoh0U5pmHX6jXyRbIFfvYcgpnqKEdUx1aHcogoIM3N4afnqkjw6BGKlm7bod4akaZN)WegRbmJTgi(vujly80ar6n4Evdek4y4iAEFIdu0aPKyPVbASnJkPubtySgUn2AG4xrLSGXtdeP3G7vnqOGJHJO59joqrdKsIL(gi9jmoAvMjQuAcJ1wMMXwde)kQKfmEAGusS03aHQsESnNrB9j2nqKEdUx1aXZk4kkYcouvYJT5mARpXEDERJqPsb603r08(exZ(6(468OUjsZa9QpBGqvjp2MZOT(e7MWyTLwAS1aXVIkzbJNgiLel9nqcnRczysvy1G24mQkaJnqKEdUx1aXZk4kkYcoHMvHmmPkSAqBCgvfGX15TocLkfOtFhrZ7tCn7R7JRZJ6Mind0R(SbsOzvidtQcRg0gNrvbySjmwBzsgBnq8ROswW4PbsjXsFdKodyZHDkoJ3hglKfLG(km2ar6n4EvdepRGROil40zaBoStXz8(WyHSOe0xHX15TocLkfOtFhrZ7tCn7R7JRZJ6Mind0R(SbsNbS5WofNX7dJfYIsqFfgBcJ1woHXwde)kQKfmEAGusS03afRaJdA7Njub2gnqKEdUx1aXZk4kkYcUyfyCqB)mHkW2Ob6vF2afRaJdA7Njub2gnHXAlTPXwde)kQKfmEAGi9gCVQbIqPsb603r08(exZ(6(468OUjsZaPKyPVbceZ5nyFSjmwB5KzS1aPKyPVbAQ29s7mDKzj4Zgi(vujly80egRTm5gBnq8ROswW4PbI0BW9QgiDgU3GDYfbwMEglU9go(vujluN36MxhHsLc0PVBFI2Vgl9Dn7R7JRdo1LuDabwhHsLc0PVJWsghRkZQCH9(8hUM919X1bN6SmP6aWaPKyPVbA)NBe0GnHXAlNeJTgi(vujly80ar6n4EvdKanCyWFSn7A2x3hxNh1by15TobA48P0FSn7A2x3hxNh1zzs15TU51jqdhoyPu78qQn7A2x3hxNh1L86acSoeRluj)HdhSuQDEi1MD8ROswOoaQZBDQyMyNjjQZBDiwhk4y4iAEFIdu0aPKyPVbAFI2Vgl9nHXAlbmJTgi(vujly80ar6n4EvdKIJwLzr6uURZdK1zZ0QZBDiwhk4y4iAEFIduSoV1PIzIDMKOoV1nVobA4WG)yB21SVUpUopQlP68wNanC(u6p2MDXssSpS68w386eOHdhSuQDEi1MDXssSpS6acSoeRluj)HdhSuQDEi1MD8ROswOoaQdadKsIL(giclzCSQmRYf27ZFycJ1wc3gBnq8ROswW4PbI0BW9QgO51HcogoIM3N4afRdiW6iuQuGo9DenVpX1SVUpUopQBI0QdG68whMk1opT1WUtfZe7mjHbsjXsFd0aStpthzwc(SjmwNuAgBnq8ROswW4PbI0BW9QgO51HcogoIM3N4afRdiW6iuQuGo9DenVpX1SVUpUopQBI0QdG68wNkMj2zscdKsIL(gObTjCMoYVgGnBcJ1jzPXwde)kQKfmEAGi9gCVQbcfCmC4qBjTfCn7R7JRdo1by15ToeRdtLANN2Ay3PIzIDMKWaPKyPVbIOpHLzuWXWaHcog5x9zdeo0wsBbtySoPKm2AG4xrLSGXtdeP3G7vnqZRdfCmC4qBjTfC4qjjQdo1nrDabwhk4y4WH2sAl4A2x3hxNhiRdWQdG68whwKLYCOnmoW15bY6qq7vrLSdpYH2W4axN36MxxOnmoCX6Z5GMfwUolQZY6aOo4QoSilL5qByCGRZJ6iuCuxYwxsUjZaPKyPVbchApuP0egRtAcJTgi(vujly80ar6n4Evd086cvYF4WH2sAl44xrLSqDERBEDOGJHdhAlPTGdhkjrDWPUjQdiW6qbhdho0wsBbxZ(6(468azDawDERdfCmCAt0FjzrqjwBhousI6GtDawDauhqG1HyDHk5pC4qBjTfC8ROswOoV1nVouWXWPnr)LKfbLyTD4qjjQdo1by1beyDOGJHJO59joqX6aOoaQZBDyrwkZH2W4a7WH2dvkRdo1HG2RIkzhEKdTHXbUoV1Hcogoj4RDM9fPt52N)WHdLKOolQdfCmCyQu7m7lsNYTp)HdhkjrDWPoBwN36qbhdhMk1oZ(I0PC7ZF4WHssuhCQBI68whk4y4KGV2z2xKoLBF(dhousI6GtDtuN36MxhI1PZW9gSdhnRj2hwghAJD8ROswOoGaRdX6qbhdhrZ7tCGI1beyDiwNyZi4WH2yWggxha1beyDH2W4WfRpNdAwy56GdY6yBKjGbNJ1NRdUQtXrRYSiDk31LS1zZ0QdiW6qSomvQDEARHDNkMj2zscdKsIL(giCOngSHXMWyDs20yRbIFfvYcgpnqkjw6BGWG)yB2ar6n4EvduZJMX2vujxN36MxNkMj2zsI68w3qsPDDZRl0gghUy95CqZclxxYw386sQo4QoSilLz7ko46aOoaQdUQdlYszo0ggh468azD2SolQdlYszo0ggh468w386WISuMdTHXbUopQZY6SOUqL8hUy6(zFk9Xo(vujluhqG1jqdNpL(JTzxSKe7dRoaQZBDZRdX60z4Ed2HJM1e7dlJdTXo(vujluhqG1HyDOGJHJO59joqX6acSoeRtSzeCyWFSnxha1bGbIKorY5qByCGnwBPjmwN0KzS1aXVIkzbJNgiLel9nq(u6p2MnqKEdUx1a18OzSDfvY15TU51PIzIDMKOoV1nKuAx386cTHXHlwFoh0SWY1LS1nVUKQdUQdlYsz2UIdUoaQdG6GR6WISuMdTHXbUopqwxYRZBDZRdX60z4Ed2HJM1e7dlJdTXo(vujluhqG1HyDOGJHJO59joqX6acSoeRtSzeC(u6p2MRdG6aWarsNi5COnmoWgRT0egRtk5gBnq8ROswW4PbsjXsFdeoyPu78qQnBGi9gCVQbQ5rZy7kQKRZBDZRtfZe7mjrDERBiP0UU51fAdJdxS(CoOzHLRlzRBEDjvhCvhwKLYSDfhCDauha15bY6sEDERBEDiwNod3BWoC0SMyFyzCOn2XVIkzH6acSoeRdfCmCenVpXbkwhqG1HyDInJGdhSuQDEi1MRdG6aWarsNi5COnmoWgRT0egRtAsm2AG4xrLSGXtdeP3G7vnqQyMyNjjmqkjw6BGEEA2NsFtySojaZyRbIFfvYcgpnqKEdUx1aPIzIDMKWaPKyPVbYUkhzFk9nHX6KGBJTgi(vujly80ar6n4EvdKkMj2zscdKsIL(gObOuM9P03egRNinJTgi(vujly80ar6n4Evdek4y4WuP2z2xKoLBF(dhousI6GtDtuN36MxNkMj2zsI6acSouWXWjbFTZSViDk3(8hoCOKe1HSUjQdG68w386Mxhk4y4MQDV0othzwc(SduSoGaRdfCmCsWx7m7lsNYTp)HduSoGaRdlYszo0ggh468azDjvN36qSouWXWHPsTZSViDk3(8hoqX6aOoV1nVoeRtNH7nyhoAwtSpSmo0g74xrLSqDabwhI1HcogoIM3N4afRdiW6MxhI1j2mcoj4RDgh9MGRZBDiwxOs(d3(eTFnw674xrLSqDabwNyZi4WuP25PTg2RdG6aOoGaRtNH7nyhoAwtSpSmo0g74xrLSqDERdfCmCenVpXbkwN36eBgbhMk1opT1WEDayGusS03ajbFTZ4O3eSjmwpHLgBnq8ROswW4PbI0BW9QgiDgU3GD4OznX(WY4qBSR1prDWPUjQdiW6qSouWXWr08(ehOyDabwhI1j2mcomvQDEARHDdKsIL(gimvQDEARHDtySEIKm2AGusS03aHb)X2SbIFfvYcgpnHjmqIntO(OAyS1yTLgBnq8ROswW4PjmwNKXwde)kQKfmEAcJ1tyS1aXVIkzbJNMWyTnn2AG4xrLSGXtdev0aH5WaPKyPVbcbTxfvYgieujiBGSzDwuNod3BWoTj6VKSiOeRTJFfvYc1zrDHk5pC4qBjTfC8ROswOolQBED6mCVb7WrZAI9HLXH2yxRFI68OUKQZBD6mCVb70MO)sYIGsS2o(vujluha1n76qSUqL8hUy6(zFk9Xo(vujlyGqq78R(SbcpYH2W4aBcJ1tMXwdKsIL(giFk9tSFEqBFde)kQKfmEAcJ1j3yRbIFfvYcgpnHX6jXyRbsjXsFdKinw6BG4xrLSGXttySgWm2AGusS03aHPsTZtBnSBG4xrLSGXttyctyGqGB8sFJ1jLMLWDAjLMLU0S0sd0uT)9HHnqtEFrAhSqDjvNsIL(1jxCGDvkdewKjgRTmTKmqInDSs2abO68uL6t46sMn4kuPauD2Jqed4HhEyByhe1rO(WJxFqPgl9jToc4XRpb(kfGQZge7vwNLwvxsPzjCx3SRln4gWBZ0Quvkav3SyxFymgWxPauDZUoBqqGfQdIk1Uopz13vPauDZUUzXU(WyH6cTHXrEh1rumJRlO1rsNi5COnmoWUkfGQB21zdcaoG4GfQdpYH2W4axhcAVkQKRBq76ubb6xho9puB0vPauDZUoO1xuUJ0RZgMH7n46Iw3OojLMauex3Cb6pPrDGyUoW)zcJXANEDiO9QOsUoC6FO2iaUkfGQB21n5W(ueyH6sgweyz61bjU9g1rOVWgl9RBq76MfwY4yvzD2GCH9(8haU1LofCsLY6SRiW1TrD0UU0PG1nL(tAuhEFcx3K)FUrqdUUfxN9fMDURtSxAVr6UkvLcq1n5AJmbmyH6q5bT56iuFunQdLHTp2vNnqiSyGR7P)STRT)auwNsIL(46OVmDxLsjXsFStSzc1hvdKdPItuPusS0h7eBMq9r1WcKWpOuHkLsIL(yNyZeQpQgwGeEfeMp)Hgl9RuvkavNnmd3BW1HG2RIkzCLcq1PKyPp2j2mH6JQHfiHhbTxfvYw9QpJuNjJXwHGkbzK6mCVb7WrZAI9HLXH2yxRFIkfGQtjXsFStSzc1hvdlqcpcAVkQKT6vFgPotwfTcbvcYi1z4Ed2Pnr)LKfbLyTDT(jQuvkavhuO9qLY6qOoOqBmydJRl0ggh1rad6yuPusS0h7eBMq9r1WcKWJG2RIkzRE1NrIh5qByCGTIkIeZHviOsqgPnTqNH7nyN2e9xsweuI12XVIkzblcvYF4WH2sAl44xrLSGfZ1z4Ed2HJM1e7dlJdTXUw)eEKKxDgU3GDAt0FjzrqjwBh)kQKfay2igQK)Wft3p7tPp2XVIkzHkLsIL(yNyZeQpQgwGeEFk9tSFEqB)kvLcq1b9Qi2onQR1vOouWXGfQdhAGRdLh0MRJq9r1Ooug2(460xOoXMNTinI9Hv3IRtG(SRsPKyPp2j2mH6JQHfiHh)Qi2onY4qdCLsjXsFStSzc1hvdlqcVinw6xPusS0h7eBMq9r1WcKWJPsTZtBnSxPQuaQUjxBKjGbluhJa3PxxS(CDHDUoLe0UUfxNIGUsfvYUkLsIL(yKyQu7mkR(vkLel9XwGeErAS03QDGefCmCenVpX1SVUp2JK7vjXIaN5N9xgJ0YkLsIL(ylqcVinw6B1R(msuncjNfPXs)mDK3pyPKjHv7ajk4y4iAEFIRzFDFShjVsPKyPp2cKWJkPuH8aSt3QDGefCmCenVpXbkwPusS0hBbs4r5gZDI9Hz1oqIcogoIM3N4afRukjw6JTaj8At0NZbTB(dR2bsuWXWr08(ehOyLsjXsFSfiHxUWSh4mGdOamF(dR2bsuWXWr08(ehOyLsjXsFSfiHFSnJkPubR2bsuWXWr08(ehOyLsjXsFSfiHxFcJJwLzIkLwTdKOGJHJO59joqXkvLcq1nljtCLsjXsFSfiHheZ5nyFRE1NrIQsESnNrB9j2TAhi5zfCffzbNLtgCN8jsZlHsLc0PVJO59jUM919XEmrAvkLel9XwGeEqmN3G9T6vFgPqZQqgMufwnOnoJQcWyR2bsEwbxrrwWzzYTeUtljVekvkqN(oIM3N4A2x3h7XePvPusS0hBbs4bXCEd23Qx9zK6mGnh2P4mEFySqwuc6RWyR2bsEwbxrrwWzzYTCIjzs8sOuPaD67iAEFIRzFDFShtKwLsjXsFSfiHheZ5nyFRE1NrgRaJdA7Njub2gTAhi5zfCffzbNLjFYMSjj5vkLel9XwGeEqmN3G9XwTdKekvkqN(oIM3N4A2x3h7XePvPusS0hBbs4NQDV0othzwc(CLsjXsFSfiHF)NBe0GTAhi1z4Ed2jxeyz6zS42B44xrLSG35ekvkqN(U9jA)AS031SVUpgojbeiHsLc0PVJWsghRkZQCH9(8hUM919XWXYKaOsPKyPp2cKWVpr7xJL(wTdKc0WHb)X2SRzFDFShaMxbA48P0FSn7A2x3h7HLj5DUanC4GLsTZdP2SRzFDFShjhiqedvYF4WblLANhsTzh)kQKfaWRkMj2zscViIcogoIM3N4afRuaQUKj9N0OoLeGQuMEDe7mjrDdAxxYWIaltVoiXT3Oo7CZaU1LofCsLY6SRiW1TrD0UU0PG1nL(tA4Qukjw6JTaj8ewY4yvzwLlS3N)WQDGuXrRYSiDk3EG0MP5fruWXWr08(ehOOxvmtSZKeENlqdhg8hBZUM919XEKKxbA48P0FSn7ILKyFyENlqdhoyPu78qQn7ILKyFyabIyOs(dhoyPu78qQn74xrLSaaauPusS0hBbs4hGD6z6iZsWNTAhiNJcogoIM3N4afbcKqPsb603r08(exZ(6(ypMina8IPsTZtBnS7uXmXotsuPusS0hBbs4h0MWz6i)Aa2Sv7a5CuWXWr08(ehOiqGekvkqN(oIM3N4A2x3h7XePbGxvmtSZKevQkfGQdsKFbUXvkLel9XwGeEI(ewMrbhdRE1NrIdTL0wWQDGefCmC4qBjTfCn7R7JHdG5frmvQDEARHDNkMj2zsIkLsIL(ylqcpo0EOsPv7a5CuWXWHdTL0wWHdLKaotaeik4y4WH2sAl4A2x3h7bsadaVyrwkZH2W4a7bse0Evuj7WJCOnmoWENhAdJdxS(CoOzHLTWsaGlSilL5qByCG9GqXrYMKBYQukjw6JTaj84qBmydJTAhiNhQK)WHdTL0wWXVIkzbVZrbhdho0wsBbhousc4mbqGOGJHdhAlPTGRzFDFShibmVOGJHtBI(ljlckXA7WHssahadaGarmuj)HdhAlPTGJFfvYcENJcogoTj6VKSiOeRTdhkjbCamGarbhdhrZ7tCGIaaGxSilL5qByCGD4q7HkLWbbTxfvYo8ihAdJdSxuWXWjbFTZSViDk3(8hoCOKewGcogomvQDM9fPt52N)WHdLKao20lk4y4WuP2z2xKoLBF(dhousc4mHxuWXWjbFTZSViDk3(8hoCOKeWzcVZruNH7nyhoAwtSpSmo0g74xrLSaqGiIcogoIM3N4afbcerXMrWHdTXGnmgaGadTHXHlwFoh0SWYWbjBJmbm4CS(mCP4OvzwKoL7K1MPbeiIyQu780wd7ovmtSZKevQkfGQlzsTfxPusS0hBbs4XG)yB2ks6ejNdTHXbgPLwTdKnpAgBxrLS35QyMyNjj8oKuApp0gghUy95CqZclNSZtcUWISuMTR4Gbaa4clYszo0gghypqAtlWISuMdTHXb27CSilL5qByCG9WslcvYF4IP7N9P0h74xrLSaqGc0W5tP)yB2fljX(WaW7Ce1z4Ed2HJM1e7dlJdTXo(vujlaeiIOGJHJO59joqrGaruSzeCyWFSndaavkLel9XwGeEFk9hBZwrsNi5COnmoWiT0QDGS5rZy7kQK9oxfZe7mjH3HKs75H2W4WfRpNdAwy5KDEsWfwKLYSDfhmaaaxyrwkZH2W4a7bYK7DoI6mCVb7WrZAI9HLXH2yh)kQKfaceruWXWr08(ehOiqGik2mcoFk9hBZaaqLsjXsFSfiHhhSuQDEi1MTIKorY5qByCGrAPv7azZJMX2vuj7DUkMj2zscVdjL2ZdTHXHlwFoh0SWYj78KGlSilLz7koyaaWdKj37Ce1z4Ed2HJM1e7dlJdTXo(vujlaeiIOGJHJO59joqrGaruSzeC4GLsTZdP2maauPQuaQUKX8ZTg0gxPusS0hBbs4FEA2NsFR2bsvmtSZKevkLel9XwGeE7QCK9P03QDGufZe7mjrLsjXsFSfiHFakLzFk9TAhivXmXotsuPusS0hBbs4LGV2zC0Bc2QDGefCmCyQu7m7lsNYTp)HdhkjbCMW7CvmtSZKeabIcogoj4RDM9fPt52N)WHdLKa5ea4D(CuWXWnv7EPDMoYSe8zhOiqGOGJHtc(ANzFr6uU95pCGIabIfzPmhAdJdShitYlIOGJHdtLANzFr6uU95pCGIa4DoI6mCVb7WrZAI9HLXH2yh)kQKfaceruWXWr08(ehOiqGZruSzeCsWx7mo6nb7fXqL8hU9jA)AS03XVIkzbGafBgbhMk1opT1WoaaaeOod3BWoC0SMyFyzCOn2XVIkzbVOGJHJO59joqrVInJGdtLANN2AyhGkLsIL(ylqcpMk1opT1WUv7aPod3BWoC0SMyFyzCOn216NaotaeiIOGJHJO59joqrGaruSzeCyQu780wd7vkavxYivkd7nyDdAxNpfb2N)OsPKyPp2cKWJb)X2SjmHXa]] )


end