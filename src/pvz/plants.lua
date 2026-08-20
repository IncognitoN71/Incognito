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
    pos = {x = 0, y = 6},
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
    end,

    keep_on_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local random = pseudorandom('j_nic_crazydave', 1, 12)
                play_sound("nic_crazydave" .. random)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                if G.zengarden.states.visible == false then
                    G.zengarden.states.visible = true
                else
                    G.zengarden.states.visible = false
                end
                return true
            end
        }))
        delay(0.3)
    end,

    can_use = function(self, card)
        return true
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
    pos = {x = 0, y = 0},
    config = { extra = { chips = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
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
    pos = {x = 1, y = 0},
    config = { extra = { dollars = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                dollars = card.ability.extra.dollars,
            }
        end
    end,
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
    pos = {x = 2, y = 0},
    config = { extra = { max_highlighted = 3 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('nic_cherrybomb')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.3)
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
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
    pos = {x = 3, y = 0},
    config = { extra = { hand = 1, discard = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand, card.ability.extra.discard } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
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
    pos = {x = 5, y = 0},
    config = { extra = { max_highlighted = 3, countdown = 3, countdown_needed = 3 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.countdown, card.ability.extra.countdown_needed } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,

    add_to_deck = function(self, card, from_debuff)        
        card.children.center:set_sprite_pos({x = 4, y = 0})
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint then
                if card.ability.extra.countdown > 0 then
                    if card.ability.extra.countdown - 1 <= 0 then
                        card.children.center:set_sprite_pos({x = 5, y = 0})
                        play_sound('nic_potatominerise')
                    end
                    local eval = function(card) return card.ability.extra.countdown == 0 and not card.REMOVED end
                    juice_card_until(card, eval, true)
                    card.ability.extra.countdown = card.ability.extra.countdown - 1
                end
            end
        end
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('nic_potatomineexplode')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.3)
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted and card.ability.extra.countdown <= 1
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
    pos = {x = 6, y = 0},
    config = { extra = { chips = 50, hand = 1, countdown = 5, countdown_needed = 5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.hand, card.ability.extra.countdown, card.ability.extra.countdown_needed } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint then
                if card.ability.extra.countdown <= 1 then
                    card.ability.extra.countdown = card.ability.extra.countdown_needed
                    ease_hands_played(card.ability.extra.hand)
                else
                    local eval = function(card) return card.ability.extra.countdown == 1 and not card.REMOVED end
                    juice_card_until(card, eval, true)
                    card.ability.extra.countdown = card.ability.extra.countdown - 1
                end
            end
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
    pos = {x = 7, y = 0},
    config = { extra = { max_highlighted = 1, countdown = 0, countdown_needed = 3, mult = 0, mult_gain = 10 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.countdown, card.ability.extra.countdown_needed, card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return card.ability.extra.countdown == 0 and not card.REMOVED end
        juice_card_until(card, eval, true)
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint then
                if card.ability.extra.countdown > 0 then
                    if card.ability.extra.countdown - 1 <= 0 then
                        card.children.center:set_sprite_pos({x = 7, y = 0})
                    end
                    local eval = function(card) return card.ability.extra.countdown == 0 and not card.REMOVED end
                    juice_card_until(card, eval, true)
                    card.ability.extra.countdown = card.ability.extra.countdown - 1
                end
            end
            return {
                mult = card.ability.extra.mult,
            }
        end
    end,

    keep_on_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('nic_chomper')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
	    card.ability.extra.countdown = card.ability.extra.countdown_needed
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                card.children.center:set_sprite_pos({x = 8, y = 0})
                SMODS.destroy_cards(G.hand.highlighted)
                G.jokers:unhighlight_all()
                return true
            end
        }))
        delay(0.3)
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted and card.ability.extra.countdown <= 1
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
    pos = {x = 9, y = 0},
    config = { extra = { chips = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    
    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
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
    pos = {x = 0, y = 1},
    config = { extra = { chips = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
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
    pos = {x = 3, y = 1},
    config = { extra = { countdown = 10, countdown_needed = 10, dollars = 0.5, sprite = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.countdown, card.ability.extra.countdown_needed, card.ability.extra.dollars } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,

    add_to_deck = function(self, card, from_debuff)        
        card.children.center:set_sprite_pos({x = 1, y = 1})
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint then
                if card.ability.extra.countdown <= 1 then
                    card.ability.extra.countdown = card.ability.extra.countdown_needed
                    card.ability.extra.dollars = card.ability.extra.dollars * 2
                    if card.ability.extra.sprite == 0 then
                        card.children.center:set_sprite_pos({x = 2, y = 1})
                        play_sound('nic_sunshroom')
                        card.ability.extra.sprite = card.ability.extra.sprite + 1
                    elseif card.ability.extra.sprite > 0 then
                        card.children.center:set_sprite_pos({x = 3, y = 1})
                        play_sound('nic_sunshroom')
                    end
                else
                    local eval = function(card) return card.ability.extra.countdown == 1 and not card.REMOVED end
                    juice_card_until(card, eval, true)
                    card.ability.extra.countdown = card.ability.extra.countdown - 1
                end
            end
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
    pos = {x = 4, y = 1},
    config = { extra = { chips = 50, blind = 5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.blind } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
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
    pos = {x = 5, y = 1},
    config = { extra = { max_highlighted = 3, amount = 3 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.amount } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('nic_gravebuster')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(G.hand.highlighted)
                local cards = {}
                for i = 1, card.ability.extra.amount * #G.hand.highlighted do
                    local cen_pool = {}
                    for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if enhancement_center.key ~= 'm_stone' and not enhancement_center.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = enhancement_center
                        end
                    end
                    local enhancement = pseudorandom_element(cen_pool, 'nic_gravebuster')
                    cards[i] = SMODS.add_card { set = "Base", enhancement = enhancement.key }
                end
                SMODS.calculate_context({ playing_card_added = true, cards = cards })
                return true
            end
        }))
    end,

    can_use = function(self, card)
        local stone = false
        for i = 1, #G.hand.highlighted do
			for _, playing_card in ipairs(G.hand.highlighted) do
				if SMODS.has_enhancement(playing_card, 'm_stone') then
					stone = true
				end
			end
		end
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted and stone
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
    pos = {x = 6, y = 1},
    config = { extra = { max_highlighted = 3, amount = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.amount } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,

    add_to_deck = function(self, card, from_debuff)    
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('nic_hypnoshroom')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                for i = 1, card.ability.extra.amount do
                    for i = 1, #G.hand.highlighted do 
                        local cen_pool = {}
                        for _, enhancement_center in pairs(G.P_CENTER_POOLS.Enhanced) do
                            if enhancement_center.key ~= 'm_stone' and not enhancement_center.overrides_base_rank then
                                cen_pool[#cen_pool + 1] = enhancement_center
                            end
                        end
                        local enhancement = pseudorandom_element(cen_pool, 'nic_hypnoshroom')

                        local cards = copy_card(G.hand.highlighted[i], nil, nil, G.playing_card)

                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        cards.playing_card = G.playing_card
                        table.insert(G.playing_cards, cards)
                                
                        cards:start_materialize()
                        cards:set_ability(enhancement, true)
                        G.hand:emplace(cards)
                        G.hand:sort()
                    end
                end
                SMODS.calculate_context({ playing_card_added = true, cards = cards })
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
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
    pos = {x = 7, y = 1},
    config = { extra = { chips = 50, rounds = 1, hand = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.hand, card.ability.extra.discard } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
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
                card.children.center:set_sprite_pos({x = 7, y = 1})
                card.ability.extra.rounds = 1
            end
            
            if G.GAME.current_round.hands_left == 0 and card.ability.extra.rounds == 1 then
                card.children.center:set_sprite_pos({x = 8, y = 1})
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
    pos = {x = 9, y = 1},
    config = { extra = { max_highlighted = 5, hand = 1, enhancement = "m_glass" } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.hand, localize { type = 'name_text', set = 'Enhanced', key = card.ability.extra.enhancement } } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('nic_iceshroom')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
			    ease_hands_played(card.ability.extra.hand)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do 
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand.highlighted[i]:juice_up()
                    G.hand.highlighted[i]:set_ability(card.ability.extra.enhancement)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
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
    pos = {x = 0, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
    
    add_to_deck = function(self, card, from_debuff)    
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('nic_doomshroom')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.GAME.chips = G.GAME.blind.chips
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.STATE = G.STATES.HAND_PLAYED
                G.STATE_COMPLETE = true
                end_round()
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.destroy_cards(G.hand.cards)
                return true
            end
        }))
    end,

    can_use = function(self, card)
        return G.STATE == G.STATES.SELECTING_HAND
    end
}

SMODS.Joker{ -- Lily Pad
    key = "lilypad",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 1, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
}

SMODS.Joker{ -- Squash
    key = "squash",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 2, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
}

SMODS.Joker{ -- Threepeater
    key = "threepeater",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 3, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
}

SMODS.Joker{ -- Tangle Kelp
    key = "tanglekelp",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 4, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
}

SMODS.Joker{ -- Jalapeno
    key = "jalapeno",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 5, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
}

SMODS.Joker{ -- Spikeweed
    key = "spikeweed",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 6, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
}


SMODS.Joker{ -- Torchwood
    key = "torchwood",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 7, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
}

SMODS.Joker{ -- Tall-Nut
    key = "tallnut",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 8, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
}

SMODS.Joker{ -- Sea-Shroom
    key = "seashroom",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 9, y = 2},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = true
        }
    end,
}