SMODS.Atlas{ -- Placeholder
    key = "nicplaceholder",
    path = "scrapped/nicplaceholder.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- Identity
    key = "identity",
    path = "scrapped/identity.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Identity
    key = "identity",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'identity',
    rarity = 4,
    cost = 20,
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = { 
        extra = {
            change1 = 1, change2 = 1, change3 = 1, change4 = 1, change5 = 1, change6 = 1, change7 = 1, change8 = 1, change9 = 1, change10 = 1, change11 = 2, change12 = 1, change13 = 1,

            base = 1, 
            gain = 1 , 
            odds = 7,

            hand = 1,
        } 
    },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return { 
            vars = {
                colours = {
                    card.ability.extra.change2 == 1 and G.C.MULT or card.ability.extra.change2 == 2 and G.C.WHITE,
                    card.ability.extra.change4 == 1 and G.C.WHITE or card.ability.extra.change4 == 2 and G.C.DARK_EDITION,
                    card.ability.extra.change6 == 1 and G.C.MULT or card.ability.extra.change6 == 2 and G.C.WHITE,
                    card.ability.extra.change6 == 1 and G.C.WHITE or card.ability.extra.change6 == 2 and G.C.FILTER,
                    card.ability.extra.change9 == 1 and G.C.UI.TEXT_DARK or card.ability.extra.change9 == 2 and G.C.DARK_EDITION,
                    card.ability.extra.change10 == 1 and G.C.UI.TEXT_DARK or card.ability.extra.change10 == 2 and G.C.DARK_EDITION,
                },
                card.ability.extra.change1 == 1 and "gains" or card.ability.extra.change1 == 2 and "increase hand size",
                card.ability.extra.change2 == 1 and "X" .. card.ability.extra.gain or card.ability.extra.change2 == 2 and "",
                card.ability.extra.change3 == 1 and " Mult " or card.ability.extra.change3 == 2 and "",
                card.ability.extra.change4 == 1 and "" or card.ability.extra.change4 == 2 and "Negative ",
                card.ability.extra.change5 == 1 and "non " or card.ability.extra.change5 == 2 and "",
                card.ability.extra.change6 == 1 and "X" .. card.ability.extra.base or card.ability.extra.change6 == 2 and "+" .. card.ability.extra.base,
                card.ability.extra.change7 == 1 and "Mult" or card.ability.extra.change7 == 2 and "Hand size",
                card.ability.extra.change8 == 1 and "non " or card.ability.extra.change8 == 2 and "",
                card.ability.extra.change9 == 1 and "destroyed" or card.ability.extra.change9 == 2 and "Negative",
                card.ability.extra.change10 == 1 and "" or card.ability.extra.change10 == 2 and "Negative ",
                card.ability.extra.change11 == 1 and "non " or card.ability.extra.change11 == 2 and "",
                card.ability.extra.change12 == 1 and "held in hand" or card.ability.extra.change12 == 2 and "played",
                card.ability.extra.change13 == 1 and "gives Mult" or card.ability.extra.change13 == 2 and "get destroyed",

                new_numerator, new_denominator
            }
        }
    end,

    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.change1 == 2 then
            G.hand:change_size(-card.ability.extra.base)
        end
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:flip()
                    return true
                end
            }))
            delay(1)
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
                delay = 0.4,
                func = function()
                    play_sound('nic_glitch', 1.1, 0.6)
                    card:juice_up()
                return true
                end
            }))
            delay(1)
            G.E_MANAGER:add_event(Event({
                func = function()
                    xmult = pseudorandom('xmult', 1, 2)

                    if xmult == 1 and card.ability.extra.hand == 2 then 
                        G.hand:change_size(-card.ability.extra.base)
                        card.ability.extra.hand = 1
                    end
                    if xmult == 2 and card.ability.extra.hand == 1 then 
                        G.hand:change_size(card.ability.extra.base)
                        card.ability.extra.hand = 2
                    end

                    card.ability.extra.change1 = xmult
                    card.ability.extra.change2 = xmult
                    card.ability.extra.change3 = xmult
                    card.ability.extra.change4 = pseudorandom('change4', 1, 2)
                    card.ability.extra.change5 = pseudorandom('change5', 1, 2)
                    card.ability.extra.change6 = xmult
                    card.ability.extra.change7 = xmult
                    card.ability.extra.change8 = pseudorandom('change8', 1, 2)
                    card.ability.extra.change9 = xmult
                    card.ability.extra.change10 = pseudorandom('change10', 1, 2)
                    card.ability.extra.change11 = pseudorandom('change11', 1, 2)
                    card.ability.extra.change12 = pseudorandom('change12', 1, 2)
                    card.ability.extra.change13 = xmult
                    return true
                end
            }))
            delay(0.2)
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:flip()
                    return true
                end
            }))
        end

        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.remove_playing_cards and not context.blueprint then -- Cards Removed
            local spades_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if (not (removed_card.base.suit == "Spades") and card.ability.extra.change5 == 1) or ((removed_card.base.suit == "Spades") and card.ability.extra.change5 == 2) then 
                    if (card.ability.extra.change4 == 1) or (removed_card.edition and removed_card.edition.negative == true and card.ability.extra.change4 == 2) then
                        spades_cards = spades_cards + 1
                    end
                end
            end

            if (spades_cards > 0 and card.ability.extra.change1 == 1) then -- XMULT
                card.ability.extra.base = card.ability.extra.base + (spades_cards * card.ability.extra.gain)
                return {
                    message = "+X" .. spades_cards .. " MULT!",
                    colour = G.C.SUITS.Spades,
                }
            end

            if (spades_cards > 0 and card.ability.extra.change1 == 2 )then -- HAND SIZE
                card.ability.extra.base = card.ability.extra.base + (spades_cards)
                G.hand:change_size(spades_cards)
                return {
                    message = "+" .. spades_cards .. " HAND SIZE!",
                    colour = G.C.SUITS.Spades,
                }
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then -- Held in Hand
            if (not (context.other_card.base.suit == "Spades") and card.ability.extra.change8 == 1) or ((context.other_card.base.suit == "Spades") and card.ability.extra.change8 == 2) then 

                if card.ability.extra.change9 == 1 then  -- Incognito
                    if SMODS.pseudorandom_probability(card, ('j_nic_incognito'), 1, card.ability.extra.odds) then
                        context.other_card.should_destroy = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('nic_swoon')
                                return true
                            end
                        }))
                        SMODS.calculate_effect({message = "SWOON!", colour = G.C.SUITS.Spades}, context.other_card)
                    else
                        SMODS.calculate_effect({message = "NOPE!", colour = G.C.SUITS.Spades}, context.other_card)
                    end
                end

                if card.ability.extra.change9 == 2 then -- Invert
                    if (context.other_card.edition and context.other_card.edition.negative == true) then
                    else
                        if SMODS.pseudorandom_probability(card, ('invert'), 1, card.ability.extra.odds) then
                            local other_card = context.other_card
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    other_card:set_edition('e_negative', nil, true)
                                    return true
                                end
                            }))
                            SMODS.calculate_effect({message = "HAHAHA!", colour = G.C.DARK_EDITION}, context.other_card)
                        else
                            SMODS.calculate_effect({message = "NOPE!", colour = G.C.DARK_EDITION}, context.other_card)
                        end
                    end
                end
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and card.ability.extra.change12 == 1 then 
            if (not (context.other_card:is_suit("Spades")) and card.ability.extra.change11 == 1) or ((context.other_card:is_suit("Spades")) and card.ability.extra.change11 == 2) then
                if card.ability.extra.change10 == 1 or ((context.other_card.edition and context.other_card.edition.negative == true) and card.ability.extra.change10 == 2) then
                    if card.ability.extra.change13 == 1 then
                        return {
                            xmult = card.ability.extra.base
                        }
                    end
                    if card.ability.extra.change13 == 2 and not context.blueprint then
                        context.other_card.should_destroy = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('nic_swoon')
                                return true
                            end
                        }))
                        return { 
                            message = "SWOON!", 
                            colour = G.C.SUITS.Spades
                        }
                    end
                end
            end
        end

        if context.individual and context.cardarea == G.play and card.ability.extra.change12 == 2 then
            if (not (context.other_card:is_suit("Spades")) and card.ability.extra.change11 == 1) or ((context.other_card:is_suit("Spades")) and card.ability.extra.change11 == 2) then
                if card.ability.extra.change10 == 1 or ((context.other_card.edition and context.other_card.edition.negative == true) and card.ability.extra.change10 == 2) then
                    if card.ability.extra.change13 == 1 then
                        return {
                            xmult = card.ability.extra.base
                        }
                    end
                    if card.ability.extra.change13 == 2 and not context.blueprint then
                        context.other_card.should_destroy = true
                        return { 
                            message = "HAHAHA!", 
                            colour = G.C.DARK_EDITION 
                        }
                    end
                end
            end
        end
    end,
}

