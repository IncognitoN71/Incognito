SMODS.Atlas{ -- Plant Jokers
    key = "nicpvzjokers",
    path = "pvz/nicpvzjokers.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Crazy Dave
    key = "crazydave",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 0, y = 7},
    soul_pos = {x = 0, y = 6},
    config = { extra = { mult = 12 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_nic_vase1', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_nic_vase1' } } }
    end,

    add_to_deck = function (self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.zengarden = #SMODS.find_card("j_nic_crazydave")
                return true
            end
        }))
    end,

    remove_from_deck = function (self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.zengarden = #SMODS.find_card("j_nic_crazydave")
                G.zengarden.states.visible = false
                if G.GAME.zengarden < 1 then
                    for i = 1, #G.zengarden.cards do 
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.destroy_cards(G.zengarden.cards[i])
                                return true
                            end
                        }))
                    end
                end
                return true
            end
        }))
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint_compat and G.GAME.blind.boss then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    card:juice_up()
                    add_tag(Tag('tag_nic_vase'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
        end

        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'ZenGarden' then
            card:juice_up(0.5, 0.5)
            G.E_MANAGER:add_event(Event({
                func = function()
                    local random = pseudorandom('j_nic_crazydave', 1, 12)
                    play_sound("nic_crazydave" .. random)
                    return true
                end
            }))
        end
        if context.joker_main and next(context.poker_hands["Straight"]) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local random = pseudorandom('j_nic_crazydave', 1, 12)
                    play_sound("nic_crazydave" .. random)
                    return true
                end
            }))
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Peashooter
    key = "peashooter",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 4,
    pos = {x = 0, y = 7},
    soul_pos = {x = 0, y = 0},
    config = { extra = { chips = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_peashooter"))
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
            }
        end
    end
}

SMODS.Joker{ -- Sunflower
    key = "sunflower",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 2,
    pos = {x = 0, y = 7},
    soul_pos = {x = 1, y = 0},
    config = { extra = { dollars = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_sunflower"))
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                dollars = card.ability.extra.dollars,
            }
        end
    end
}

SMODS.Joker{ -- Cherry Bomb
    key = "cherrybomb",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 6,
    pos = {x = 0, y = 7},
    soul_pos = {x = 2, y = 0},
    config = { extra = { max_highlighted = 3 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted } }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end
}

SMODS.Joker{ -- Wall-nut
    key = "wallnut",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 2,
    pos = {x = 0, y = 7},
    soul_pos = {x = 3, y = 0},
    config = { extra = { hand = 1, discard = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand, card.ability.extra.discard } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_wallnut"))
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            if pseudorandom('wallnut', 1, 2) == 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_hands_played(card.ability.extra.hand)
                        return true
                    end
                }))
                return {
                    message = "+1 Hand",
                    colour = G.C.BLUE
                }
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_discard(card.ability.extra.discard)
                        return true
                    end
                }))
                return {
                    message = "+1 Discard",
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker{ -- Potato Mine
    key = "potatomine",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 1,
    pos = {x = 0, y = 7},
    soul_pos = {x = 4, y = 0},
    config = { extra = { max_highlighted = 3, countdown = 0, countdown_needed = 3 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.countdown, card.ability.extra.countdown_needed } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_potatomine"))
        }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.countdown ~= card.ability.extra.countdown_needed then
                card.ability.extra.countdown = card.ability.extra.countdown + 1
                if card.ability.extra.countdown == card.ability.extra.countdown_needed then
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                end
            end
            return {
                message = (card.ability.extra.countdown < card.ability.extra.countdown_needed) and (card.ability.extra.countdown .. '/' .. card.ability.extra.countdown_needed) or "ACTIVE",
            }
        end
    end
}

SMODS.Joker{ -- Snow Pea
    key = "snowpea",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 7,
    pos = {x = 0, y = 7},
    soul_pos = {x = 5, y = 0},
    config = { extra = { chips = 50, hand = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.hand } }
    end,

    add_to_deck = function(self, card, from_debuff)        
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand
        ease_hands_played(card.ability.extra.hand)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hand
        ease_hands_played(-card.ability.extra.hand)
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_snowpea"))
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
            }
        end
    end
}

