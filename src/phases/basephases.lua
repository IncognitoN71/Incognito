SMODS.Atlas{ -- Phases
    key = "nicphases",
    path = "phases/nicphases.png",
    px = 71,
    py = 95,
}

SMODS.ConsumableType {
    key = 'Phases',
    default = 'c_nic_newmoon',
    primary_colour = G.C.NIC_PHASES,
    secondary_colour = G.C.NIC_PHASES,
    collection_rows = { 4, 4 },
    shop_rate = 0,
    loc_txt = {
        name = "Phases",
        collection = "Phases",
        undiscovered = {
            name = "Not Discovered",
            text = { 
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does",
            },
        }
    },
}

SMODS.ObjectType{
    key = "BasePhases",
    cards = {},
    default = 'c_nic_newmoon',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Consumable {
    discovered = false,
    key = 'newmoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 0, y = 0 },
    config = { mult = 1, chips = 1 },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingphases", set = "Other" }
        local lvlhand = "0"
        local lasthand = "Nothing"
        local multhand = "0"
        local chipshand = "0"
        if G.GAME.last_hand_played then 
            lvlhand = G.GAME.hands[G.GAME.last_hand_played].level
            lasthand = G.GAME.last_hand_played
            multhand = G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult
            chipshand = G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips
        end
        return { 
            vars = { 
                lvlhand, lasthand, multhand, chipshand,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('special_card', 1, 100) ~= 1 then
                draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        card:juice_up(0.5, 0.5)
                        play_sound('tarot2', 1.1, 0.6)
                        card:set_ability(G.P_CENTERS.c_nic_waxingcrescent)
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
                return {
                    message = "Special Shift!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        Incognito.basephaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'waxingcrescent',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 1, y = 0 },
    config = { mult = 1, chips = 1.5 },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingphases", set = "Other" }
        local lvlhand = "0"
        local lasthand = "Nothing"
        local multhand = "0"
        local chipshand = "0"
        if G.GAME.last_hand_played then 
            lvlhand = G.GAME.hands[G.GAME.last_hand_played].level
            lasthand = G.GAME.last_hand_played
            multhand = G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult
            chipshand = G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips
        end
        return { 
            vars = { 
                lvlhand, lasthand, multhand, chipshand,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('special_card', 1, 100) ~= 1 then
                draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        card:juice_up(0.5, 0.5)
                        play_sound('tarot2', 1.1, 0.6)
                        card:set_ability(G.P_CENTERS.c_nic_firstquarter)
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
                return {
                    message = "Special Shift!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        Incognito.basephaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or (card.area == G.consumeables)
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'firstquarter',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 2, y = 0 },
    config = { mult = 1, chips = 2 },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingphases", set = "Other" }
        local lvlhand = "0"
        local lasthand = "Nothing"
        local multhand = "0"
        local chipshand = "0"
        if G.GAME.last_hand_played then 
            lvlhand = G.GAME.hands[G.GAME.last_hand_played].level
            lasthand = G.GAME.last_hand_played
            multhand = G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult
            chipshand = G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips
        end
        return { 
            vars = { 
                lvlhand, lasthand, multhand, chipshand,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('special_card', 1, 100) ~= 1 then
                draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        card:juice_up(0.5, 0.5)
                        play_sound('tarot2', 1.1, 0.6)
                        card:set_ability(G.P_CENTERS.c_nic_waxinggibbous)
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
                return {
                    message = "Special Shift!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        Incognito.basephaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or (card.area == G.consumeables)
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'waxinggibbous',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 3, y = 0 },
    config = { mult = 1.5, chips = 2 },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingphases", set = "Other" }
        local lvlhand = "0"
        local lasthand = "Nothing"
        local multhand = "0"
        local chipshand = "0"
        if G.GAME.last_hand_played then 
            lvlhand = G.GAME.hands[G.GAME.last_hand_played].level
            lasthand = G.GAME.last_hand_played
            multhand = G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult
            chipshand = G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips
        end
        return { 
            vars = { 
                lvlhand, lasthand, multhand, chipshand,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('special_card', 1, 100) ~= 1 then
                draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        card:juice_up(0.5, 0.5)
                        play_sound('tarot2', 1.1, 0.6)
                        card:set_ability(G.P_CENTERS.c_nic_fullmoon)
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
                return {
                    message = "Special Shift!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        Incognito.basephaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or (card.area == G.consumeables)
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'fullmoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 0, y = 1 },
    config = { mult = 2, chips = 2 },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingphases", set = "Other" }
        local lvlhand = "0"
        local lasthand = "Nothing"
        local multhand = "0"
        local chipshand = "0"
        if G.GAME.last_hand_played then 
            lvlhand = G.GAME.hands[G.GAME.last_hand_played].level
            lasthand = G.GAME.last_hand_played
            multhand = G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult
            chipshand = G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips
        end
        return { 
            vars = { 
                lvlhand, lasthand, multhand, chipshand,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('special_card', 1, 100) ~= 1 then
                draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        card:juice_up(0.5, 0.5)
                        play_sound('tarot2', 1.1, 0.6)
                        card:set_ability(G.P_CENTERS.c_nic_waninggibbous)
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
                return {
                    message = "Special Shift!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        Incognito.basephaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or (card.area == G.consumeables)
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'waninggibbous',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 1, y = 1 },
    config = { mult = 1.5, chips = 2 },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingphases", set = "Other" }
        local lvlhand = "0"
        local lasthand = "Nothing"
        local multhand = "0"
        local chipshand = "0"
        if G.GAME.last_hand_played then 
            lvlhand = G.GAME.hands[G.GAME.last_hand_played].level
            lasthand = G.GAME.last_hand_played
            multhand = G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult
            chipshand = G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips
        end
        return { 
            vars = { 
                lvlhand, lasthand, multhand, chipshand,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('special_card', 1, 100) ~= 1 then
                draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        card:juice_up(0.5, 0.5)
                        play_sound('tarot2', 1.1, 0.6)
                        card:set_ability(G.P_CENTERS.c_nic_thirdquarter)
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
                return {
                    message = "Special Shift!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        Incognito.basephaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or (card.area == G.consumeables)
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'thirdquarter',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 2, y = 1 },
    config = { mult = 2, chips = 1 },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingphases", set = "Other" }
        local lvlhand = "0"
        local lasthand = "Nothing"
        local multhand = "0"
        local chipshand = "0"
        if G.GAME.last_hand_played then 
            lvlhand = G.GAME.hands[G.GAME.last_hand_played].level
            lasthand = G.GAME.last_hand_played
            multhand = G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult
            chipshand = G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips
        end
        return { 
            vars = { 
                lvlhand, lasthand, multhand, chipshand,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('special_card', 1, 100) ~= 1 then
                draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        card:juice_up(0.5, 0.5)
                        play_sound('tarot2', 1.1, 0.6)
                        card:set_ability(G.P_CENTERS.c_nic_waningscrescent)
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
                return {
                    message = "Special Shift!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        Incognito.basephaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or (card.area == G.consumeables)
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'waningscrescent',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 3, y = 1 },
    config = { mult = 1.5, chips = 1 },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingphases", set = "Other" }
        local lvlhand = "0"
        local lasthand = "Nothing"
        local multhand = "0"
        local chipshand = "0"
        if G.GAME.last_hand_played then 
            lvlhand = G.GAME.hands[G.GAME.last_hand_played].level
            lasthand = G.GAME.last_hand_played
            multhand = G.GAME.hands[G.GAME.last_hand_played].l_mult * card.ability.mult
            chipshand = G.GAME.hands[G.GAME.last_hand_played].l_chips * card.ability.chips
        end
        return { 
            vars = { 
                lvlhand, lasthand, multhand, chipshand,
                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or 
                    (G.GAME.hands[G.GAME.last_hand_played].level == 1 and G.C.UI.TEXT_DARK) or 
                    (G.C.HAND_LEVELS[math.min(7, G.GAME.hands[G.GAME.last_hand_played].level)])),
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('special_card', 1, 100) ~= 1 then
                draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        card:juice_up(0.5, 0.5)
                        play_sound('tarot2', 1.1, 0.6)
                        card:set_ability(G.P_CENTERS.c_nic_newmoon)
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
                return {
                    message = "Special Shift!",
                    colour = G.C.NIC_PHASES
                }
            end
        end
    end,

    use = function(self, card, area, copier)
        Incognito.basephaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or (card.area == G.consumeables)
    end,
}