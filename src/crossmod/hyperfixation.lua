SMODS.Atlas { -- Tetoraq
    key = 'tetoraq',
    path = "crossmod/hyperfixation/tetoraq.png",
    px = 71,
    py = 95
}

SMODS.Atlas{ -- Ijiraq Jokers
    key = "nicjokersijiraq",
    path = "crossmod/hyperfixation/nicjokersijiraq.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- Hyperfixation Phases
    key = "nichyperfixationphases",
    path = "crossmod/hyperfixation/nichyperfixationphases.png",
    px = 71,
    py = 95,
}

SMODS.Joker({
    key = 'tetoraq',
    rarity = 'nic_teto',
    atlas = 'tetoraq',
    pos = { x = 0, y = 0 },
    soul_pos = {
        x = 1,
        y = 0,
        draw = function(card, scale_mod, rotate_mod)
            scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) *
                    math.pi * 14) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            rotate_mod = 0.3 * math.sin(10 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL) * math.pi * 5) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            card.children.hpfx_floating_sprite:draw_shader('dissolve',
                0, nil, nil, card.children.center, scale_mod, nil, nil, 0.1)
            card.children.hpfx_floating_sprite:draw_shader('dissolve',
                nil, nil, nil, card.children.center, scale_mod, nil)

            card.children.floating_sprite:draw_shader('dissolve',
                0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1)
            card.children.floating_sprite:draw_shader('dissolve',
                nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra_slots_used = -1,
        extra = { iji_retriggers = 0 },
    },
    dependencies = { 'hyperfixation_mod' },
    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.hpfx_floating_sprite =
                Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                    G.ASSET_ATLAS[card.config.center.atlas], {
                        x = 2,
                        y = 0
                    })
            card.children.hpfx_floating_sprite.role.draw_major = card
            card.children.hpfx_floating_sprite.states.hover.can = false
            card.children.hpfx_floating_sprite.states.click.can = false
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.iji_retriggers
            }
        }
    end,
    calculate = function(self, card, context)
        local retrigger_joker = 0
        for _, c in pairs(G.jokers.cards) do
            if c:is_rarity('nic_teto') or c.ability.nic_tetosticker then
                retrigger_joker = retrigger_joker + 1
            end
            card.ability.extra.iji_retriggers = retrigger_joker
        end
        if context.retrigger_joker_check
            and context.other_card.config.center_key == 'j_hpfx_ijiraq' then
            return {
                repetitions = card.ability.extra.iji_retriggers
            }
        end
    end,
    in_pool = function(self, args)
        if G.jokers then
            for _, j in ipairs(G.jokers.cards) do
                if next(SMODS.find_card('j_hpfx_ijiraq', true)) then
                    return true
                else
                    return false
                end
            end
        end
    end
})