-- SCRAP

SMODS.Rarity{
	key = "scrapped",
	badge_colour = G.C.BLACK,
	default_weight = 0,
}

SMODS.Joker{ -- Transfer Chips
    key = "overflow",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicplaceholder',
    rarity = "nic_scrapped",
    cost = 20,
    pos = {x = 0, y = 0},
    config = { extra = { leftovers = 0, chips = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.leftovers, card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.chips = (to_number(G.GAME.chips) - to_number(G.GAME.blind.chips))/2
            card.ability.extra.leftovers = to_number(G.GAME.chips) - to_number(G.GAME.blind.chips)
            return {
                message = "Yum"
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.after then
            card.ability.extra.chips = 0
        end
    end
}

SMODS.Joker{ -- Reroll Infinite
    key = "reroll",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicplaceholder',
    rarity = "nic_scrapped",
    cost = 20,
    pos = {x = 0, y = 0},
    
    add_to_deck = function(self, card, from_debuff)
        G.GAME.shop.joker_max = G.GAME.shop.joker_max + 1
        if G.shop then
            G.shop:recalculate()
            G.shop_jokers.T.w = 3.2*G.CARD_W
        end
        SMODS.change_free_rerolls(2)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.shop.joker_max = G.GAME.shop.joker_max - 1
        SMODS.change_free_rerolls(-2)
    end,

    calculate = function(self, card, context)
        if context.reroll_shop then
            G.GAME.current_round.free_rerolls = 2
        end
    end
}


SMODS.Joker{ -- The True Fibonacci Sequence
    key = "thetruefibonaccisequence",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicplaceholder',
    rarity = "nic_scrapped",
    cost = 20,
    pos = {x = 0, y = 0},
    config = { extra = { xchips = 1, counter = 1, counter_gain = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then 
            card.ability.extra.counter = card.ability.extra.counter + card.ability.extra.counter_gain
        end

        if context.joker_main then
            card.ability.extra.xchips = ((1/math.sqrt(5)) * (((1 + math.sqrt(5)) / 2)^(card.ability.extra.counter))) + ((-1/math.sqrt(5)) * (((1 - math.sqrt(5)) / 2)^(card.ability.extra.counter)))
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}

--[[   calculate = function(self, card, context) -- Hands are Pairs
        if G.jokers.cards[#G.jokers.cards] == card then
            if context.evaluate_poker_hand then
                return {
                    replace_scoring_name = "Pair"
                }
            end
        end
    end]]

--[[    card.ability.extra.mult = G.GAME.hands["Pair"].played * 10 -- Amount of Played and Level
            card.ability.extra.chips = to_number(G.GAME.hands["Pair"].level) * 50
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end]]
