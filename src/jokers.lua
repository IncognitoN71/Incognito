SMODS.Atlas{ -- Jokers
    key = "nicjokers",
    path = "nicjokers.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Technoblade
    key = "technoblade",
    blueprint_compat = false,
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
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            for _, steel_card in ipairs(G.hand.cards) do
                if not next(SMODS.get_enhancements(steel_card)) and not steel_card.debuff then
                    steel_card:set_ability('m_steel', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            steel_card:juice_up()
                            play_sound("nic_machinedramon")
                            return true
                        end
                    }))
                end
            end
        end

        if context.after and not context.blueprint then
            for _, steel_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(steel_card, 'm_steel') and not steel_card.getting_sliced then
                    SMODS.destroy_cards(steel_card)
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "mult", 
                        scalar_value = "mult_gain",
                        no_message = true,
                    })
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult", 
                        scalar_value = "xmult_gain",
                        no_message = true,
                    })
                end
            end
            SMODS.calculate_effect({message = localize('k_nic_assemble_ex'), colour = G.C.BLACK}, card)
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
    attributes = { 'xmult', },
    pos = {x = 2, y = 0 },
    config = { extra = { xmult = 0.5, xmult_gain = 0.05 , odds = 100 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return {vars = {new_numerator, new_denominator, card.ability.extra.xmult, card.ability.extra.xmult_gain}}
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult 
            }
        end
    end,

    keep_on_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, ('j_nic_button'),  1, card.ability.extra.odds) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("nic_explosion")
                    card:start_dissolve({G.C.RED})
                    card:juice_up(10, 10)
                    SMODS.calculate_effect({message = localize('k_nic_boom_ex'), colour = G.C.RED}, card)
                    return true
                end
            }))
        else
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("nic_click")
                    card:juice_up()
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult", 
                        scalar_value = "xmult_gain",
                        no_message = true,
                    })
                    return true
                end
            }))
        end
    end,

    can_use = function(self, card)
        return true
    end
}

SMODS.Joker{ -- Sly Cooper
    key = "sly_cooper",
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
        if context.end_of_round and context.game_over == false and context.main_eval then
            if next(SMODS.find_mod('hyperfixation_mod')) then
            else
                local eval = function(card) return card.ability.extra.slycooper_remaining == 0 and not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            card.ability.extra.slycooper_remaining = 0
            return { message = localize('k_nic_active_ex'), colour = G.C.RED }
        end

        if context.starting_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("nic_gambling")
                    return true
                end
            }))
        end

        if context.ending_shop then
            card.ability.extra.slycooper_remaining = 1
        end

        if card.ability.extra.slycooper_remaining == 0 then
            if (context.buying_card or context.nic_buying_booster or context.nic_buying_voucher) and context.card.cost > 0 then
                card.ability.extra.slycooper_remaining = 1
                if SMODS.pseudorandom_probability(card, ('j_nic_sly_cooper'), 1, card.ability.extra.odds) then
                    context.card.cost = context.card.cost * 2
                    SMODS.calculate_effect({message = localize('k_nic_caught_ex'), colour = G.C.RED}, context.card)
                    play_sound('nic_metalalert')
                else 
                    context.card.cost = 0
                    SMODS.calculate_effect({message = localize('k_nic_snatch_ex'), colour = G.C.GREEN}, context.card)
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
        if G.playing_cards then
            for _, stone_card in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(stone_card, 'm_stone') then stone_tally = stone_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain, card.ability.extra.chips * stone_tally } }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            for _, stone_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(stone_card, 'm_stone') and not stone_card.getting_sliced then
                    if stone_card.edition and stone_card.edition.negative == true then
                        SMODS.destroy_cards(stone_card)
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "chips", 
                            scalar_value = "chips_gain",
                            no_message = true,
                        })
                    else
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                stone_card:juice_up()
                                stone_card:set_edition('e_negative', nil, true)
                                play_sound("nic_dripstone")
                                return true
                            end
                        }))
                    end
                end
            end
            SMODS.calculate_effect({message = localize('k_nic_impaled_ex'), colour = G.C.BLACK}, card)
        end

        if context.joker_main then
            local stone_tally = 0
            for _, stone_card in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(stone_card, 'm_stone') then stone_tally = stone_tally + 1 end
            end
            return {
                chips = card.ability.extra.chips * stone_tally
            }
        end
    end
}

SMODS.Joker{ -- Dalgona Cookie
    key = "dalgona_cookie",
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
        ['j_nic_dalgona_circle'] = true,
        ['j_nic_dalgona_triangle'] = true,
        ['j_nic_dalgona_star'] = true,
        ['j_nic_dalgona_umbrella'] = true,
    }
}