SMODS.Joker{ -- Chomper
    key = "chomper",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 6,
    pos = {x = 0, y = 7},
    soul_pos = {x = 6, y = 0},
    config = { extra = { max_highlighted = 1, countdown = 3, countdown_needed = 3, mult = 0, mult_gain = 10 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.countdown, card.ability.extra.countdown_needed, card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return card.ability.extra.countdown == card.ability.extra.countdown_needed and not card.REMOVED end
        juice_card_until(card, eval, true)
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_chomper"))
        }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.countdown ~= card.ability.extra.countdown_needed then
                card.ability.extra.countdown = card.ability.extra.countdown + 1
                if card.ability.extra.countdown == card.ability.extra.countdown_needed then
                    local eval = function(card) return card.ability.extra.countdown == card.ability.extra.countdown_needed and not card.REMOVED end
                    juice_card_until(card, eval, true)
                end
            end
            return {
                message = (card.ability.extra.countdown < card.ability.extra.countdown_needed) and (card.ability.extra.countdown .. '/' .. card.ability.extra.countdown_needed) or "ACTIVE",
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
            }
        end
    end
}

SMODS.Joker{ -- Repeater
    key = "repeater",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 8,
    pos = {x = 0, y = 7},
    soul_pos = {x = 7, y = 0},
    config = { extra = { chips = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    
    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_repeater"))
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                extra = {
                    chips = card.ability.extra.chips,
                }
            }
        end
    end
}

SMODS.Joker{ -- Puff-shroom
    key = "puffshroom",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 0,
    pos = {x = 0, y = 7},
    soul_pos = {x = 8, y = 0},
    config = { extra = { chips = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_puffshroom"))
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    chips = card.ability.extra.chips,
                }
            end
        end
    end
}

SMODS.Joker{ -- Sun-shroom
    key = "sunshroom",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 1,
    pos = {x = 0, y = 7},
    soul_pos = {x = 9, y = 0},
    config = { extra = { countdown = 0, countdown_needed = 10, dollars = 0.5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.countdown, card.ability.extra.countdown_needed, card.ability.extra.dollars } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_sunshroom"))
        }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.countdown ~= card.ability.extra.countdown_needed then
                card.ability.extra.countdown = card.ability.extra.countdown + 1
                if card.ability.extra.countdown == card.ability.extra.countdown_needed then
                    card.ability.extra.countdown = 0
                    card.ability.extra.dollars = card.ability.extra.dollars * 2
                end
                return {
                    message = card.ability.extra.countdown == 0 and "INCREASE CASH" or (card.ability.extra.countdown < card.ability.extra.countdown_needed) and (card.ability.extra.countdown .. '/' .. card.ability.extra.countdown_needed),
                }
            end
        end
        if context.joker_main then
            return {
                dollars = card.ability.extra.dollars,
            }
        end
    end
}

SMODS.Joker{ -- Fume-shroom
    key = "fumeshroom",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 3,
    pos = {x = 0, y = 7},
    soul_pos = {x = 0, y = 1},
    config = { extra = { chips = 50, blind = 5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.blind } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_fumeshroom"))
        }
    end,

    calculate = function(self, card, context)
        if context.before then 
            if G.GAME.current_round.hands_played == 0 then
                return {
                    message = "PIERCE", 
                    colour = G.C.FILTER
                }
            end
        end
        if context.joker_main then
            if G.GAME.current_round.hands_played == 0 then
                G.GAME.blind.chips = math.floor(to_number(G.GAME.blind.chips) * (1 - (card.ability.extra.blind / 100)))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            else
                return {
                    chips = card.ability.extra.chips,
                }
            end
        end
    end
}

SMODS.Joker{ -- Grave Buster
    key = "gravebuster",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 3,
    pos = {x = 0, y = 7},
    soul_pos = {x = 1, y = 1},
    config = { extra = { max_highlighted = 3, amount = 3 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.amount } }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end
}

SMODS.Joker{ -- Hypno-shroom
    key = "hypnoshroom",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 3,
    pos = {x = 0, y = 7},
    soul_pos = {x = 2, y = 1},
    config = { extra = { max_highlighted = 3, amount = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.amount } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_hypnoshroom"))
        }
    end,

    add_to_deck = function(self, card, from_debuff)    
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end
}

SMODS.Joker{ -- Scaredy-shroom
    key = "scaredyshroom",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 1,
    pos = {x = 0, y = 7},
    soul_pos = {x = 3, y = 1},
    config = { extra = { chips = 50, rounds = 1, hand = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.hand, card.ability.extra.discard } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_scaredyshroom"))
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.current_round.hands_left ~= 0 then
                return {
                    chips = card.ability.extra.chips,
                }
            end
        end

        if context.main_eval and not context.blueprint then
            if context.end_of_round and context.game_over == false then
                card.ability.extra.rounds = 1
            end
            
            if G.GAME.current_round.hands_left == 0 and card.ability.extra.rounds == 1 then
                card.ability.extra.rounds = 0
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_hands_played(card.ability.extra.hand)
                        return true
                    end
                }))
                SMODS.calculate_effect({message = "+1 Hand", colour = G.C.BLUE}, card)
            end
        end
    end
}

SMODS.Joker{ -- Ice-shroom
    key = "iceshroom",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 3,
    pos = {x = 0, y = 7},
    soul_pos = {x = 4, y = 1},
    config = { extra = { max_highlighted = 5, hand = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.hand } }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end
}

SMODS.Joker{ -- Doom-shroom
    key = "doomshroom",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 0, y = 7},
    soul_pos = {x = 5, y = 1},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    
    add_to_deck = function(self, card, from_debuff)    
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end
}