SMODS.Consumable {
    discovered = false,
    key = 'pinkmoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nichyperfixationphases',
    pos = {x = 0, y = 0 },
    dependencies = { 'hyperfixation_mod' },
    pools = { ["SpecialPhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingphases", set = "Other" }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('special_card', 1, 100) == 1 then
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
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or (card.area == G.consumeables)
    end,
}

if Hyperfixation and Hyperfixation.hypercross then
    if type(Hyperfixation) == "table" and type(Hyperfixation.hypercross) == "function" then
        Hyperfixation.hypercross('Incognito', 'j_nic_technoblade', 'j_nic_faketechnoblade', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_machinedramon', 'j_nic_fakemachinedramon', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_button', 'j_nic_fakebutton', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_slycooper', 'j_nic_fakeslycooper', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_stalagmite', 'j_nic_fakestalagmite', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_dalgonacookie', 'j_nic_fakedalgonacookie', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_dalgonacircle', 'j_nic_fakedalgonacircle', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_dalgonatriangle', 'j_nic_fakedalgonatriangle', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_dalgonastar', 'j_nic_fakedalgonastar', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_dalgonaumbrella', 'j_nic_fakedalgonaumbrella', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_humantorch', 'j_nic_fakehumantorch', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_invisiblewoman', 'j_nic_fakeinvisiblewoman', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_thething', 'j_nic_fakethething', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_misterfantastic', 'j_nic_fakemisterfantastic', false)
        Hyperfixation.hypercross('Incognito', 'j_nic_incognito', 'j_nic_fakeincognito', false)
    end
end

SMODS.Joker{ -- Fake Technoblade
    key = "faketechnoblade",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 0},
    config = { extra = { score = 25, prevent = 3, prevent_needed = 3, prevent_loss = 1 } },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.prevent, card.ability.extra.prevent_needed, card.ability.extra.score,
                card.area and card.area == G.jokers and "Decrease" or "Increase",
                card.area and card.area == G.jokers and "...?" or "",
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
            if to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big(card.ability.extra.score / 100) then
                if card.ability.extra.prevent <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand_text_area.blind_chips:juice_up()
                            G.hand_text_area.game_chips:juice_up()
                            play_sound('nic_technoblade')
                            hpfx_Transform(card, context)
                            return true
                        end
                    }))
                else
                    card.ability.extra.prevent = card.ability.extra.prevent - card.ability.extra.prevent_loss
                    card.ability.extra.score = card.ability.extra.score - 25  
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand_text_area.blind_chips:juice_up()
                            G.hand_text_area.game_chips:juice_up()
                            play_sound('nic_technoblade')
                            return true
                        end
                    }))
                end
                return {
                    message = (card.ability.extra.prevent > 1) and (card.ability.extra.prevent .. '/' .. card.ability.extra.prevent_needed) or "TECHNOBLADE NEVER DIES!",
                    saved = 'ph_nic_technoblade',
                    colour = G.C.RED
                }
            end
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_faketechnoblade",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.score = 75
        card.ability.extra.new_key = "j_nic_faketechnoblade_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Machinedramon
    key = "fakemachinedramon",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 3,
    cost = 8,
    pos = {x = 1, y = 0},
    config = { extra = { mult = 0, xmult = 1, mult_gain = 15, xmult_gain = 0.5 } },
    
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        else
            info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        end
        return { 
            vars = {
                card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.mult_gain, card.ability.extra.xmult_gain,
                card.area and card.area == G.jokers and "Gold" or "Steel",
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            for i = 1, #G.hand.cards do 
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        if not next(SMODS.get_enhancements(G.hand.cards[i])) and not G.hand.cards[i].debuff then
                            G.hand.cards[i]:juice_up()
                            G.hand.cards[i]:set_ability('m_gold')
                            play_sound("nic_machinedramon")
                        end
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    hpfx_Transform(card, context)
                    return true
                end
            }))
        end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, 'm_gold') then
                context.other_card.should_destroy = true
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return { message = "ASSEMBLE!", colour = G.C.BLACK }
            end
        end

        if context.joker_main then
            return { 
                mult = card.ability.extra.mult, 
                xmult = card.ability.extra.xmult 
            }
        end
	end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakemachinedramon",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakemachinedramon_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Button
    key = "fakebutton",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 1,
    cost = 3,
    pos = {x = 2, y = 0 },
    config = { extra = { xmult = 0.5, xmult_gain = 0.05 , odds = 100 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return { 
            vars = {
                new_numerator, new_denominator, card.ability.extra.xmult, card.ability.extra.xmult_gain,
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,
    
    calculate = function(self, card, context)
        if context.key_press_space or (context.cry_press and card.states.hover.is == true) then
            if SMODS.pseudorandom_probability(card, ('j_nic_button'),  1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(10, 10)
                        hpfx_Transform(card, context)
                        return true
                    end
                }))
                return { play_sound("nic_explosion"), message = "BOOM!", colour = G.C.RED }
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                card:juice_up(0.5, 0.5)
                return { play_sound("nic_click") }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult 
            }
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakebutton",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.xmult = 0
        card.ability.extra.xmult_gain = 0.01
        card.ability.extra.new_key = "j_nic_fakebutton_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Sly Cooper
    key = "fakeslycooper",
    no_collection = true,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 2,
    cost = 6,
    pos = {x = 3, y = 0},
    config = { extra = { slycooper_remaining = 1, odds = 4 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        local green = G.C.GREEN
        local attention = G.C.FILTER
        return {
            vars = {
                colours = {
                    card.area and card.area == G.jokers and attention or green,
                    card.area and card.area == G.jokers and green or attention,
                },
                new_numerator, new_denominator,
                localize { type = 'variable', key = (card.ability.extra.slycooper_remaining == 0 and 'nic_active' or 'nic_inactive'), vars = { card.ability.extra.slycooper_remaining } },
                card.area and card.area == G.jokers and "Double" or "Free",
                card.area and card.area == G.jokers and "Free" or "Double",
                card.area and card.area == G.jokers and "...?" or "",
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.slycooper_remaining = 0
            return { message = "ACTIVE!", colour = G.C.RED }
        end
        if context.starting_shop and not context.blueprint then
            return { play_sound('nic_gambling') }
        end
        if context.ending_shop and not context.blueprint then
            card.ability.extra.slycooper_remaining = 1
        end

        if card.ability.extra.slycooper_remaining == 0 then
            if (context.buying_card or context.nic_buying_booster or context.nic_buying_voucher) and context.card.cost > 0 then
                card.ability.extra.slycooper_remaining = 1
                if SMODS.pseudorandom_probability(card, ('j_nic_slycooper'), 1, card.ability.extra.odds) then
                    context.card.cost = 0
                    SMODS.calculate_effect({
                        message = 'SNATCH!',
                        colour = G.C.GREEN,
                    },context.card)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            hpfx_Transform(card, context)
                            return true
                        end
                    }))
                else 
                    context.card.cost = context.card.cost * 2
                    SMODS.calculate_effect({
                        message = 'CAUGHT!',
                        colour = G.C.RED,
                        play_sound('nic_metalalert'),
                    },context.card)
                end
            end
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakeslycooper",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakeslycooper_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Stalagmite
    key = "fakestalagmite",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 3,
    cost = 8,
    pos = {x = 4, y = 0},
    config = { extra = { chips = 50, chips_gain = 50 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        local stone_tally = 0
        if G.hand then
            if G.hand.cards then
                for k, v in ipairs(G.hand.cards) do
                    if SMODS.has_enhancement(v, 'm_stone') then stone_tally = stone_tally + 1 end
                end
            end
        end
        return { 
            vars = { 
                card.ability.extra.chips, card.ability.extra.chips_gain, card.ability.extra.chips * stone_tally,
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakestalagmite",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakestalagmite_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = 1, #G.playing_cards do
                    local random = pseudorandom('j_nicstalagmite', 1, 4)
                    if random == 1 then
                        G.playing_cards[i]:set_edition('e_negative', nil, true)
                    end
                    G.playing_cards[i]:juice_up()
                    G.playing_cards[i]:set_ability('m_stone')
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                card:juice_up()
                play_sound("nic_dripstone")
                hpfx_Transform(card, context)
                return true
            end
        }))
    end,
}

SMODS.Joker{ -- Fake Dalgona Cookie
    key = "fakedalgonacookie",
    no_collection = true,
    blueprint_compat = false,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 2,
    cost = 5,
    pos = {x = 5, y = 0},
    config = { extra = {} },
    pools = { Food = true },

    loc_vars = function(self, info_queue, card)
		return { 
            vars = {
                card.area and card.area == G.jokers and "Fake" or "Opened",
                card.area and card.area == G.jokers and "...?" or "",
            }
        }
	end,
    
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot2', 1.1, 0.6)
                    card:juice_up()
                    card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.FakeDalgona, 'dalgona', {in_pool = function() return true end}).key)
                    return true
                end
            }))
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakedalgonacookie",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakedalgonacookie_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.ObjectType{ -- Pool Dalgona
	key = "FakeDalgona",
	cards = {
        ['j_nic_fakedalgonacircle'] = true,
        ['j_nic_fakedalgonatriangle'] = true,
        ['j_nic_fakedalgonastar'] = true,
        ['j_nic_fakedalgonaumbrella'] = true,
    }
}