SMODS.Joker{ -- Dalgona Circle
    key = "dalgona_circle",
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
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult", 
                    scalar_value = "mult_gain",
                    scaling_message = {
                        message = localize('k_nic_success_ex'),
                        colour = G.C.MONEY
                    }
                })
            else
                card.ability.extra.success = 0
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card)
                    return {
                        message = localize('k_nic_failed_ex'),
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = localize('k_nic_cracked'),
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
    key = "dalgona_triangle",
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
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult", 
                    scalar_value = "mult_gain",
                    scaling_message = {
                        message = localize('k_nic_success_ex'),
                        colour = G.C.MONEY
                    }
                })
            else
                card.ability.extra.success = 0
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card)
                    return {
                        message = localize('k_nic_failed_ex'),
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = localize('k_nic_cracked'),
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
    key = "dalgona_star",
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
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult", 
                    scalar_value = "xmult_gain",
                    scaling_message = {
                        message = localize('k_nic_success_ex'),
                        colour = G.C.MONEY
                    }
                })
            else
                card.ability.extra.success = 0
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card)
                    return {
                        message = localize('k_nic_failed_ex'),
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = localize('k_nic_cracked'),
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
    key = "dalgona_umbrella",
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
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult", 
                    scalar_value = "xmult_gain",
                    scaling_message = {
                        message = localize('k_nic_success_ex'),
                        colour = G.C.MONEY
                    }
                })
            else
                card.ability.extra.success = 0
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card)
                    return {
                        message = localize('k_nic_failed_ex'),
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = localize('k_nic_cracked'),
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
    key = "human_torch",
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
        if context.after and context.scoring_name == "Four of a Kind" and #context.full_hand == 4 then
            local played_hand = {}
            for i = 1, #context.scoring_hand do
                if not context.scoring_hand[i].getting_sliced then
                    played_hand[#played_hand + 1] = context.scoring_hand[i]
                end
            end
            local destroy_card = pseudorandom_element(played_hand, 'j_nic_human_torch')
            if destroy_card then
                SMODS.destroy_cards(destroy_card)
                delay(0.5)
            end
        end

        if context.remove_playing_cards and not context.blueprint then
            local cards = 0
            for _, removed_card in ipairs(context.removed) do
                cards = cards + 1
            end
            if cards > 0 then
                card.ability.extra.levels = card.ability.extra.levels + (card.ability.extra.levels_gain * cards)
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.BLUE,
                }
            end
        end

        if context.before and context.scoring_name == "Four of a Kind" and #context.full_hand == 4 then
            return {
                level_up = card.ability.extra.levels, level_up_hand = "Four of a Kind", 
                message = localize('k_nic_flame_on_ex'),
                colour = G.C.BLUE,
            }
        end
    end
}

SMODS.Joker{ --  Invisible Woman
    key = "invisible_woman",
    blueprint_compat = false,
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
        --[[if context.mod_probability and not context.blueprint and context.identifier == "glass" then
			return {
				denominator = 2
			}
        end]]

        if context.before and context.scoring_name == "Four of a Kind" and #context.full_hand == 4 then
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
                message = localize('k_nic_disappear_ex'),
                colour = G.C.BLUE
            }
        end
    end
}

SMODS.Joker{ -- The Thing
    key = "the_thing",
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
            G.E_MANAGER:add_event(Event({
                func = function()
                    for i = 1, card.ability.extra.counter do
                        local stone_card = SMODS.create_card { set = "Base", enhancement = "m_stone", seal = SMODS.poll_seal({ guaranteed = true }), silent = true, area = G.discard }
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        stone_card.playing_card = G.playing_card
                        table.insert(G.playing_cards, stone_card)
                        
                        stone_card:start_materialize()
                        G.play:emplace(stone_card)
                    end
                    return true
                end
            }))
            delay(0.5)
            return {
                message = localize('k_nic_clobberin_time_ex'),
                colour = G.C.BLUE,
                func = function()
                    for i = 1, card.ability.extra.counter do
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.deck.config.card_limit = G.deck.config.card_limit + 1
                                return true
                            end
                        }))
                        draw_card(G.play, G.deck, 90, 'up')
                        SMODS.calculate_context({ playing_card_added = true, cards = { stone_card } })
                    end
                end
            }
        end
        if context.before and context.scoring_name == "Four of a Kind" and #context.full_hand == 4 and not context.blueprint then
            card.ability.extra.counter = card.ability.extra.counter + card.ability.extra.counter_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.BLUE
            }
        end
    end
}

