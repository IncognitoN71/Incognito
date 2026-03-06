SMODS.Atlas{ -- Jokers
    key = "nicjokers",
    path = "nicjokers.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Technoblade
    key = "technoblade",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 0},
    config = { extra = { score = 25, prevent = 3, prevent_needed = 3, prevent_loss = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.prevent, card.ability.extra.prevent_needed, card.ability.extra.score } }
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
                            card:start_dissolve()
                            return true
                        end
                    }))
                else
                    card.ability.extra.prevent = card.ability.extra.prevent - card.ability.extra.prevent_loss
                    card.ability.extra.score = card.ability.extra.score + 25  
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
    end
}

SMODS.Joker{ -- Machinedramon
    key = "machinedramon",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 1, y = 0},
    config = { extra = { mult = 0, xmult = 1, mult_gain = 15, xmult_gain = 0.5 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.mult_gain, card.ability.extra.xmult_gain } }
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
                            G.hand.cards[i]:set_ability('m_steel')
                            play_sound("nic_machinedramon")
                        end
                        return true
                    end
                }))
            end

        end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, 'm_steel') then
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
	end
}

SMODS.Joker{ -- Button
    key = "button",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 1,
    cost = 3,
    pos = {x = 2, y = 0 },
    config = { extra = { xmult = 0.5, xmult_gain = 0.05 , odds = 100 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return {vars = {new_numerator, new_denominator, card.ability.extra.xmult, card.ability.extra.xmult_gain}}
    end,
    
    calculate = function(self, card, context)
        if context.key_press_space or (context.cry_press and card.states.hover.is == true) then
            if SMODS.pseudorandom_probability(card, ('j_nic_button'),  1, card.ability.extra.odds) then
                card:start_dissolve({G.C.RED})
                card:juice_up(10, 10)
                return { play_sound("nic_explosion"), message = "BOOM!", colour = G.C.RED }
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                card:juice_up()
                return { play_sound("nic_click") }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult 
            }
        end
    end
}

SMODS.Joker{ -- Sly Cooper
    key = "slycooper",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 3, y = 0},
    config = { extra = { slycooper_remaining = 1, odds = 4 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return { vars = {
            new_numerator, new_denominator,
            localize { type = 'variable', key = (card.ability.extra.slycooper_remaining == 0 and 'nic_active' or 'nic_inactive'), vars = { card.ability.extra.slycooper_remaining } }, 
        } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if next(SMODS.find_mod('hyperfixation_mod')) then
            else
                local eval = function(card) return card.ability.extra.slycooper_remaining == 0 and not card.REMOVED end
                juice_card_until(card, eval, true)
            end
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
                    context.card.cost = context.card.cost * 2
                    SMODS.calculate_effect({
                        message = 'CAUGHT!',
                        colour = G.C.RED,
                        play_sound('nic_metalalert'),
                    },context.card)
                else 
                    context.card.cost = 0
                    SMODS.calculate_effect({
                        message = 'SNATCH!',
                        colour = G.C.GREEN,
                    },context.card)
                end
            end
        end
    end
}

SMODS.Joker{ -- Stalagmite
    key = "stalagmite",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
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
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain, card.ability.extra.chips * stone_tally } }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                if context.other_card.edition and context.other_card.edition.negative == true then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                    context.other_card.should_destroy = true
                    return {
                        message = "Impaled",
                        colour = G.C.CHIPS
                    }
                else
                    local other_card = context.other_card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            other_card:juice_up()
                            other_card:set_edition('e_negative', nil, true)
                            play_sound("nic_dripstone")
                            return true
                        end
                    }))
                end
            end
        end

        if context.joker_main then
            local stone_tally = 0
            for k, v in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(v, 'm_stone') then stone_tally = stone_tally + 1 end
            end
            return {
                chips = card.ability.extra.chips * stone_tally
            }
        end
    end
}

SMODS.Joker{ -- Dalgona Cookie
    key = "dalgonacookie",
    blueprint_compat = false,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 5, y = 0},
    config = { extra = {} },
    pools = { Food = true },

    loc_vars = function(self, info_queue, center)
		return { vars = {} }
	end,
    
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot2', 1.1, 0.6)
                    card:juice_up()
                    card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Dalgona, 'dalgona', {in_pool = function() return true end}).key)
                    return true
                end
            }))
        end
    end
}

SMODS.ObjectType{ -- Pool Dalgona
	key = "Dalgona",
	cards = {
        ['j_nic_dalgonacircle'] = true,
        ['j_nic_dalgonatriangle'] = true,
        ['j_nic_dalgonastar'] = true,
        ['j_nic_dalgonaumbrella'] = true,
    }
}

