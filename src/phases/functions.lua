function Incognito.phaseslevelup(card)
    local hand = G.GAME.last_hand_played

    local mult = G.GAME.hands[G.GAME.last_hand_played].l_mult
    local chips = G.GAME.hands[G.GAME.last_hand_played].l_chips

    local xmult = card.ability.mult
    local xchips = card.ability.chips

    G.GAME.hands[G.GAME.last_hand_played].l_mult = mult * xmult
    G.GAME.hands[G.GAME.last_hand_played].l_chips = chips * xchips

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, 
    {handname = hand .. " Value", chips = chips, mult = mult})
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
    { mult = 0, chips = 0, handname = "", })
end