SMODS.Joker{ -- Mister Fantastic
    key = "mister_fantastic",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 3, y = 1},
    config = { extra = {} },

    calculate = function(self, card, context)
        if context.modify_scoring_hand and #context.full_hand == 4 then
            return {
                add_to_hand = true
            }
        end
        if context.scoring_name then
            if context.evaluate_poker_hand and #context.full_hand == 4 then
                return {
                    replace_scoring_name = "Four of a Kind",
                }
            end
        end
        if context.before and context.scoring_name == "Four of a Kind" and #context.full_hand == 4 then
            return {
                message = localize('k_nic_fantastic_ex'),
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
        if context.remove_playing_cards and not context.blueprint then
            local spades_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if not (removed_card.base.suit == "Spades") then
                    spades_cards = spades_cards + 1
                end
            end
            if spades_cards > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult", 
                    scalar_value = "xmult_gain",
                    no_message = true,
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + spades_cards * change
                    end,
                })
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { spades_cards } },
                    colour = G.C.SUITS.Spades,
                }
            end
        end

        if context.after and not context.blueprint then
            local spades_cards = {}
            for i = 1, #G.hand.cards do
                if not (G.hand.cards[i].base.suit == "Spades") then
                    if SMODS.pseudorandom_probability(card, ('j_nic_incognito'), 1, card.ability.extra.odds) then
                        spades_cards[#spades_cards + 1] = G.hand.cards[i]
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('nic_swoon')
                                return true
                            end
                        }))
                        SMODS.calculate_effect({message = localize('k_nic_swoon_ex'), colour = G.C.SUITS.Spades}, G.hand.cards[i])
                    else
                        SMODS.calculate_effect({message = localize('k_nope_ex'), colour = G.C.SUITS.Spades}, G.hand.cards[i])
                    end
                end
            end
            if spades_cards then
                SMODS.destroy_cards(spades_cards)
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
    key = "crazy_taxi",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 6, y = 1},
    config = { extra = { dollars = 1, dollars_gain = 1, resets = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_gain, card.ability.extra.resets, localize((G.GAME.current_round.nic_crazy_taxi_card or {}).rank or 'Ace', 'ranks') } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then 
            local money = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == G.GAME.current_round.nic_crazy_taxi_card.id then
                    money = true
                end
            end
            if money then 
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "dollars", 
                    scalar_value = "dollars_gain",
                    scaling_message = {
                        colour = G.C.MONEY
                    }
                })
            else
                card.ability.extra.dollars = card.ability.extra.resets
                return {
                    message = localize('k_nic_failure_ex'),
                    colour = G.C.GOLD
                }
            end
        end

        if context.joker_main then
            return {
                dollars = card.ability.extra.dollars,
            }
        end
    end,
}

SMODS.Joker{ -- Strawberry Cake
    key = "strawberry_cake",
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
        if context.new_suit == "Hearts" then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            return {
                message = localize('k_nic_love_heart'),
                colour = G.C.SUITS.Hearts,
                message_card = context.other_card
            }
        end
    end
}