SMODS.Joker{ -- Fake Dalgona Circle
    key = "fakedalgonacircle",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 2,
    cost = 0,
    pos = {x = 6, y = 0},
    config = { extra = { mult = 0, mult_gain = 3, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed,
                card.area and card.area == G.jokers and "succeeded" or "failed",
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "High Card" or context.scoring_name == "Pair" or context.scoring_name == "Two Pair" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.success = 0
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            hpfx_Transform(card, context)
                            return true
                        end
                    }))
                    return {
                        message = "SUCCEED?",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "SEALED...",
                        colour = G.C.RED
                    }
                end
            else
                card.ability.extra.mult = 0
                card.ability.extra.success = 0
                card.ability.extra.cookie = card.ability.extra.cookie + 1
                card.ability.extra.cookie_needed = card.ability.extra.cookie_needed + 1
                return {
                    message = "FAILED?",
                    colour = G.C.MONEY
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakedalgonacircle",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakedalgonacircle_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Dalgona Triangle
    key = "fakedalgonatriangle",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 2,
    cost = 0,
    pos = {x = 7, y = 0},
    config = { extra = { mult = 0, mult_gain = 10, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,
    
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed,
                card.area and card.area == G.jokers and "succeeded" or "failed",
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Three of a Kind" or context.scoring_name == "Straight" or context.scoring_name == "Flush" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.success = 0
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            hpfx_Transform(card, context)
                            return true
                        end
                    }))
                    return {
                        message = "SUCCEED?",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "SEALED...",
                        colour = G.C.RED
                    }
                end
            else
                card.ability.extra.mult = 0
                card.ability.extra.success = 0
                card.ability.extra.cookie = card.ability.extra.cookie + 1
                card.ability.extra.cookie_needed = card.ability.extra.cookie_needed + 1
                return {
                    message = "FAILED?",
                    colour = G.C.MONEY
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakedalgonatriangle",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakedalgonatriangle_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Dalgona Star
    key = "fakedalgonastar",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 2,
    cost = 0,
    pos = {x = 8, y = 0},
    config = { extra = { xmult = 1, xmult_gain = 0.25, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult, card.ability.extra.xmult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed,
                card.area and card.area == G.jokers and "succeeded" or "failed",
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Full House" or context.scoring_name == "Four of a Kind" or context.scoring_name == "Straight Flush" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.success = 0
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            hpfx_Transform(card, context)
                            return true
                        end
                    }))
                    return {
                        message = "SUCCEED?",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "SEALED...",
                        colour = G.C.RED
                    }
                end
            else
                card.ability.extra.xmult = 1
                card.ability.extra.success = 0
                card.ability.extra.cookie = card.ability.extra.cookie + 1
                card.ability.extra.cookie_needed = card.ability.extra.cookie_needed + 1
                return {
                    message = "FAILED?",
                    colour = G.C.MONEY
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakedalgonastar",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakedalgonastar_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Dalgona Umbrella
    key = "fakedalgonaumbrella",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 2,
    cost = 0,
    pos = {x = 9, y = 0},
    config = { extra = { xmult = 1, xmult_gain = 1, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult, card.ability.extra.xmult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed,
                card.area and card.area == G.jokers and "succeeded" or "failed",
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Five of a Kind" or context.scoring_name == "Flush House" or context.scoring_name == "Flush Five" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.success = 0
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            hpfx_Transform(card, context)
                            return true
                        end
                    }))
                    return {
                        message = "SUCCEED?",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "SEALED...",
                        colour = G.C.RED
                    }
                end
            else
                card.ability.extra.xmult = 1
                card.ability.extra.success = 0
                card.ability.extra.cookie = card.ability.extra.cookie + 1
                card.ability.extra.cookie_needed = card.ability.extra.cookie_needed + 1
                return {
                    message = "FAILED?",
                    colour = G.C.MONEY
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakedalgonaumbrella",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakedalgonaumbrella_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Human Torch
    key = "fakehumantorch",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 1},
    config = { extra = { levels = 1, levels_gain = 1, randomizer = 1 } },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.levels, card.ability.extra.levels_gain,
                card.area and card.area == G.jokers and "Five" or "Four",
                card.area and card.area == G.jokers and "5" or "4",
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end

        if context.before and not context.blueprint then 
            card.ability.extra.randomizer = pseudorandom('nic_humantorch', 1, 5)
        end

        if context.cardarea == G.play and not context.blueprint and context.destroy_card == context.full_hand[card.ability.extra.randomizer] and G.GAME.current_round.hands_played == 0 and #context.full_hand == 5 then
            if context.scoring_name == "Five of a Kind" then
                return {
                    remove = true
                }
            end
        end

        if context.before and context.main_eval then
            if context.scoring_name == "Five of a Kind" and G.GAME.current_round.hands_played == 0 and #context.full_hand == 5 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        hpfx_Transform(card, context)
                        return true
                    end
                }))
                return {
                    level_up = card.ability.extra.levels, level_up_hand = "Five of a Kind", 
                    message = "FLAME ON",
                    colour = G.C.BLUE,
                }
            end
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakehumantorch",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakehumantorch_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ --  Fake Invisible Woman
    key = "fakeinvisiblewoman",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 3,
    cost = 8,
    pos = {x = 1, y = 1},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { 
            vars = { 
                card.area and card.area == G.jokers and "Five" or "Four",
                card.area and card.area == G.jokers and "5" or "4",
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end

        if context.before and context.main_eval and not context.blueprint then
            if context.scoring_name == "Five of a Kind" and #context.full_hand == 5 and #context.full_hand == 5 then
                if G.GAME.current_round.hands_played == 0 then 
                    for _, other_card in ipairs(context.scoring_hand) do
                        other_card:set_ability('m_glass', nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                other_card:juice_up()
                                return true
                            end
                        }))
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            hpfx_Transform(card, context)
                            return true
                        end
                    }))
                    return {
                        message = "DISAPPEAR",
                        colour = G.C.BLUE
                    }
                end
            end
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakeinvisiblewoman",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakeinvisiblewoman_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake The Thing
    key = "fakethething",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 3,
    cost = 8,
    pos = {x = 2, y = 1},
    config = { extra = { counter = 1, counter_gain = 1 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { 
            vars = { 
                card.ability.extra.counter, card.ability.extra.counter_gain,
                card.area and card.area == G.jokers and "Five" or "Four",
                card.area and card.area == G.jokers and "5" or "4",
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            if not context.blueprint then
                local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            local counter = card.ability.extra.counter
            G.E_MANAGER:add_event(Event({
                func = function()
                    for i = 1, counter do
                        local stone_card = SMODS.create_card { set = "Base", enhancement = "m_stone", seal = SMODS.poll_seal({ guaranteed = true }), area = G.discard }
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        stone_card.playing_card = G.playing_card
                        table.insert(G.playing_cards, stone_card)
                        
                        stone_card:start_materialize()
                        G.play:emplace(stone_card)
                        draw_card(G.play, G.deck, 90, 'up')
                    end
                    return true
                end
            }))
            return {
                message = "TIS THE CLOBBERIN HOUR",
                colour = G.C.BLUE
            }
        end
        if context.before and context.scoring_name == "Five of a Kind" and G.GAME.current_round.hands_played == 0 and #context.full_hand == 5 and not context.blueprint then
            card.ability.extra.counter = card.ability.extra.counter + card.ability.extra.counter_gain
            G.E_MANAGER:add_event(Event({
                func = function()
                    hpfx_Transform(card, context)
                    return true
                end
            }))
            return {
                message = "CLOBBERIN' TIME",
                colour = G.C.BLUE
            }
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakethething",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakethething_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Mister Fantastic
    key = "fakemisterfantastic",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 3,
    cost = 8,
    pos = {x = 3, y = 1},
    config = { extra = { fantastic = false } },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.area and card.area == G.jokers and (card.ability.extra.fantastic == true and "High Card" or "Five of a Kind") or "Four of a Kind",
                card.area and card.area == G.jokers and "5" or "4",
                card.area and card.area == G.jokers and "...?" or "",
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.scoring_name == "High Card" and #context.full_hand == 5 then
            card.ability.extra.fantastic = true 
        else
            card.ability.extra.fantastic = false
        end

        if context.modify_scoring_hand and not context.blueprint and #context.full_hand == 5 then
            return {
                add_to_hand = true
            }
        end
        if context.scoring_name and not context.blueprint and #context.full_hand == 5 then
            if context.evaluate_poker_hand then
                return {
                    replace_scoring_name = "High Card"
                }
            end
        end
        if context.before and context.main_eval and context.scoring_name == "High Card" and #context.full_hand == 5 and not context.blueprint then
            card.ability.extra.fantastic = true 
            G.E_MANAGER:add_event(Event({
                func = function()
                    hpfx_Transform(card, context)
                    return true
                end
            }))
            return {
                message = "FANTASTIC",
                colour = G.C.BLUE
            }
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakemisterfantastic",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakemisterfantastic_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

SMODS.Joker{ -- Fake Incognito
    key = "fakeincognito",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 4,
    cost = 20,
    pos = {x = 4, y = 1},
    soul_pos = {x = 5, y = 1},
    config = { extra = { xmult = 1, xmult_gain = 1 , top = 1, odds = 7 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.top, card.ability.extra.odds) 
        return {
            vars = {
                new_numerator, new_denominator, card.ability.extra.xmult_gain, card.ability.extra.xmult,
                card.area and card.area == G.jokers and "   " or "non",
                card.area and card.area == G.jokers and "     " or "Spade",
                card.area and card.area == G.jokers and "...?" or "",
            }
        }
    end,
    
    calculate = function(self, card, context)
        if card.ability.extra.xmult >= 71 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    hpfx_Transform(card, context)
                    return true
                end
            }))
        end

        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true, colour = G.C.SUITS.Spades }
        end

        if context.remove_playing_cards and not context.blueprint then
            local cards = 0
            for _, removed_card in ipairs(context.removed) do
                cards = cards + 1
            end
            if cards > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + (cards * card.ability.extra.xmult_gain)
                return {
                    message = "+X" .. cards .. " MULT!",
                    colour = G.C.SUITS.Spades,
                }
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            if SMODS.pseudorandom_probability(card, ('j_nic_incognito'), card.ability.extra.top, card.ability.extra.odds) then
                context.other_card.should_destroy = true
                return { message = "SWOON!", colour = G.C.SUITS.Spades }
            else
                return { message = "NOPE!", colour = G.C.SUITS.Spades }
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Spades") then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            set = "Joker",
            key = card.ability and card.ability.extra.new_key or "j_nic_fakeincognito",
            nodes = {}
        }
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.new_key = "j_nic_fakeincognito_alt"
        local sticker = SMODS.Stickers['hpfx_priceless']
        sticker.apply(sticker, card, true)
    end,
}

