-- Phases Card Bounce

function Incognito.phaseslevelup(card)
    local hand = G.GAME.last_hand_played

    local mult = G.GAME.hands[G.GAME.last_hand_played].l_mult
    local chips = G.GAME.hands[G.GAME.last_hand_played].l_chips

    local xmult = card.ability.mult
    local xchips = card.ability.chips

    G.GAME.hands[G.GAME.last_hand_played].l_mult = mult * xmult
    G.GAME.hands[G.GAME.last_hand_played].l_chips = chips * xchips

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, 
    {handname = hand .. " Value", chips = chips, mult = mult, level = "" })
    delay(1)

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
        play_sound('tarot1')
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        G.TAROT_INTERRUPT_PULSE = true
        return true end }))

    update_hand_text({delay = 0}, 
    {chips = "x" .. number_format(xchips), StatusText = true})

    update_hand_text({delay = 0}, 
    {chips = "+" .. number_format(chips * xchips)})

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
        play_sound('tarot1')
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        return true end }))

    update_hand_text({delay = 0}, 
    {mult = "x" .. number_format(xmult), StatusText = true})

    update_hand_text({delay = 0}, 
    {mult = "+" .. number_format(mult * xmult)})

    delay(2)

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, 
    { mult = 0, chips = 0, handname = "", level = "" })
end

-- Other Card Bounce

function Incognito.cardlevelup(card, shake)
    local hand = G.GAME.last_hand_played

    local mult = G.GAME.hands[G.GAME.last_hand_played].l_mult
    local chips = G.GAME.hands[G.GAME.last_hand_played].l_chips

    local xmult = card.ability.mult
    local xchips = card.ability.chips

    G.GAME.hands[G.GAME.last_hand_played].l_mult = mult * xmult
    G.GAME.hands[G.GAME.last_hand_played].l_chips = chips * xchips

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, 
    {handname = hand .. " Value", chips = chips, mult = mult, level = "" })
    delay(1)

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
        play_sound('tarot1')
        if shake and shake.juice_up then shake:juice_up(0.8, 0.5) end
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        G.TAROT_INTERRUPT_PULSE = true
        return true end }))

    update_hand_text({delay = 0}, 
    {chips = "x" .. number_format(xchips), StatusText = true})

    update_hand_text({delay = 0}, 
    {chips = "+" .. number_format(chips * xchips)})

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
        play_sound('tarot1')
        if shake and shake.juice_up then shake:juice_up(0.8, 0.5) end
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        return true end }))

    update_hand_text({delay = 0}, 
    {mult = "x" .. number_format(xmult), StatusText = true})

    update_hand_text({delay = 0}, 
    {mult = "+" .. number_format(mult * xmult)})

    delay(2)

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, 
    { mult = 0, chips = 0, handname = "", level = "" })
end

-- Moon Ring Function is in the Main Function cause resetting variables in different files def WORKS

-- Base Phases Shifting

function Incognito.normalshift(card)
    if pseudorandom('moonchange', G.GAME.phases_numerator, G.GAME.phases_denominator) == G.GAME.phases_numerator then
        draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
        for i = 1, 2 do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot2', 1.1, 0.6)
                    card:juice_up()
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                card:juice_up(0.5, 0.5)
                play_sound('nic_glitch', 1.1, 0.6)
                card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.SpecialPhases, 'specialphases', {in_pool = function() return true end}).key)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                draw_card(G.play, G.consumeables, 1, 'up', true, card, nil, mute)
                return true
            end
        }))
        SMODS.calculate_effect({message = localize('k_nic_special_shift_ex'), colour = G.C.NIC_PHASES}, card)
    else
        draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
        local moonring = {}
        for _, moon_pool in pairs(G.P_CENTER_POOLS.BasePhases) do
            if moon_pool.key ~= card.config.center.key then
                moonring[#moonring + 1] = moon_pool
            end
        end
        local moon = pseudorandom_element(moonring, 'basephases', {in_pool = function() return true end}).key
        if next(SMODS.find_card("c_nic_nullmoon")) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    card:juice_up(0.5, 0.5)
                    play_sound('xchips', 1.1, 0.6)
                    card:set_ability(moon)
                    
                    return true
                end
            }))
            if moon == card.ability.moon then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.calculate_effect({message = localize('k_nic_null'), colour = G.C.NIC_PHASES}, card)
                        SMODS.add_card({ key = card.config.center.key, edition = "e_negative" })
                        return true
                    end
                }))
            end
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    card:juice_up(0.5, 0.5)
                    play_sound('xchips', 1.1, 0.6)
                    card:set_ability(G.P_CENTERS[card.ability.moon])
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                draw_card(G.play, G.consumeables, 1, 'up', true, card, nil, mute)
                return true
            end
        }))
        if next(SMODS.find_card("c_nic_nullmoon")) then
            if moon == card.ability.moon then
                SMODS.calculate_effect({message = localize('k_nic_null'), colour = G.C.NIC_PHASES}, card)
            else
                SMODS.calculate_effect({message = localize('k_nic_shift_qu'), colour = G.C.NIC_PHASES}, card)
            end
        else
            SMODS.calculate_effect({message = localize('k_nic_shift_ex'), colour = G.C.NIC_PHASES}, card)
        end
    end
end

-- Special Phases Shift

function Incognito.specialshift(card)
    if pseudorandom('moonchange', G.GAME.phases_numerator, G.GAME.phases_denominator) == G.GAME.phases_numerator then
        draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
        for i = 1, 2 do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot2', 1.1, 0.6)
                    card:juice_up()
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                card:juice_up(0.5, 0.5)
                play_sound('xchips', 1.1, 0.6)
                card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.BasePhases, 'basephases', {in_pool = function() return true end}).key)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                draw_card(G.play, G.consumeables, 1, 'up', true, card, nil, mute)
                return true
            end
        }))
        SMODS.calculate_effect({message = localize('k_nic_shift_ex'), colour = G.C.NIC_PHASES}, card)
    else
        draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                draw_card(G.play, G.consumeables, 1, 'up', true, card, nil, mute)
                return true
            end
        }))
        SMODS.calculate_effect({message = localize('k_nope_ex'), colour = G.C.NIC_PHASES}, card)
    end
end