SMODS.Joker{ -- Ratio Technique
    key = "ratio_technique",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 8, y = 1},
    config = { extra = { ratio = 0 } },

    loc_vars = function(self, info_queue, card)
        local display = "Nothing"
        local rank = ""
        if card.ability.extra.ratio == 0 then
            display = "Nothing"
            rank = ""
        end
        if (card.ability.extra.ratio % 10) ~= 0 then
            display = card.ability.extra.ratio
            rank = "th Card"
        end
        if (card.ability.extra.ratio % 10) == 1 and (math.floor(card.ability.extra.ratio / 10) % 10) ~= 1 then
            display = card.ability.extra.ratio
            rank = "st Card"
        end
        if (card.ability.extra.ratio % 10) == 2 and (math.floor(card.ability.extra.ratio / 10) % 10) ~= 1 then
            display = card.ability.extra.ratio
            rank = "nd Card"
        end
        if (card.ability.extra.ratio % 10) == 3 and (math.floor(card.ability.extra.ratio / 10) % 10) ~= 1 then
            display = card.ability.extra.ratio
            rank = "rd Card"
        end
        if card.area and card.area == G.jokers then
            local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = G.GAME.current_round.hands_played == 0 and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' (Currently: ' .. display .. rank .. ') ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end

        local ratio_location = {}
        for i = 1, #G.hand.cards do
            if not G.hand.cards[i].highlighted and not G.hand.cards[i].getting_sliced then
                ratio_location[#ratio_location + 1] = G.hand.cards[i]
            end
        end
        if (((( #ratio_location ) * (0.70)) * 10) % 10 ) <= 4 then 
            card.ability.extra.ratio = math.floor(( #ratio_location ) * (0.70))
        else
            card.ability.extra.ratio = math.ceil(( #ratio_location ) * (0.70))
        end

        if context.before then
            if G.GAME.current_round.hands_played == 0 then
                local ratio = ratio_location[card.ability.extra.ratio]
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ratio:juice_up()
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                SMODS.destroy_cards(ratio)
                SMODS.calculate_effect({message = localize('k_nic_ratio'), colour = G.C.RED}, ratio)
            end
        end
    end
}   

SMODS.Joker{ -- Inverted Spear of Heaven
    key = "inverted_spear_of_heaven",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 2},
    config = { extra = { xmult = 1, xmult_gain = 0.5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
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

            if my_pos and G.jokers.cards[my_pos - 1] and not G.jokers.cards[my_pos - 1].getting_sliced and not context.blueprint then
                local sliced_card = G.jokers.cards[my_pos - 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xmult", 
                            scalar_value = "xmult_gain",
                            no_message = true,
                        })
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("4a157d") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end

            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].getting_sliced and not context.blueprint then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xmult", 
                            scalar_value = "xmult_gain",
                            no_message = true,
                        })
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("4a157d") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end

            if G.GAME.blind.boss and not context.blueprint then
                if my_pos and G.jokers.cards[my_pos - 1] and my_pos and G.jokers.cards[my_pos + 1] then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            return true
                        end
                    }))
                    return { message = localize('k_nic_focus_up_ex'), colour = HEX("4a157d") }
                end
            else
                if my_pos and G.jokers.cards[my_pos - 1] or  G.jokers.cards[my_pos + 1] then
                    return { message = localize('k_nic_this_is_war_ex'), colour = HEX("4a157d") }
                end
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
    pos = {x = 1, y = 2},
    soul_pos = {x = 2, y = 2},
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
                        play_sound('nic_neigh')
                        SMODS.add_card({ set = 'Spectral', key = "c_black_hole" })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    xblindsize = card.ability.extra.blind
                }
            else
                return {
                    message = localize('k_no_room_ex')
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
    pos = {x = 3, y = 2},

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
    pos = {x = 4, y = 2},

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
    pos = {x = 5, y = 2},
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
                    message = localize { type = 'variable', key = 'a_mult', vars = { context.other_card.base.id } },
                    colour = G.C.MULT,
                    extra = {
                        message = localize { type = 'variable', key = 'a_mult_minus', vars = { context.other_card.base.id } },
                        colour = G.C.MULT
                    }
                }
            end
            if first_card then
                card.ability.extra.mult = card.ability.extra.mult + context.other_card.base.id 
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { context.other_card.base.id } },
                    colour = G.C.MULT
                }
            end
            if last_card then
                card.ability.extra.mult = card.ability.extra.mult - context.other_card.base.id 
                return {
                    message = localize { type = 'variable', key = 'a_mult_minus', vars = { context.other_card.base.id } },
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
    pos = {x = 6, y = 2},
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
                    message = localize('k_nic_success_ex'),
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
    pos = {x = 7, y = 2},

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
    key = "calligram_joker",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 8, y = 2},
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
    key = "clover_pit",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 9, y = 2},
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
        if context.end_of_round and G.GAME.blind.boss and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.dollars_loss = card.ability.extra.dollars_loss * 2
            card.ability.extra.min = card.ability.extra.min * 2
            card.ability.extra.max = card.ability.extra.max * 2
            card.ability.extra.mult = 0
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    keep_on_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                ease_dollars(-card.ability.extra.dollars_loss, true)
                card.ability.extra.mult = pseudorandom('j_nic_cloverpit', card.ability.extra.min, card.ability.extra.max)
                card:juice_up()
                SMODS.calculate_effect({message = localize('k_nic_lets_go_gambling_ex'), colour = G.C.RED}, card)
                return true
            end
        }))
    end,

    can_use = function(self, card)
        return G.GAME.dollars > (card.ability.extra.dollars_loss - 1)
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
    pos = {x = 0, y = 3},
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
        if context.setting_blind and not context.blueprint then
            if card.ability.extra.completed == true or card.ability.extra.tries == 6 then
                SMODS.calculate_effect({message = localize('k_nic_new_word_ex'), colour = HEX('528d4d')}, card)
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
    end,

    keep_on_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        if card.ability.extra.completed == false and card.ability.extra.tries < 6 then
            card.ability.extra.tries = card.ability.extra.tries + 1
            SMODS.calculate_effect({message = ("Attempt " .. card.ability.extra.tries), colour = HEX('666666')}, card)
            local selected = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].highlighted then
                    selected[#selected + 1] = G.hand.cards[i]
                end
            end
            for i = 1, 5 do
                if selected[i]:get_id() == 10 then 
                    card.ability.extra.lines[card.ability.extra.tries][i] = "X"
                elseif selected[i]:get_id() == 11 then 
                    card.ability.extra.lines[card.ability.extra.tries][i] = "J"
                elseif selected[i]:get_id() == 12 then 
                    card.ability.extra.lines[card.ability.extra.tries][i] = "Q"
                elseif selected[i]:get_id() == 13 then 
                    card.ability.extra.lines[card.ability.extra.tries][i] = "K"
                elseif selected[i]:get_id() == 14 then 
                    card.ability.extra.lines[card.ability.extra.tries][i] = "A"
                else 
                    card.ability.extra.lines[card.ability.extra.tries][i] = selected[i]:get_id() 
                end
            end

            local letter1, letter2, letter3, letter4, letter5 = true, true, true, true, true
            if selected[1]:get_id() == card.ability.extra.string[1] then
                letter1 = false
            end
            if selected[2]:get_id() == card.ability.extra.string[2] then
                letter2 = false
            end
            if selected[3]:get_id() == card.ability.extra.string[3] then
                letter3 = false
            end
            if selected[4]:get_id() == card.ability.extra.string[4] then
                letter4 = false
            end
            if selected[5]:get_id() == card.ability.extra.string[5] then
                letter5 = false
            end

            local yellow12, yellow13, yellow14, yellow15 = true, true, true, true
            if selected[2]:get_id() == card.ability.extra.string[1] and letter1 and letter2 then
                card.ability.extra.linescolour[card.ability.extra.tries][2] = card.ability.extra.yellow
                yellow12 = false
            end
            if selected[3]:get_id() == card.ability.extra.string[1] and letter1 and letter3
            and (yellow12) then
                card.ability.extra.linescolour[card.ability.extra.tries][3] = card.ability.extra.yellow
                yellow13 = false
            end
            if selected[4]:get_id() == card.ability.extra.string[1] and letter1 and letter4
            and (yellow12 and yellow13) then
                card.ability.extra.linescolour[card.ability.extra.tries][4] = card.ability.extra.yellow
                yellow14 = false
            end
            if selected[5]:get_id() == card.ability.extra.string[1] and letter1 and letter5
            and (yellow12 and yellow13 and yellow14) then
                card.ability.extra.linescolour[card.ability.extra.tries][5] = card.ability.extra.yellow
                yellow15 = false
            end

            local yellow21, yellow23, yellow24, yellow25 = true, true, true, true
            if selected[1]:get_id() == card.ability.extra.string[2] and letter2 and letter1 then 
                card.ability.extra.linescolour[card.ability.extra.tries][1] = card.ability.extra.yellow
                yellow21 = false
            end
            if selected[3]:get_id() == card.ability.extra.string[2] and letter2 and letter3
            and (yellow21) and (yellow13) then
                card.ability.extra.linescolour[card.ability.extra.tries][3] = card.ability.extra.yellow
                yellow23 = false
            end
            if selected[4]:get_id() == card.ability.extra.string[2] and letter2 and letter4
            and (yellow21 and yellow23) and (yellow14) then
                card.ability.extra.linescolour[card.ability.extra.tries][4] = card.ability.extra.yellow
                yellow24 = false
            end
            if selected[5]:get_id() == card.ability.extra.string[2] and letter2 and letter5
            and (yellow21 and yellow23 and yellow24) and (yellow15) then
                card.ability.extra.linescolour[card.ability.extra.tries][5] = card.ability.extra.yellow
                yellow25 = false
            end

            local yellow31, yellow32, yellow34, yellow35 = true, true, true, true
            if selected[1]:get_id() == card.ability.extra.string[3] and letter3 and letter1
            and (yellow21) then
                card.ability.extra.linescolour[card.ability.extra.tries][1] = card.ability.extra.yellow
                yellow31 = false
            end
            if selected[2]:get_id() == card.ability.extra.string[3] and letter3 and letter2
            and (yellow31) and (yellow12) then
                card.ability.extra.linescolour[card.ability.extra.tries][2] = card.ability.extra.yellow
                yellow32 = false
            end
            if selected[4]:get_id() == card.ability.extra.string[3] and letter3 and letter4
            and (yellow31 and yellow32) and (yellow14 and yellow24) then
                card.ability.extra.linescolour[card.ability.extra.tries][4] = card.ability.extra.yellow
                yellow34 = false
            end
            if selected[5]:get_id() == card.ability.extra.string[3] and letter3 and letter5
            and (yellow31 and yellow32 and yellow34) and (yellow15 and yellow25) then
                card.ability.extra.linescolour[card.ability.extra.tries][5] = card.ability.extra.yellow
                yellow35 = false
            end

            local yellow41, yellow42, yellow43, yellow45 = true, true, true, true
            if selected[1]:get_id() == card.ability.extra.string[4] and letter4 and letter1
            and (yellow21 and yellow31) then
                card.ability.extra.linescolour[card.ability.extra.tries][1] = card.ability.extra.yellow
                yellow41 = false
            end
            if selected[2]:get_id() == card.ability.extra.string[4] and letter4 and letter2
            and (yellow41) and (yellow12 and yellow32) then
                card.ability.extra.linescolour[card.ability.extra.tries][2] = card.ability.extra.yellow
                yellow42 = false
            end
            if selected[3]:get_id() == card.ability.extra.string[4] and letter4 and letter3
            and (yellow41 and yellow42) and (yellow13 and yellow23) then
                card.ability.extra.linescolour[card.ability.extra.tries][3] = card.ability.extra.yellow
                yellow43 = false
            end
            if selected[5]:get_id() == card.ability.extra.string[4] and letter4 and letter5
            and (yellow41 and yellow42 and yellow43) and (yellow15 and yellow25 and yellow35) then
                card.ability.extra.linescolour[card.ability.extra.tries][5] = card.ability.extra.yellow
                yellow45 = false
            end

            local yellow51, yellow52, yellow53, yellow54 = true, true, true, true
            if selected[1]:get_id() == card.ability.extra.string[5] and letter5 and letter1
            and (yellow21 and yellow31 and yellow41) then
                card.ability.extra.linescolour[card.ability.extra.tries][1] = card.ability.extra.yellow
                yellow51 = false
            end
            if selected[2]:get_id() == card.ability.extra.string[5] and letter5 and letter2
            and (yellow51) and (yellow12 and yellow32 and yellow42) then
                card.ability.extra.linescolour[card.ability.extra.tries][2] = card.ability.extra.yellow
                yellow52 = false
            end
            if selected[3]:get_id() == card.ability.extra.string[5] and letter5 and letter3
            and (yellow51 and yellow52) and (yellow13 and yellow23 and yellow43) then
                card.ability.extra.linescolour[card.ability.extra.tries][3] = card.ability.extra.yellow
                yellow53 = false
            end
            if selected[4]:get_id() == card.ability.extra.string[5] and letter5 and letter4
            and (yellow51 and yellow52 and yellow53) and (yellow14 and yellow24 and yellow34) then
                card.ability.extra.linescolour[card.ability.extra.tries][4] = card.ability.extra.yellow
                yellow54 = false
            end
            
            local correct = 0
            for i = 1, 5 do
                if selected[i]:get_id() == card.ability.extra.string[i] then
                    correct = correct + 1
                    card.ability.extra.linescolour[card.ability.extra.tries][i] = card.ability.extra.green
                end
            end
            if correct == 5 then
                card.ability.extra.completed = true
                card.ability.extra.answercolour = HEX(card.ability.extra.green)
                card.ability.extra.answer = "[" .. (card.ability.extra.string[1]) .. "] " .. "[" .. (card.ability.extra.string[2]) .. "] " .. "[" .. (card.ability.extra.string[3]) .. "] " .. "[" .. (card.ability.extra.string[4]) .. "] " .. "[" .. (card.ability.extra.string[5]) .. "] "
                if card.ability.extra.tries == 1 then 
                    SMODS.calculate_effect({message = localize('k_nic_genius_ex'), colour = HEX('528d4d')}, card) 
                    card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 5)
                elseif card.ability.extra.tries == 2 then 
                    SMODS.calculate_effect({message = localize('k_nic_magnificent_ex'), colour = HEX('528d4d')}, card) 
                    card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 4)
                elseif card.ability.extra.tries == 3 then 
                    SMODS.calculate_effect({message = localize('k_nic_impressive_ex'), colour = HEX('528d4d')}, card) 
                    card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 3)
                elseif card.ability.extra.tries == 4 then 
                    SMODS.calculate_effect({message = localize('k_nic_splendid_ex'), colour = HEX('528d4d')}, card) 
                    card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 2)
                elseif card.ability.extra.tries == 5 then 
                    SMODS.calculate_effect({message = localize('k_nic_great_ex'), colour = HEX('528d4d')}, card) 
                    card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * 1)
                elseif card.ability.extra.tries == 6 then 
                    SMODS.calculate_effect({message = localize('k_nic_phew_ex'), colour = HEX('528d4d')}, card) 
                end
            elseif card.ability.extra.tries == 6 then
                SMODS.calculate_effect({message = localize('k_nic_failure_ex'), colour = G.C.RED}, card)
                card.ability.extra.answercolour = HEX(card.ability.extra.green)
                for i = 1, 5 do
                    if card.ability.extra.string[i] == 10 then 
                        card.ability.extra.string[i] = "X"
                    elseif card.ability.extra.string[i] == 11 then 
                        card.ability.extra.string[i] = "J"
                    elseif card.ability.extra.string[i] == 12 then 
                        card.ability.extra.string[i] = "Q"
                    elseif card.ability.extra.string[i] == 13 then 
                        card.ability.extra.string[i] = "K"
                    elseif card.ability.extra.string[i] == 14 then 
                        card.ability.extra.string[i] = "A"
                    end
                end
                card.ability.extra.answer = "[" .. (card.ability.extra.string[1]) .. "] " .. "[" .. (card.ability.extra.string[2]) .. "] " .. "[" .. (card.ability.extra.string[3]) .. "] " .. "[" .. (card.ability.extra.string[4]) .. "] " .. "[" .. (card.ability.extra.string[5]) .. "] "
            end
        elseif card.ability.extra.completed == true or card.ability.extra.tries == 6 then
            SMODS.calculate_effect({message = localize('k_nic_new_word_ex'), colour = HEX('528d4d')}, card)
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
        G.hand:unhighlight_all()
    end,

    can_use = function(self, card)
        local norank = true
        for _, playing_card in ipairs(G.hand.highlighted) do
            if SMODS.has_no_rank(playing_card) then
                norank = false
            end
		end
        return G.hand and (card.ability.extra.completed == false and #G.hand.highlighted == 5) or (card.ability.extra.completed == true or card.ability.extra.tries == 6) and norank
    end
}