SMODS.Joker{ -- Dalgona Circle
    key = "dalgonacircle",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 0,
    pos = {x = 6, y = 0},
    config = { extra = { mult = 0, mult_gain = 3, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "High Card" or context.scoring_name == "Pair" or context.scoring_name == "Two Pair" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.success = 0
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                card.ability.extra.success = 0
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "FAILED!",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "CRACKED...",
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Dalgona Triangle
    key = "dalgonatriangle",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 0,
    pos = {x = 7, y = 0},
    config = { extra = { mult = 0, mult_gain = 10, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Three of a Kind" or context.scoring_name == "Straight" or context.scoring_name == "Flush" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.success = 0
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                card.ability.extra.success = 0
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "FAILED!",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "CRACKED...",
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Dalgona Star
    key = "dalgonastar",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 0,
    pos = {x = 8, y = 0},
    config = { extra = { xmult = 1, xmult_gain = 0.25, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Full House" or context.scoring_name == "Four of a Kind" or context.scoring_name == "Straight Flush" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.success = 0
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                card.ability.extra.success = 0
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "FAILED!",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "CRACKED...",
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{ -- Dalgona Umbrella
    key = "dalgonaumbrella",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 0,
    pos = {x = 9, y = 0},
    config = { extra = { xmult = 1, xmult_gain = 1, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Five of a Kind" or context.scoring_name == "Flush House" or context.scoring_name == "Flush Five" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.success = 0
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                card.ability.extra.success = 0
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "FAILED!",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "CRACKED...",
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{ -- Human Torch
    key = "humantorch",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 1},
    config = { extra = { levels = 1, levels_gain = 1, randomizer = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.levels_gain } }
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end

        if context.before and not context.blueprint then 
            card.ability.extra.randomizer = pseudorandom('nic_humantorch', 1, 4)
        end

        if context.cardarea == G.play and not context.blueprint and context.destroy_card == context.full_hand[card.ability.extra.randomizer] and G.GAME.current_round.hands_played == 0 and #context.full_hand == 4 then
            if context.scoring_name == "Four of a Kind" then
                return {
                    remove = true
                }
            end
        end

        if context.before then
            if context.scoring_name == "Four of a Kind" and G.GAME.current_round.hands_played == 0 and #context.full_hand == 4 then
                card.ability.extra.levels = card.ability.extra.levels + card.ability.extra.levels_gain
                return {
                    level_up = card.ability.extra.levels, level_up_hand = "Four of a Kind", 
                    message = "FLAME ON",
                    colour = G.C.BLUE,
                }
            end
        end
    end
}

SMODS.Joker{ --  Invisible Woman
    key = "invisiblewoman",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 1, y = 1},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end

        --[[if context.mod_probability and not context.blueprint and context.identifier == "glass" then
			return {
				denominator = 2
			}
        end]]

        if context.before and not context.blueprint then
            if context.scoring_name == "Four of a Kind" and #context.full_hand == 4 and #context.full_hand == 4 then
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
                    return {
                        message = "DISAPPEAR",
                        colour = G.C.BLUE
                    }
                end
            end
        end
    end
}

SMODS.Joker{ -- The Thing
    key = "thething",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 2, y = 1},
    config = { extra = { counter = 1, counter_gain = 1 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { vars = { card.ability.extra.counter, card.ability.extra.counter_gain } }
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
        if context.before and context.scoring_name == "Four of a Kind" and G.GAME.current_round.hands_played == 0 and #context.full_hand == 4 and not context.blueprint then
            card.ability.extra.counter = card.ability.extra.counter + card.ability.extra.counter_gain
            return {
                message = "CLOBBERIN' TIME",
                colour = G.C.BLUE
            }
        end
    end
}

SMODS.Joker{ -- Mister Fantastic
    key = "misterfantastic",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 3, y = 1},
    config = { extra = {} },

    calculate = function(self, card, context)
        if context.modify_scoring_hand and not context.blueprint and #context.full_hand == 4 then
            return {
                add_to_hand = true
            }
        end
        if context.scoring_name and not context.blueprint and #context.full_hand == 4 then
            if context.evaluate_poker_hand then
                return {
                    replace_scoring_name = "Four of a Kind"
                }
            end
        end
        if context.before and context.scoring_name == "Four of a Kind" and #context.full_hand == 4 and not context.blueprint then
            return {
                message = "FANTASTIC",
                colour = G.C.BLUE
            }
        end
    end
}

SMODS.Joker{ -- Incognito
    key = "incognito",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 4,
    cost = 20,
    pos = {x = 4, y = 1},
    soul_pos = {x = 5, y = 1},
    config = { extra = { xmult = 1, xmult_gain = 1 , odds = 7 } },

    loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue + 1] = { key = "nic_spades_no_debuff", set = "Other" }
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return {vars = {new_numerator, new_denominator, card.ability.extra.xmult_gain, card.ability.extra.xmult}}
    end,

    add_to_deck = function(self, card, from_debuff)
        love.audio.stop()
    end,

    --[[update = function(self, card)
        if card.edition and card.edition.key == "e_negative" then
            card.children.center:set_sprite_pos({x = 1, y = 3})
            card.children.floating_sprite:set_sprite_pos({x = 2, y = 3})
        else
            card.children.center:set_sprite_pos({x = 4, y = 1})
            card.children.floating_sprite:set_sprite_pos({x = 5, y = 1})
        end
    end,]]
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true, colour = G.C.SUITS.Spades }
        end

        if context.remove_playing_cards and not context.blueprint then
            local spades_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if not (removed_card.base.suit == "Spades") then
                    spades_cards = spades_cards + 1
                end
            end
            if spades_cards > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + (spades_cards * card.ability.extra.xmult_gain)
                return {
                    message = "+X" .. spades_cards .. " MULT!",
                    colour = G.C.SUITS.Spades,
                }
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            if not (context.other_card.base.suit == "Spades") then
                if SMODS.pseudorandom_probability(card, ('j_nic_incognito'), 1, card.ability.extra.odds) then
                    context.other_card.should_destroy = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('nic_swoon')
                            return true
                        end
                    }))
                    return { message = "SWOON!", colour = G.C.SUITS.Spades }
                else
                    return { message = "NOPE!", colour = G.C.SUITS.Spades }
                end
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Spades") then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Joker{ -- Crazy Taxi
    key = "crazytaxi",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 6, y = 1},
    config = { extra = { dollars = 1, dollars_gain = 1, resets = 1 } },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars, card.ability.extra.dollars_gain, card.ability.extra.resets, localize((G.GAME.current_round.nic_crazytaxi_card or {}).rank or 'Ace', 'ranks')}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == G.GAME.current_round.nic_crazytaxi_card.id then
                card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_gain
                return {
                    dollars = card.ability.extra.dollars
                }
            else
                card.ability.extra.dollars = card.ability.extra.resets
                return {
                    message = "Miss...",
                    colour = G.C.GOLD
                }
            end
        end
    end,
}

SMODS.Joker{ -- Strawberry Cake
    key = "strawberrycake",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 7, y = 1},
    config = { extra = { mult = 2 } },
    pools = { Food = true },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end
        if context.individual and not context.blueprint and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 then
            if not context.other_card:is_suit("Hearts") then
                local other_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:juice_up()
                        play_sound('tarot1')
                        other_card:change_suit('Hearts')
                        return true
                    end
                }))
                return {
                    message = "Love <3",
                    colour = G.C.SUITS.Hearts
                }
            end
        end
        if context.individual and context.cardarea == G.play and next(context.poker_hands['Flush']) and G.GAME.current_round.hands_played ~= 0 then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            return {
                message = "+Mult <3",
                colour = G.C.SUITS.Hearts
            }
        end
    end
}


