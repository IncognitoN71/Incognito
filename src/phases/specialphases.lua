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
    config = { mult = 1, chips = 1, modifier = 1, modifier_gain = 0.2 },
    pools = { ["SpecialPhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingspecialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",
                card.ability.modifier, card.ability.modifier_gain,

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_nic_special_phases'), get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Phases.text_colour, 1.2)
    end,

    in_pool = function(self, args)
        return false
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Phases' then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('nic_glitch', 1.1, 0.6)
                    card:juice_up()
                    return true
                end
            }))
            card.ability.modifier = card.ability.modifier + card.ability.modifier_gain
            card.ability.mult = card.ability.modifier
            card.ability.chips = card.ability.modifier
            return {
                message = "X" .. card.ability.modifier .. " Modifier",
                colour = G.C.NIC_PHASES
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval then
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
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('nic_glitch', 1.1, 0.6)
                card:juice_up()
                return true
            end
        }))
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'bloodmoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 1, y = 2 },
    config = { mult = 1.5, chips = 1.5, reusable = 0, reusable_gain = 1 },
    pools = { ["SpecialPhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingspecialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",
                card.ability.reusable, card.ability.reusable_gain,

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_nic_special_phases'), get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Phases.text_colour, 1.2)
    end,

    in_pool = function(self, args)
        return false
    end,

    calculate = function(self, card, context)
        if context.selling_card then
            if context.card.ability.set == 'Phases' then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('nic_glitch', 1.1, 0.6)
                        card:juice_up()
                        return true
                    end
                }))
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
            draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
            card.ability.reusable = card.ability.reusable - card.ability.reusable_gain
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('nic_glitch', 1.1, 0.6)
                    card:juice_up()
                    return true
                end
            }))
            SMODS.calculate_effect({message = card.ability.reusable .. " Left", colour = G.C.NIC_PHASES}, card)
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
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('nic_glitch', 1.1, 0.6)
                    card:juice_up()
                    return true
                end
            }))
            Incognito.phaseslevelup(card)
        end
    end,

    keep_on_use = function(self, card)
        return card.ability.reusable > 0
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'micromoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 2, y = 2 },
    config = { },
    pools = { ["SpecialPhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingspecialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
    end,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_nic_apogee'), get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Phases.text_colour, 1.2)
    end,

    in_pool = function(self, args)
        return false
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
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

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'supermoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 3, y = 2 },
    config = { },
    pools = { ["SpecialPhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingspecialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
    end,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_nic_perigee'), get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Phases.text_colour, 1.2)
    end,

    in_pool = function(self, args)
        return false
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
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

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'solareclipse',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 0, y = 3 },
    config = { },
    pools = { ["SpecialPhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingspecialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
    end,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_nic_eclipse'), get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Phases.text_colour, 1.2)
    end,

    in_pool = function(self, args)
        return false
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
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

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}