SMODS.Joker{ -- Solar Eclipse
    key = "solar_eclipse",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 7,
    pos = {x = 1, y = 3},
    config = { extra = { sun = 0, moon = 0, mult = 0, chips = 0, mult_gain = 2, chips_gain = 10 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_sun
        info_queue[#info_queue + 1] = G.P_CENTERS.c_moon
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.mult_gain, card.ability.extra.chips_gain } }
    end,

    update = function(self, card)
        if self.discovered then
            if card.ability.extra.sun == card.ability.extra.moon then
                card.children.center:set_sprite_pos({x = 1, y = 3})
            end
            if card.ability.extra.sun > card.ability.extra.moon then
                card.children.center:set_sprite_pos({x = 2, y = 3})
            end
            if card.ability.extra.sun < card.ability.extra.moon then
                card.children.center:set_sprite_pos({x = 3, y = 3})
            end
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        if self.discovered then
            if card.ability.extra.sun == card.ability.extra.moon then
                full_UI_table.name = localize {
                    type = 'name',
                    key = self.key, 
                    set = self.set, 
                    nodes = {}
                }
            elseif card.ability.extra.sun > card.ability.extra.moon then
                full_UI_table.name = localize {
                    type = 'name',
                    key = self.key .. "_sun", 
                    set = self.set, 
                    nodes = {}
                }
            elseif card.ability.extra.sun < card.ability.extra.moon then
                full_UI_table.name = localize {
                    type = 'name',
                    key = self.key .. "_moon", 
                    set = self.set, 
                    nodes = {}
                }
            end
            SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        end
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.config.center.key == 'c_sun' then
                card:juice_up()
                card.ability.extra.sun = card.ability.extra.sun + 1
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult", 
                    scalar_value = "mult_gain",
                    no_message = true,
                })
            end
            if context.consumeable.config.center.key == 'c_moon' then
                card:juice_up()
                card.ability.extra.moon = card.ability.extra.moon + 1
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips", 
                    scalar_value = "chips_gain",
                    no_message = true,
                })
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
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 4,
    cost = 20,
    pos = {x = 4, y = 3},
    soul_pos = {x = 5, y = 3},
    config = { extra = { handsize = 0 , odds = 7 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return { vars = { new_numerator, new_denominator, card.ability.extra.handsize } }
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.handsize)
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards then
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
                    message = localize { type = 'variable', key = 'a_handsize', vars = { spades_cards } },
                    colour = G.C.SUITS.Spades,
                }
            end
        end

        if context.after and not context.blueprint then
            local negative_card = {}
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].edition and context.scoring_hand[i].edition.negative == true then
                    negative_card[#negative_card + 1] = context.scoring_hand[i]
                    SMODS.calculate_effect({message = localize('k_nic_hahaha_ex'), colour = G.C.SUITS.Spades}, context.scoring_hand[i])
                end
            end
            if negative_card then
                SMODS.destroy_cards(negative_card)
            end
            for _, spades_cards in ipairs(G.hand.cards) do
                if spades_cards.edition and spades_cards.edition.negative == true then
                else
                    if (spades_cards.base.suit == "Spades") then
                        if SMODS.pseudorandom_probability(card, ('j_nic_invert'), 1, card.ability.extra.odds) then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    spades_cards:set_edition('e_negative', nil, true)
                                    return true
                                end
                            }))
                            SMODS.calculate_effect({message = localize('k_nic_hahaha_ex'), colour = G.C.SUITS.Spades}, spades_cards)
                        else
                            SMODS.calculate_effect({message = localize('k_nope_ex'), colour = G.C.SUITS.Spades}, spades_cards)
                        end
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
    pos = {x = 6, y = 3},
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
    pos = {x = 7, y = 3},
    pixel_size = { h = 80 },
    config = { extra = { parry = 0, mult = 4, mult_gain = 4 } },

    loc_vars = function(self, info_queue, card)
        local card1, card2, card3, card4, card5 = "*", "*", "*", "*", "*"
        local colour1, colour2, colour3, colour4, colour5 = G.C.UI.TEXT_INACTIVE,  G.C.UI.TEXT_INACTIVE,  G.C.UI.TEXT_INACTIVE,  G.C.UI.TEXT_INACTIVE,  G.C.UI.TEXT_INACTIVE
        if card.ability.extra.parry > 0 then card1 = "[]" colour1 = G.C.SUITS.Hearts else card1 = "*" colour1 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 1 then card2 = "[]" colour2 = G.C.SUITS.Hearts else card2 = "*" colour2 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 2 then card3 = "[]" colour3 = G.C.SUITS.Hearts else card3 = "*" colour3 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 3 then card4 = "[]" colour4 = G.C.SUITS.Hearts else card4 = "*" colour4 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 4 then card5 = "[]" colour5 = G.C.SUITS.Hearts else card5 = "*" colour5 = G.C.UI.TEXT_INACTIVE end
        return { vars = { colours = { colour1, colour2, colour3, colour4, colour5 }, card1, card2, card3, card4, card5, card.ability.extra.mult, card.ability.extra.mult * 5, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint and context.other_card:is_suit("Hearts") then
            if card.ability.extra.parry < 5 then
                card.ability.extra.parry = card.ability.extra.parry + 1
                return {
                    message = localize('k_nic_parry_ex'),
                    colour = G.C.SUITS.Hearts
                }
            elseif card.ability.extra.parry == 5 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_nic_extra_parry_ex'),
                    colour = G.C.SUITS.Hearts
                }
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
                        message = localize('k_nic_super_ex_ex'),
                        colour = G.C.SUITS.Hearts,
                        mult = card.ability.extra.mult * 5
                    }
                elseif card.ability.extra.parry > 0 then
                    card.ability.extra.parry = card.ability.extra.parry - 1
                    return {
                        message = localize('k_nic_ex_ex'),
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
    pos = {x = 8, y = 3},
    pixel_size = { h = 80 },
    config = { extra = { parry = 0, chips = 31, chips_gain = 31 } },

    loc_vars = function(self, info_queue, card)
        local card1, card2, card3, card4, card5 = "*", "*", "*", "*", "*"
        local colour1, colour2, colour3, colour4, colour5 = G.C.UI.TEXT_INACTIVE,  G.C.UI.TEXT_INACTIVE,  G.C.UI.TEXT_INACTIVE,  G.C.UI.TEXT_INACTIVE,  G.C.UI.TEXT_INACTIVE
        if card.ability.extra.parry > 0 then card1 = "[]" colour1 = G.C.SUITS.Clubs else card1 = "*" colour1 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 1 then card2 = "[]" colour2 = G.C.SUITS.Clubs else card2 = "*" colour2 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 2 then card3 = "[]" colour3 = G.C.SUITS.Clubs else card3 = "*" colour3 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 3 then card4 = "[]" colour4 = G.C.SUITS.Clubs else card4 = "*" colour4 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.parry > 4 then card5 = "[]" colour5 = G.C.SUITS.Clubs else card5 = "*" colour5 = G.C.UI.TEXT_INACTIVE end
        return { vars = { colours = { colour1, colour2, colour3, colour4, colour5 }, card1, card2, card3, card4, card5, card.ability.extra.chips, card.ability.extra.chips * 5, card.ability.extra.chips_gain } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint and context.other_card:is_suit("Clubs") then
            if card.ability.extra.parry < 5 then
                card.ability.extra.parry = card.ability.extra.parry + 1
                return {
                    message = localize('k_nic_parry_ex'),
                    colour = G.C.SUITS.Clubs
                }
            elseif card.ability.extra.parry == 5 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_nic_extra_parry_ex'),
                    colour = G.C.SUITS.Clubs
                }
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
                        message = localize('k_nic_super_ex_ex'),
                        colour = G.C.SUITS.Clubs,
                        chips = card.ability.extra.chips * 5
                    }
                elseif card.ability.extra.parry > 0 then
                    card.ability.extra.parry = card.ability.extra.parry - 1
                    return {
                        message = localize('k_nic_ex_ex'),
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
    pos = {x = 9, y = 3},
    config = { extra = { odds = 100 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_specialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { vars = { } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if pseudorandom('moonchange', G.GAME.phases_numerator, G.GAME.phases_denominator) == G.GAME.phases_numerator then
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

SMODS.Joker { -- Lunation
    key = "lunation",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 0, y = 4},
    config = { extra = { xchips = 1, xchips_gain = 0.1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xchips_gain } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Phases' then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xchips", 
                scalar_value = "xchips_gain",
                no_message = true,
            })
            return {
                message = localize { type = 'variable', key = 'a_xchips', vars = { card.ability.extra.xchips } },
                colour = G.C.NIC_PHASES
            }
        end

        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}

SMODS.Joker { -- TI-108
    key = "ti108",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 1, y = 4},
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    calculate = function(self, card, context)
    end
}

SMODS.Joker { -- The Moon and Back
    key = "themoonandback",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 2, y = 4},
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    calculate = function(self, card, context)
    end
}

SMODS.Joker { -- Aurora Borealis
    key = "auroraborealis",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 3, y = 4},
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    calculate = function(self, card, context)
    end
}