SMODS.Joker{ -- Ratio Technique
    key = "ratiotechnique",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 8, y = 1},
    config = { extra = { ratio = 0, ratio_display = "Nothing", rank = "" } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ratio_display, card.ability.extra.rank } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end
        if not context.blueprint then 
            if ((((#G.hand.cards - #G.hand.highlighted ) * (0.70)) * 10) % 10 ) <= 4 then 
                card.ability.extra.ratio = math.floor((#G.hand.cards - #G.hand.highlighted ) * (0.70))
            else
                card.ability.extra.ratio = math.ceil((#G.hand.cards - #G.hand.highlighted ) * (0.70))
            end
            if card.ability.extra.ratio == 0 then
                card.ability.extra.ratio_display = "Nothing"
                card.ability.extra.rank = ""
            end
            if (card.ability.extra.ratio % 10) ~= 0 then
                card.ability.extra.ratio_display = card.ability.extra.ratio
                card.ability.extra.rank = "th Card"
            end
            if (card.ability.extra.ratio % 10) == 1 and (math.floor(card.ability.extra.ratio / 10) % 10) ~= 1 then
                card.ability.extra.ratio_display = card.ability.extra.ratio
                card.ability.extra.rank = "st Card"
            end
            if (card.ability.extra.ratio % 10) == 2 and (math.floor(card.ability.extra.ratio / 10) % 10) ~= 1 then
                card.ability.extra.ratio_display = card.ability.extra.ratio
                card.ability.extra.rank = "nd Card"
            end
            if (card.ability.extra.ratio % 10) == 3 and (math.floor(card.ability.extra.ratio / 10) % 10) ~= 1 then
                card.ability.extra.ratio_display = card.ability.extra.ratio
                card.ability.extra.rank = "rd Card"
            end
        end

        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.hand and (context.other_card) == G.hand.cards[card.ability.extra.ratio] and not context.end_of_round and not context.blueprint then
            if G.GAME.current_round.hands_played == 0 then
                local other_card = context.other_card
                context.other_card.should_destroy = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:juice_up()
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                return {
                    message = "|-|-|-|-|-|-o-|-|-|",
                    colour = G.C.RED
                }
            end
        end
    end
}   

SMODS.Joker{ -- Inverted Spear of Heaven
    key = "invertedspearofheaven",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 9, y = 1},
    config = { extra = { xmult = 1, bossblind = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end

            if my_pos and G.jokers.cards[my_pos - 1] and not G.jokers.cards[my_pos - 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos - 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.xmult = card.ability.extra.xmult + 0.5
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("4a157d") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end

            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.xmult = card.ability.extra.xmult + 0.5
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("4a157d") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end

            if G.GAME.blind.boss then
                if my_pos and G.jokers.cards[my_pos - 1] and my_pos and G.jokers.cards[my_pos + 1] then
                    card.ability.extra.bossblind = 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            return true
                        end
                    }))
                    return { message = "FOCUS UP", colour = HEX("4a157d") }
                end
            else
                if my_pos and G.jokers.cards[my_pos - 1] or  G.jokers.cards[my_pos + 1] then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            return true
                        end
                    }))
                    return { message = "THIS IS WAR", colour = HEX("4a157d") }
                end
            end
        end

        if context.end_of_round and not context.blueprint then
            if G.GAME.blind.boss then
                card.ability.extra.bossblind = 0
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end
}

SMODS.Joker{ -- Cyan
    key = "cyan",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 2},
    soul_pos = {x = 1, y = 2},
    config = { extra = { blind = 1.5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.blind } }
    end,

    calculate = function(self, card, context)
        if context.first_hand_drawn then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind.chips = math.floor(to_number(G.GAME.blind.chips) * card.ability.extra.blind)
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        play_sound('nic_neigh')
                        SMODS.add_card({ set = 'Spectral', key = "c_black_hole" })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = ('X' .. card.ability.extra.blind ),
                }
            else
                return {
                    message = ('No Room :('),
                }
            end
        end
    end
}

SMODS.Joker { -- Astromancer
    key = "astromancer",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 2, y = 2},

    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({ set = 'Planet' })
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return {
                message = localize('k_plus_planet'),
                colour = G.C.SECONDARY_SET.Planet
            }
        end
    end,
}

SMODS.Joker { -- Cartonomer
    key = "cartonomer",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 8,
    pos = {x = 3, y = 2},

    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
}

local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    if next(SMODS.find_card("j_nic_cartonomer")) then
        if (self.ability.set == 'Tarot' or (self.ability.set == 'Booster' and self.config.center.kind == 'Arcana')) then self.cost = 0 end
        self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
        self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
    end
end

SMODS.Joker{ -- Tierlist
    key = "tierlist",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 4, y = 2},
    config = { extra = { mult = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            local first_card = false
            for i = 1, #context.scoring_hand do
                if not SMODS.Ranks[context.scoring_hand[i].base.value].face and context.scoring_hand[i]:get_id() ~= 14 and not SMODS.has_no_rank(context.scoring_hand[i]) then
                    first_card = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            local last_card = false
            for i = #context.scoring_hand, 1, -1 do
                if not SMODS.Ranks[context.scoring_hand[i].base.value].face and context.scoring_hand[i]:get_id() ~= 14 and not SMODS.has_no_rank(context.scoring_hand[i]) then
                    last_card = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if first_card and last_card then
                return {
                    message = ("+" .. context.other_card.base.id .. " Mult"),
                    colour = G.C.MULT,
                    extra = {
                        message = ("-" .. context.other_card.base.id .. " Mult"),
                        colour = G.C.MULT
                    }
                }
            end
            if first_card then
                card.ability.extra.mult = card.ability.extra.mult + context.other_card.base.id 
                return {
                    message = ("+" .. context.other_card.base.id .. " Mult"),
                    colour = G.C.MULT
                }
            end
            if last_card then
                card.ability.extra.mult = card.ability.extra.mult - context.other_card.base.id 
                return {
                    message = ("-" .. context.other_card.base.id .. " Mult"),
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { -- Scenario
    key = "scenario",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 5, y = 2},
    config = { extra = { rarity = "Common", dollars = 0 } },

    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('hologram', nil, card.ARGS.send_to_shader)
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { G.C.RARITY[card.ability.extra.rarity] }, localize('k_' .. card.ability.extra.rarity:lower()) } }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local has_rarity = false 
            if G.jokers then
                for _, joker_card in ipairs(G.jokers.cards) do
                    if joker_card ~= card and joker_card:is_rarity(card.ability.extra.rarity) then
                        has_rarity = true
                        break
                    end
                end
            end
            if has_rarity then
                card.ability.extra.rarity = (pseudorandom_element(SMODS.Rarities, 'nic_scenario').key)
                card.ability.extra.dollars = 5
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                card.ability.extra.dollars = 0
            end
        end
    end
}

SMODS.Joker { -- Mending
    key = "mending",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 10,
    pos = {x = 6, y = 2},

    calculate = function(self, card, context)
		if context.remove_playing_cards and context.removed then
            for i = 1, #context.removed do
                local repair_card = copy_card(context.removed[i], nil, nil, G.playing_card)
                table.insert(G.playing_cards, repair_card)
                G.discard:emplace(repair_card)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    if #context.removed == 1 then
                        play_sound("nic_xporb", 0.96 + math.random() * 0.08)
                        card:juice_up()
                    else
                        play_sound("nic_xplevelup", 0.96 + math.random() * 0.08)
                        card:juice_up()
                    end
                    return true
                end
            }))
        end
    end
}

