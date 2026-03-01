SMODS.ObjectType{
    key = "SpecialPhases",
    cards = {},
    default = 'c_nic_bluemoon',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Consumable {
    discovered = false,
    key = 'bluemoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 0, y = 2 },
    config = { mult = 1, chips = 1, odds = 100, modifier = 1, modifier_gain = 0.2 },
    pools = { ["SpecialPhases"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.odds) 
        info_queue[#info_queue + 1] = { key = "nic_changingspecialphases", set = "Other", vars = { new_numerator, new_denominator, } }
        info_queue[#info_queue + 1] = { 
            key = "nic_levelupvaluephases", set = "Other", vars = { 
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",
            } 
        }
        return { 
            vars = { 
                G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].level or "0", 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or "Nothing", 
                G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult or "0", 
                G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips or "0", 
                card.ability.modifier,
                card.ability.modifier_gain,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_nic_special_phases'), get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Phases.text_colour, 1.2)
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Phases' then
            card.ability.modifier = card.ability.modifier + card.ability.modifier_gain
            card.ability.mult = card.ability.modifier
            card.ability.chips = card.ability.modifier
            return {
                message = "X" .. card.ability.modifier .. " Modifier",
                colour = G.C.NIC_PHASES
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval then
            if SMODS.pseudorandom_probability(card, ('moonchange'), 1, card.ability.odds) then
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
                return {
                    message = "Shift!",
                    colour = G.C.NIC_PHASES
                }
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
                return {
                    message = "Nope!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'bloodmoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 1, y = 2 },
    config = { mult = 1.5, chips = 1.5, odds = 100, reusable = 0, reusable_gain = 1 },
    pools = { ["SpecialPhases"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.odds) 
        info_queue[#info_queue + 1] = { key = "nic_changingspecialphases", set = "Other", vars = { new_numerator, new_denominator, } }
        info_queue[#info_queue + 1] = { 
            key = "nic_levelupvaluephases", set = "Other", vars = { 
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",
            } 
        }
        return { 
            vars = { 
                G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].level or "0", 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or "Nothing", 
                G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult or "0", 
                G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips or "0", 
                card.ability.reusable,
                card.ability.reusable_gain,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_nic_special_phases'), get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Phases.text_colour, 1.2)
    end,

    calculate = function(self, card, context)
        if context.selling_card then
            if context.card.ability.set == 'Phases' then
                card.ability.reusable = card.ability.reusable + card.ability.reusable_gain
                return {
                    message = "+" .. card.ability.reusable_gain .. " Reusable",
                    colour = G.C.NIC_PHASES
                }
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval then
            if SMODS.pseudorandom_probability(card, ('moonchange'), 1, card.ability.odds) then
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
                return {
                    message = "Shift!",
                    colour = G.C.NIC_PHASES
                }
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
                return {
                    message = "Nope!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        if card.ability.reusable > 0 then
            card.ability.reusable = card.ability.reusable - card.ability.reusable_gain
            draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    Incognito.phaseslevelup(card)
                    draw_card(G.play, G.consumeables, 1, 'up', true, card, nil, mute)
                    return true
                end
            }))
        else
            Incognito.phaseslevelup(card)
        end
    end,

    keep_on_use = function(self, card)
        return card.ability.reusable > 0
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'altareclipse',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 2, y = 2 },
    config = { odds = 100 },
    pools = { ["SpecialPhases"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.odds) 
        info_queue[#info_queue + 1] = { key = "nic_changingspecialphases", set = "Other", vars = { new_numerator, new_denominator, } }
    end,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_nic_special_phases'), get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Phases.text_colour, 1.2)
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if SMODS.pseudorandom_probability(card, ('moonchange'), 1, card.ability.odds) then
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
                return {
                    message = "Shift!",
                    colour = G.C.NIC_PHASES
                }
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
                return {
                    message = "Nope!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,
}