--[[SMODS.Joker{ -- Fake Crazy Taxi
    key = "fakecrazytaxi",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokersijiraq',
    rarity = 2,
    cost = 6,
    pos = {x = 6, y = 1},
    config = { start = 0, inblind = 0, time = 30, extra = { dollars = 1 } },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.dollars, localize((G.GAME.current_round.nic_crazytaxi_card or {}).rank or 'Ace', 'ranks'),
            },
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.3 },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                ref_table = card.ability,
                                ref_value = "time",
                                scale = 0.32,
                                colour = G.C.MONEY
                            }
                        }
                    }
                }
            }
        }
    end,

    update = function(self, card)
        local time = 30 - (G.TIMERS.REAL - card.ability.start) * card.ability.inblind
        if time <= 0 then
            card.ability.time = "0:00"
        else
            card.ability.time = string.gsub(string.format("%.2f", time), "%.", ":")
        end
    end,

    calculate = function(self, card, context)
        if context.blueprint then return end
        if context.setting_blind then
            card.ability.start = G.TIMERS.REAL
			card.ability.inblind = 1
            return {
                message = "TAKE ME TO THE NEXT ROUND"
            }
        end

        if context.individual and context.cardarea == G.play and context.other_card:get_id() == G.GAME.current_round.nic_crazytaxi_card.id then
            if (G.TIMERS.REAL - card.ability.start <= 30) then
                card.ability.start = card.ability.start + 5
                return {
                    message = "+5 Seconds"
                }
            else
                return {
                    message = "YOU'RE LATE"
                }
            end
        end
        
        if (context.end_of_round and context.main_eval and not context.repetition) or context.forcetrigger then
			card.ability.inblind = 0
			if (G.TIMERS.REAL - card.ability.start <= 30) or context.forcetrigger then
                card.ability.extra.dollars = card.ability.extra.dollars + 3
                G.E_MANAGER:add_event(Event({
                    func = function()
                        hpfx_Transform(card, context)
                        return true
                    end
                }))
				return {
                    message = "THANK YOU",
                    play_sound('nic_win')
                }
            else
                card:start_dissolve()
                return {
                    message = "Failure",
                    play_sound('nic_explosion')
                }
			end
        end
    end,

    calc_dollar_bonus = function(self, card)
        local money = card.ability.extra.dollars
        return money
    end,
}]]