SMODS.Joker { -- Calligram Joker
    key = "calligramjoker",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 7, y = 2},
    config = { extra = { mult = 1 } },

    loc_vars = function(self, info_queue, card)
        local my_pos = nil
        local letter_count = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
        end
        if my_pos and G.jokers.cards[my_pos - 1] then
            local joker_name = G.localization.descriptions.Joker[G.jokers.cards[my_pos - 1].config.center.key].name
            if joker_name then
                for i = 1, #joker_name do
                    local letters = joker_name:sub(i,i)
                    if letters == "j" or letters == "o" or letters == "k" or letters == "e" or letters == "r" or 
                    letters == "J" or letters == "O" or letters == "K" or letters == "E" or letters == "R" then
                        letter_count = letter_count + 1
                    end
                end
            end
        end
        if my_pos and G.jokers.cards[my_pos + 1] then
            local joker_name = G.localization.descriptions.Joker[G.jokers.cards[my_pos + 1].config.center.key].name
            if joker_name then
                for i = 1, #joker_name do
                    local letters = joker_name:sub(i,i)
                    if letters == "j" or letters == "o" or letters == "k" or letters == "e" or letters == "r" or 
                    letters == "J" or letters == "O" or letters == "K" or letters == "E" or letters == "R" then
                        letter_count = letter_count + 1
                    end
                end
            end
        end
        return { vars = { card.ability.extra.mult, letter_count * card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos = nil
            local letter_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos - 1] then
                local joker_name = G.localization.descriptions.Joker[G.jokers.cards[my_pos - 1].config.center.key].name
                if joker_name then
                    for i = 1, #joker_name do
                        local letters = joker_name:sub(i,i)
                        if letters == "j" or letters == "o" or letters == "k" or letters == "e" or letters == "r" or 
                        letters == "J" or letters == "O" or letters == "K" or letters == "E" or letters == "R" then
                            letter_count = letter_count + 1
                        end
                    end
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] then
            local joker_name = G.localization.descriptions.Joker[G.jokers.cards[my_pos + 1].config.center.key].name
            if joker_name then
                for i = 1, #joker_name do
                    local letters = joker_name:sub(i,i)
                    if letters == "j" or letters == "o" or letters == "k" or letters == "e" or letters == "r" or 
                    letters == "J" or letters == "O" or letters == "K" or letters == "E" or letters == "R" then
                        letter_count = letter_count + 1
                    end
                end
            end
        end
            return {
                mult = letter_count * card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { -- Clover Pit
    key = "cloverpit",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 8, y = 2},
    config = { extra = { dollars_loss = 1, min = -5 , max = 10, mult = 0 } },

    loc_vars = function(self, info_queue, card)
        local symbol = "+"
        if card.ability.extra.mult < 0 then
            symbol = ""
        else
            symbol = "+"
        end
        return { vars = { card.ability.extra.dollars_loss, card.ability.extra.min, card.ability.extra.max, symbol, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if (context.key_press_space or (context.cry_press and card.states.hover.is == true)) and (G.GAME.dollars > (card.ability.extra.dollars_loss - 1)) then
            ease_dollars(-card.ability.extra.dollars_loss, true)
            card.ability.extra.mult = pseudorandom('j_nic_cloverpit', card.ability.extra.min, card.ability.extra.max)
            card:juice_up()
            return {
                message = "LETS GO GAMBLING!",
                colour = G.C.RED
            }
        end
        if context.end_of_round and G.GAME.blind.boss and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.dollars_loss = card.ability.extra.dollars_loss * 2
            card.ability.extra.min = card.ability.extra.min * 2
            card.ability.extra.max = card.ability.extra.max * 2
            card.ability.extra.mult = 0
            return {
                message = "LEVEL UP!",
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { -- Jokrle
    key = "jokrle",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 3,
    pos = {x = 9, y = 2},
    config = { extra = {
        tries = 0, completed = false, 
        answer = "[#] [#] [#] [#] [#]", answercolour = G.C.UI.TEXT_INACTIVE,
        grey = '666666', yellow = 'b59f3a', green = '528d4d',
        string = {1, 2, 3, 4, 5},
        lines = {
            {'#', '#', '#', '#', '#'},
            {'#', '#', '#', '#', '#'},
            {'#', '#', '#', '#', '#'},
            {'#', '#', '#', '#', '#'},
            {'#', '#', '#', '#', '#'},
            {'#', '#', '#', '#', '#'},
        },
        linescolour = {
            {'666666', '666666', '666666', '666666', '666666'},
            {'666666', '666666', '666666', '666666', '666666'},
            {'666666', '666666', '666666', '666666', '666666'},
            {'666666', '666666', '666666', '666666', '666666'},
            {'666666', '666666', '666666', '666666', '666666'},
            {'666666', '666666', '666666', '666666', '666666'},
        },
        mult = 0, mult_gain = 10
    } },

    loc_vars = function(self, info_queue, card)
        return { vars = {
            colours = {
                HEX(card.ability.extra.linescolour[1][1]), HEX(card.ability.extra.linescolour[1][2]), HEX(card.ability.extra.linescolour[1][3]), HEX(card.ability.extra.linescolour[1][4]), HEX(card.ability.extra.linescolour[1][5]),
                HEX(card.ability.extra.linescolour[2][1]), HEX(card.ability.extra.linescolour[2][2]), HEX(card.ability.extra.linescolour[2][3]), HEX(card.ability.extra.linescolour[2][4]), HEX(card.ability.extra.linescolour[2][5]),   
                HEX(card.ability.extra.linescolour[3][1]), HEX(card.ability.extra.linescolour[3][2]), HEX(card.ability.extra.linescolour[3][3]), HEX(card.ability.extra.linescolour[3][4]), HEX(card.ability.extra.linescolour[3][5]),
                HEX(card.ability.extra.linescolour[4][1]), HEX(card.ability.extra.linescolour[4][2]), HEX(card.ability.extra.linescolour[4][3]), HEX(card.ability.extra.linescolour[4][4]), HEX(card.ability.extra.linescolour[4][5]),
                HEX(card.ability.extra.linescolour[5][1]), HEX(card.ability.extra.linescolour[5][2]), HEX(card.ability.extra.linescolour[5][3]), HEX(card.ability.extra.linescolour[5][4]), HEX(card.ability.extra.linescolour[5][5]),
                HEX(card.ability.extra.linescolour[6][1]), HEX(card.ability.extra.linescolour[6][2]), HEX(card.ability.extra.linescolour[6][3]), HEX(card.ability.extra.linescolour[6][4]), HEX(card.ability.extra.linescolour[6][5]),
                card.ability.extra.answercolour,
            },
            card.ability.extra.lines[1][1], card.ability.extra.lines[1][2], card.ability.extra.lines[1][3], card.ability.extra.lines[1][4], card.ability.extra.lines[1][5],
            card.ability.extra.lines[2][1], card.ability.extra.lines[2][2], card.ability.extra.lines[2][3], card.ability.extra.lines[2][4], card.ability.extra.lines[2][5],
            card.ability.extra.lines[3][1], card.ability.extra.lines[3][2], card.ability.extra.lines[3][3], card.ability.extra.lines[3][4], card.ability.extra.lines[3][5],
            card.ability.extra.lines[4][1], card.ability.extra.lines[4][2], card.ability.extra.lines[4][3], card.ability.extra.lines[4][4], card.ability.extra.lines[4][5],
            card.ability.extra.lines[5][1], card.ability.extra.lines[5][2], card.ability.extra.lines[5][3], card.ability.extra.lines[5][4], card.ability.extra.lines[5][5],
            card.ability.extra.lines[6][1], card.ability.extra.lines[6][2], card.ability.extra.lines[6][3], card.ability.extra.lines[6][4], card.ability.extra.lines[6][5],

            card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.answer,
        } }
    end,

    add_to_deck = function(self, card, from_debuff)
        for i = 1, #card.ability.extra.string do
            card.ability.extra.string[i] = pseudorandom('j_nic_jokrle', 2, 14)
        end
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and #context.full_hand == 5 then
            local norank = true
            for i = 1, #context.full_hand do
                if SMODS.has_no_rank(context.full_hand[i]) then
                    norank = false
                end
            end
            if norank then
                if card.ability.extra.completed == false then
                    if card.ability.extra.tries < 7 then
                        card.ability.extra.tries = card.ability.extra.tries + 1
                    end
                    if card.ability.extra.tries < 7 then
                        SMODS.calculate_effect({message = ("Attempt " .. card.ability.extra.tries), colour = HEX('666666')}, card)
                    end
                end
            end
        end
        if context.after and not context.blueprint and #context.full_hand == 5 then
            if card.ability.extra.completed == false and card.ability.extra.tries == 6 then
                SMODS.calculate_effect({message = "FAILED!", colour = G.C.RED}, card)
                card.ability.extra.answercolour = HEX(card.ability.extra.green)
                for i = 1, 5 do
                    if card.ability.extra.string[i] == 10 then card.ability.extra.string[i] = "X"
                    elseif card.ability.extra.string[i] == 11 then card.ability.extra.string[i] = "J"
                    elseif card.ability.extra.string[i] == 12 then card.ability.extra.string[i] = "Q"
                    elseif card.ability.extra.string[i] == 13 then card.ability.extra.string[i] = "K"
                    elseif card.ability.extra.string[i] == 14 then card.ability.extra.string[i] = "A"
                    end
                end
                card.ability.extra.answer = "[" .. (card.ability.extra.string[1]) .. "] " .. "[" .. (card.ability.extra.string[2]) .. "] " .. "[" .. (card.ability.extra.string[3]) .. "] " .. "[" .. (card.ability.extra.string[4]) .. "] " .. "[" .. (card.ability.extra.string[5]) .. "] "
            end
        end
        if context.individual and context.full_hand and context.other_card and #context.full_hand == 5 and not context.blueprint then
            local norank = true
            for i = 1, #context.full_hand do
                if SMODS.has_no_rank(context.full_hand[i]) then
                    norank = false
                end
            end
            if norank then
                if card.ability.extra.completed == false and card.ability.extra.tries < 7 then
                    for i = 1, 5 do
                        if context.full_hand[i]:get_id() == 10 then card.ability.extra.lines[card.ability.extra.tries][i] = "X"
                        elseif context.full_hand[i]:get_id() == 11 then card.ability.extra.lines[card.ability.extra.tries][i] = "J"
                        elseif context.full_hand[i]:get_id() == 12 then card.ability.extra.lines[card.ability.extra.tries][i] = "Q"
                        elseif context.full_hand[i]:get_id() == 13 then card.ability.extra.lines[card.ability.extra.tries][i] = "K"
                        elseif context.full_hand[i]:get_id() == 14 then card.ability.extra.lines[card.ability.extra.tries][i] = "A"
                        else card.ability.extra.lines[card.ability.extra.tries][i] = context.full_hand[i]:get_id() end
                    end
                    local letter1 = true
                    local letter2 = true
                    local letter3 = true
                    local letter4 = true
                    local letter5 = true
                    if context.full_hand[1]:get_id() == card.ability.extra.string[1] then
                        letter1 = false
                    end
                    if context.full_hand[2]:get_id() == card.ability.extra.string[2] then
                        letter2 = false
                    end
                    if context.full_hand[3]:get_id() == card.ability.extra.string[3] then
                        letter3 = false
                    end
                    if context.full_hand[4]:get_id() == card.ability.extra.string[4] then
                        letter4 = false
                    end
                    if context.full_hand[5]:get_id() == card.ability.extra.string[5] then
                        letter5 = false
                    end
                    local yellow12 = true
                    local yellow13 = true
                    local yellow14 = true
                    local yellow15 = true
                    if context.full_hand[2]:get_id() == card.ability.extra.string[1] and letter1 and letter2 then
                        card.ability.extra.linescolour[card.ability.extra.tries][2] = card.ability.extra.yellow
                        yellow12 = false
                    end
                    if context.full_hand[3]:get_id() == card.ability.extra.string[1] and letter1 and letter3
                    and (yellow12) then
                        card.ability.extra.linescolour[card.ability.extra.tries][3] = card.ability.extra.yellow
                        yellow13 = false
                    end
                    if context.full_hand[4]:get_id() == card.ability.extra.string[1] and letter1 and letter4
                    and (yellow12 and yellow13) then
                        card.ability.extra.linescolour[card.ability.extra.tries][4] = card.ability.extra.yellow
                        yellow14 = false
                    end
                    if context.full_hand[5]:get_id() == card.ability.extra.string[1] and letter1 and letter5
                    and (yellow12 and yellow13 and yellow14) then
                        card.ability.extra.linescolour[card.ability.extra.tries][5] = card.ability.extra.yellow
                        yellow15 = false
                    end
                    local yellow21 = true
                    local yellow23 = true
                    local yellow24 = true
                    local yellow25 = true
                    if context.full_hand[1]:get_id() == card.ability.extra.string[2] and letter2 and letter1 then 
                        card.ability.extra.linescolour[card.ability.extra.tries][1] = card.ability.extra.yellow
                        yellow21 = false
                    end
                    if context.full_hand[3]:get_id() == card.ability.extra.string[2] and letter2 and letter3
                    and (yellow21) and (yellow13) then
                        card.ability.extra.linescolour[card.ability.extra.tries][3] = card.ability.extra.yellow
                        yellow23 = false
                    end
                    if context.full_hand[4]:get_id() == card.ability.extra.string[2] and letter2 and letter4
                    and (yellow21 and yellow23) and (yellow14) then
                        card.ability.extra.linescolour[card.ability.extra.tries][4] = card.ability.extra.yellow
                        yellow24 = false
                    end
                    if context.full_hand[5]:get_id() == card.ability.extra.string[2] and letter2 and letter5
                    and (yellow21 and yellow23 and yellow24) and (yellow15) then
                        card.ability.extra.linescolour[card.ability.extra.tries][5] = card.ability.extra.yellow
                        yellow25 = false
                    end
                    local yellow31 = true
                    local yellow32 = true
                    local yellow34 = true
                    local yellow35 = true
                    if context.full_hand[1]:get_id() == card.ability.extra.string[3] and letter3 and letter1
                    and (yellow21) then
                        card.ability.extra.linescolour[card.ability.extra.tries][1] = card.ability.extra.yellow
                        yellow31 = false
                    end
                    if context.full_hand[2]:get_id() == card.ability.extra.string[3] and letter3 and letter2
                    and (yellow31) and (yellow12) then
                        card.ability.extra.linescolour[card.ability.extra.tries][2] = card.ability.extra.yellow
                        yellow32 = false
                    end
                    if context.full_hand[4]:get_id() == card.ability.extra.string[3] and letter3 and letter4
                    and (yellow31 and yellow32) and (yellow14 and yellow24) then
                        card.ability.extra.linescolour[card.ability.extra.tries][4] = card.ability.extra.yellow
                        yellow34 = false
                    end
                    if context.full_hand[5]:get_id() == card.ability.extra.string[3] and letter3 and letter5
                    and (yellow31 and yellow32 and yellow34) and (yellow15 and yellow25) then
                        card.ability.extra.linescolour[card.ability.extra.tries][5] = card.ability.extra.yellow
                        yellow35 = false
                    end
                    local yellow41 = true
                    local yellow42 = true
                    local yellow43 = true
                    local yellow45 = true
                    if context.full_hand[1]:get_id() == card.ability.extra.string[4] and letter4 and letter1
                    and (yellow21 and yellow31) then
                        card.ability.extra.linescolour[card.ability.extra.tries][1] = card.ability.extra.yellow
                        yellow41 = false
                    end
                    if context.full_hand[2]:get_id() == card.ability.extra.string[4] and letter4 and letter2
                    and (yellow41) and (yellow12 and yellow32) then
                        card.ability.extra.linescolour[card.ability.extra.tries][2] = card.ability.extra.yellow
                        yellow42 = false
                    end
                    if context.full_hand[3]:get_id() == card.ability.extra.string[4] and letter4 and letter3
                    and (yellow41 and yellow42) and (yellow13 and yellow23) then
                        card.ability.extra.linescolour[card.ability.extra.tries][3] = card.ability.extra.yellow
                        yellow43 = false
                    end
                    if context.full_hand[5]:get_id() == card.ability.extra.string[4] and letter4 and letter5
                    and (yellow41 and yellow42 and yellow43) and (yellow15 and yellow25 and yellow35) then
                        card.ability.extra.linescolour[card.ability.extra.tries][5] = card.ability.extra.yellow
                        yellow45 = false
                    end
                    local yellow51 = true
                    local yellow52 = true
                    local yellow53 = true
                    local yellow54 = true
                    if context.full_hand[1]:get_id() == card.ability.extra.string[5] and letter5 and letter1
                    and (yellow21 and yellow31 and yellow41) then
                        card.ability.extra.linescolour[card.ability.extra.tries][1] = card.ability.extra.yellow
                        yellow51 = false
                    end
                    if context.full_hand[2]:get_id() == card.ability.extra.string[5] and letter5 and letter2
                    and (yellow51) and (yellow12 and yellow32 and yellow42) then
                        card.ability.extra.linescolour[card.ability.extra.tries][2] = card.ability.extra.yellow
                        yellow52 = false
                    end
                    if context.full_hand[3]:get_id() == card.ability.extra.string[5] and letter5 and letter3
                    and (yellow51 and yellow52) and (yellow13 and yellow23 and yellow43) then
                        card.ability.extra.linescolour[card.ability.extra.tries][3] = card.ability.extra.yellow
                        yellow53 = false
                    end
                    if context.full_hand[4]:get_id() == card.ability.extra.string[5] and letter5 and letter4
                    and (yellow51 and yellow52 and yellow53) and (yellow14 and yellow24 and yellow34) then
                        card.ability.extra.linescolour[card.ability.extra.tries][4] = card.ability.extra.yellow
                        yellow54 = false
                    end
                    local correct = 0
                    for i = 1, #context.full_hand do
                        if context.full_hand[i]:get_id() == card.ability.extra.string[i] then
                            correct = correct + 1
                            card.ability.extra.linescolour[card.ability.extra.tries][i] = card.ability.extra.green
                        end
                    end
                    if correct == 5 then
                        for i = 1, 5 do
                            if card.ability.extra.string[i] == 10 then card.ability.extra.string[i] = "X"
                            elseif card.ability.extra.string[i] == 11 then card.ability.extra.string[i] = "J"
                            elseif card.ability.extra.string[i] == 12 then card.ability.extra.string[i] = "Q"
                            elseif card.ability.extra.string[i] == 13 then card.ability.extra.string[i] = "K"
                            elseif card.ability.extra.string[i] == 14 then card.ability.extra.string[i] = "A"
                            end
                        end
                        card.ability.extra.completed = true
                        card.ability.extra.answercolour = HEX(card.ability.extra.green)
                        card.ability.extra.answer = "[" .. (card.ability.extra.string[1]) .. "] " .. "[" .. (card.ability.extra.string[2]) .. "] " .. "[" .. (card.ability.extra.string[3]) .. "] " .. "[" .. (card.ability.extra.string[4]) .. "] " .. "[" .. (card.ability.extra.string[5]) .. "] "
                        if card.ability.extra.tries == 1 then SMODS.calculate_effect({message = "GENIUS!", colour = HEX('528d4d')}, card) card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 5)
                        elseif card.ability.extra.tries == 2 then SMODS.calculate_effect({message = "MAGNIFICENT!", colour = HEX('528d4d')}, card) card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 4)
                        elseif card.ability.extra.tries == 3 then SMODS.calculate_effect({message = "IMPRESSIVE!", colour = HEX('528d4d')}, card) card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 3)
                        elseif card.ability.extra.tries == 4 then SMODS.calculate_effect({message = "SPLENDID!", colour = HEX('528d4d')}, card) card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 2)
                        elseif card.ability.extra.tries == 5 then SMODS.calculate_effect({message = "GREAT!", colour = HEX('528d4d')}, card) card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 1)
                        elseif card.ability.extra.tries == 6 then SMODS.calculate_effect({message = "PHEW!", colour = HEX('528d4d')}, card) end
                    end
                end
            end
        end
        if context.setting_blind and not context.blueprint then
            if card.ability.extra.completed == true then
                SMODS.calculate_effect({message = "NEW WORD!", colour = HEX('528d4d')}, card)
                card.ability.extra.answercolour = G.C.UI.TEXT_INACTIVE
                card.ability.extra.answer = "[#] [#] [#] [#] [#]"
                for i = 1, #card.ability.extra.string do
                    card.ability.extra.string[i] = pseudorandom('j_nic_jokrle', 2, 14)
                end
                card.ability.extra.completed = false
                card.ability.extra.tries = 0
                card.ability.extra.lines = {
                    {'#', '#', '#', '#', '#'},
                    {'#', '#', '#', '#', '#'},
                    {'#', '#', '#', '#', '#'},
                    {'#', '#', '#', '#', '#'},
                    {'#', '#', '#', '#', '#'},
                    {'#', '#', '#', '#', '#'},
                }
                card.ability.extra.linescolour = {
                    {'666666', '666666', '666666', '666666', '666666'},
                    {'666666', '666666', '666666', '666666', '666666'},
                    {'666666', '666666', '666666', '666666', '666666'},
                    {'666666', '666666', '666666', '666666', '666666'},
                    {'666666', '666666', '666666', '666666', '666666'},
                    {'666666', '666666', '666666', '666666', '666666'},
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Solar Eclipse
    key = "solareclipse",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 7,
    pos = {x = 0, y = 3},
    config = { extra = { sun = 0, moon = 0, mult = 0, chips = 0, mult_gain = 2, chips_gain = 10 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_sun
        info_queue[#info_queue + 1] = G.P_CENTERS.c_moon
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.mult_gain, card.ability.extra.chips_gain } }
    end,

    update = function(self, card)
        if self.discovered then
            if card.ability.extra.sun == card.ability.extra.moon then
                card.children.center:set_sprite_pos({x = 0, y = 3})
            end
            if card.ability.extra.sun > card.ability.extra.moon then
                card.children.center:set_sprite_pos({x = 1, y = 3})
            end
            if card.ability.extra.sun < card.ability.extra.moon then
                card.children.center:set_sprite_pos({x = 2, y = 3})
            end
        end
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.config.center.key == 'c_sun' then
                card:juice_up()
                card.ability.extra.sun = card.ability.extra.sun + 1
                card.ability.extra.mult = (card.ability.extra.sun * card.ability.extra.mult_gain)
            end
            if context.consumeable.config.center.key == 'c_moon' then
                card:juice_up()
                card.ability.extra.moon = card.ability.extra.moon + 1
                card.ability.extra.chips = (card.ability.extra.moon * card.ability.extra.chips_gain)
            end
        end

        if context.joker_main then
            if card.ability.extra.sun == card.ability.extra.moon then
                return { 
                    mult = card.ability.extra.mult,
                    chips = card.ability.extra.chips,
                }
            end
            if card.ability.extra.sun > card.ability.extra.moon then
                return { 
                    mult = card.ability.extra.mult,
                }
            end
            if card.ability.extra.sun < card.ability.extra.moon then
                return { 
                    chips = card.ability.extra.chips,
                }
            end
        end
    end
}

SMODS.Joker{ -- Invert 
    key = "invert",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 4,
    cost = 20,
    pos = {x = 3, y = 3},
    soul_pos = {x = 4, y = 3},
    config = { extra = { handsize = 0 , odds = 7 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return {vars = {new_numerator, new_denominator, card.ability.extra.handsize}}
    end,

    add_to_deck = function(self, card, from_debuff)
        love.audio.stop()
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.handsize)
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true, colour = G.C.DARK_EDITION }
        end

        if context.remove_playing_cards and not context.blueprint then
            local spades_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if (removed_card.base.suit == "Spades") then 
                    if removed_card.edition and removed_card.edition.negative == true then
                        spades_cards = spades_cards + 1
                    end
                end
            end
            if spades_cards > 0 then
                card.ability.extra.handsize = card.ability.extra.handsize + (spades_cards)
                G.hand:change_size(spades_cards)
                return {
                    message = "+" .. spades_cards .. " HAND SIZE!",
                    colour = G.C.SUITS.Spades,
                }
            end
        end

        if context.individual and context.cardarea == G.play and not context.blueprint and context.other_card:is_suit("Spades") then
            context.other_card.should_destroy = true
            return { message = "HAHAHA!", colour = G.C.DARK_EDITION }
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            if context.other_card.edition and context.other_card.edition.negative == true then
            else
                if (context.other_card.base.suit == "Spades") then
                    if SMODS.pseudorandom_probability(card, ('j_nic_invert'), 1, card.ability.extra.odds) then
                        local other_card = context.other_card
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                other_card:set_edition('e_negative', nil, true)
                                return true
                            end
                        }))
                        return { message = "HAHAHA!", colour = G.C.DARK_EDITION }
                    else
                        return { message = "NOPE!", colour = G.C.DARK_EDITION }
                    end
                end
            end
        end
    end
}

