function Incognito.phaseslevelup(card)
    local hand = G.GAME.last_hand_played
    local mult = G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult
    local chips = G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips
    local level = 1

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, 
    {handname = localize(hand, "poker_hands"), level = G.GAME.hands[hand].level, mult = G.GAME.hands[hand].mult, chips = G.GAME.hands[hand].chips, hand})
    delay(1)

    G.GAME.hands[hand].mult = G.GAME.hands[hand].mult + mult
    G.GAME.hands[hand].chips = G.GAME.hands[hand].chips + chips
    G.GAME.hands[hand].level = G.GAME.hands[hand].level + level

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        play_sound('tarot1')
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        G.TAROT_INTERRUPT_PULSE = true
        return true end }))

    update_hand_text({delay = 0}, 
    {chips = "+"..chips, StatusText = true})

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('tarot1')
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        return true end }))
            
    update_hand_text({delay = 0}, 
    {handname = localize(hand, "poker_hands"), chips = G.GAME.hands[hand].chips, hand})


    update_hand_text({delay = 0}, 
    {mult = "+"..mult, StatusText = true})

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('tarot1')
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        G.TAROT_INTERRUPT_PULSE = nil
        return true end }))

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, 
    {handname = localize(hand, "poker_hands"), level = G.GAME.hands[hand].level, mult = G.GAME.hands[hand].mult, chips = G.GAME.hands[hand].chips, hand})

    delay(1.5)

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, 
    { mult = 0, chips = 0, level = "", handname = "", })
end