SMODS.Joker{ -- Death
    key = "death",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 7,
    pos = {x = 5, y = 3},
    config = { extra = { fear = false } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_death
        return { }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.fear = true
        return {
            play_sound('nic_deathwhistle')
        }
    end,

    remove_from_deck = function(self, card, from_debuff)
        card.ability.extra.fear = false
    end,

    update = function(self, card)
        if card.ability.extra.fear then
            G.PITCH_MOD = 0
        end
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 9 then
            context.other_card.should_destroy = true
            return {
                message = "Death...",
                colour = G.C.RED,
                message_card = card,
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({ set = 'Tarot', key = "c_death", edition = "e_negative" })
                        return true
                    end
                }))
            }
        end

        if context.post_trigger and context.other_ret.jokers and context.other_ret.jokers.saved and not context.blueprint then
            card:juice_up()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1.5,
                func = function()
                    G.GAME.death_text = "death"
                    G.GAME.death_texture = "nicjokers"
                    G.STATE = G.STATES.GAME_OVER
                    G.FILE_HANDLER.force = true
                    G.STATE_COMPLETE = false
                    return true
                end
            }))
        end
    end
}

SMODS.Joker { -- Cuphead
    key = "cuphead",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 6, y = 3},
    pixel_size = { h = 80 },
    config = { extra = { parry = 0, mult = 4, mult_gain = 4 } },

    loc_vars = function(self, info_queue, card)
        local card1 = "*"
        local card2 = "*"
        local card3 = "*"
        local card4 = "*"
        local card5 = "*"
        local colour1 = G.C.UI.TEXT_INACTIVE
        local colour2 = G.C.UI.TEXT_INACTIVE
        local colour3 = G.C.UI.TEXT_INACTIVE
        local colour4 = G.C.UI.TEXT_INACTIVE
        local colour5 = G.C.UI.TEXT_INACTIVE
        if card.ability.extra.parry > 0 then card1 = "[]" colour1 = G.C.SUITS.Hearts else card1 = "*" colour1 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 1 then card2 = "[]" colour2 = G.C.SUITS.Hearts else card2 = "*" colour2 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 2 then card3 = "[]" colour3 = G.C.SUITS.Hearts else card3 = "*" colour3 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 3 then card4 = "[]" colour4 = G.C.SUITS.Hearts else card4 = "*" colour4 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 4 then card5 = "[]" colour5 = G.C.SUITS.Hearts else card5 = "*" colour5 = G.C.UI.TEXT_INACTIVE end
        return { vars = { colours = { colour1, colour2, colour3, colour4, colour5 }, card1, card2, card3, card4, card5, card.ability.extra.mult, card.ability.extra.mult * 5, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint and context.other_card:is_suit("Hearts") then
            local parry = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Hearts") then
                    parry = true
                end
            end
            if parry then
                if card.ability.extra.parry < 5 then
                    card.ability.extra.parry = card.ability.extra.parry + 1
                    return {
                        message = "PARRY!",
                        colour = G.C.SUITS.Hearts
                    }
                elseif card.ability.extra.parry == 5 then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                    return {
                        message = "EXTRA PARRY!",
                        colour = G.C.SUITS.Hearts
                    }
                end
            end
        end
        if context.joker_main then
            local parry = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Hearts") then
                    parry = true
                end
            end
            if parry then
            else
                if card.ability.extra.parry == 5 then
                    card.ability.extra.parry = 0
                    return {
                        message = "SUPER EX!",
                        colour = G.C.SUITS.Hearts,
                        mult = card.ability.extra.mult * 5
                    }
                elseif card.ability.extra.parry > 0 then
                    card.ability.extra.parry = card.ability.extra.parry - 1
                    return {
                        message = "EX!",
                        colour = G.C.SUITS.Hearts,
                        mult = card.ability.extra.mult
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Mugman
    key = "mugman",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 7, y = 3},
    pixel_size = { h = 80 },
    config = { extra = { parry = 0, chips = 31, chips_gain = 31 } },

    loc_vars = function(self, info_queue, card)
        local card1 = "*"
        local card2 = "*"
        local card3 = "*"
        local card4 = "*"
        local card5 = "*"
        local colour1 = G.C.UI.TEXT_INACTIVE
        local colour2 = G.C.UI.TEXT_INACTIVE
        local colour3 = G.C.UI.TEXT_INACTIVE
        local colour4 = G.C.UI.TEXT_INACTIVE
        local colour5 = G.C.UI.TEXT_INACTIVE
        if card.ability.extra.parry > 0 then card1 = "[]" colour1 = G.C.SUITS.Clubs else card1 = "*" colour1 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 1 then card2 = "[]" colour2 = G.C.SUITS.Clubs else card2 = "*" colour2 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 2 then card3 = "[]" colour3 = G.C.SUITS.Clubs else card3 = "*" colour3 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 3 then card4 = "[]" colour4 = G.C.SUITS.Clubs else card4 = "*" colour4 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 4 then card5 = "[]" colour5 = G.C.SUITS.Clubs else card5 = "*" colour5 = G.C.UI.TEXT_INACTIVE end
        return { vars = { colours = { colour1, colour2, colour3, colour4, colour5 }, card1, card2, card3, card4, card5, card.ability.extra.chips, card.ability.extra.chips * 5, card.ability.extra.chips_gain } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint and context.other_card:is_suit("Clubs") then
            local parry = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Clubs") then
                    parry = true
                end
            end
            if parry then
                if card.ability.extra.parry < 5 then
                    card.ability.extra.parry = card.ability.extra.parry + 1
                    return {
                        message = "PARRY!",
                        colour = G.C.SUITS.Clubs
                    }
                elseif card.ability.extra.parry == 5 then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                    return {
                        message = "EXTRA PARRY!",
                        colour = G.C.SUITS.Clubs
                    }
                end
            end
        end
        if context.joker_main then
            local parry = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Clubs") then
                    parry = true
                end
            end
            if parry then
            else
                if card.ability.extra.parry == 5 then
                    card.ability.extra.parry = 0
                    return {
                        message = "SUPER EX!",
                        colour = G.C.SUITS.Clubs,
                        chips = card.ability.extra.chips * 5
                    }
                elseif card.ability.extra.parry > 0 then
                    card.ability.extra.parry = card.ability.extra.parry - 1
                    return {
                        message = "EX!",
                        colour = G.C.SUITS.Clubs,
                        chips = card.ability.extra.chips
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Selenologist
    key = "selenologist",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 8, y = 3},
    config = { extra = { odds = 100 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        info_queue[#info_queue + 1] = { key = "nic_specialphases", set = "Other", vars = { new_numerator, new_denominator, } }
        return { vars = { } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, ('moonchange'), 1, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('nic_glitch')
                        SMODS.add_card({ set = 'SpecialPhases', area = G.consumeables })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            else
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({ set = 'BasePhases', area = G.consumeables })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            end
            return {
                message = localize('k_nic_plus_phases'),
                colour = G.C.NIC_PHASES
            }
        end
    end,
}

--[[SMODS.Joker { --
    key = "test",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 8, y = 3},
    config = { extra = { planet = nil } },

    loc_vars = function(self, info_queue, card)
        local planet = nil
        if G.GAME.last_hand_played then
            for _, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == G.GAME.last_hand_played then
                    planet = v.key
                end
            end
        end
        info_queue[#info_queue+1] = planet and G.P_CENTERS[planet]
        local last_planet = card.ability.extra.planet and localize { type = 'name_text', key = card.ability.extra.planet, set = "Planet" } or localize('k_none')
        return { vars = { planet, last_planet } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
            card.ability.extra.planet = context.consumeable.config.center.key
        end
    end,
}]]