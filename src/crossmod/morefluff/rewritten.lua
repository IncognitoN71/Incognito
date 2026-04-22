SMODS.Atlas{ -- MoreFluff Jokers
    key = "nicmorefluff",
    path = "crossmod/morefluff/nicmorefluff.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Triangle Teto
    key = "tritetorewritten",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicmorefluff',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 1, y = 0},
    soul_pos = {
        x = 0,
        y = 0,
        draw = function(card, scale_mod, rotate_mod)
            scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) *
                    math.pi * 14) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            rotate_mod = 0.3 * math.sin(10 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL) * math.pi * 5) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2
                
            card.children.floating_sprite:draw_shader('dissolve',
                0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1)
            card.children.floating_sprite:draw_shader('dissolve',
                nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    },
    config = { extra = { repetitions = 1 } },
    pools = { ["Teto"] = true },
    dependencies = { 'MoreFluff' },

    loc_vars = function(self, info_queue, center) 
		info_queue[#info_queue+1] = G.P_CENTERS["j_mf_triangle"]
        info_queue[#info_queue+1] = G.P_CENTERS["c_nic_tetorewritten"]
        info_queue[#info_queue+1] = G.P_CENTERS["c_nic_rot_tetorewritten"]
	end,

    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Three of a Kind" then
            if next(SMODS.find_card("j_mf_triangle")) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({ key = 'c_nic_tetorewritten' })
                        SMODS.add_card({ key = 'c_nic_rot_tetorewritten' })
                        return true
                    end
                }))
            else
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({ key = 'c_nic_tetorewritten' })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({ key = 'c_nic_rot_tetorewritten' })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
            end
        end
    end
}

FLUFF.Colour {
    key = "tetorewritten",
    name = "col_Teto",
    atlas = 'nicmorefluff',
    pos = { x = 2, y = 0 },
    config = {
        val = 0,
        partial_rounds = 0,
        upgrade_rounds = 4
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["j_nic_pear"]
        local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
        return { vars = {
            card.ability.val,
            val,
            max,
            card.ability.upgrade_rounds
        } }
    end,

    can_use = function(self, card)
        return card.ability.val > 0
    end,

    colour_effect = function(self, card, area)
        for i = 1, card.ability.val do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'j_nic_pear', 'sup')
            n_card:add_to_deck()
            n_card:set_edition({negative = true}, true)
            G.jokers:emplace(n_card)
            card:juice_up(0.3, 0.5)
            return true end }))
        end
        delay(0.6)
    end,
}

SMODS.Consumable({
    set = "Rotarot",
    name = "rot_Teto",
    key = "rot_tetorewritten",
    pos = { x = 3, y = 0 },
    config = {},
    cost = 3,
    atlas = "nicmorefluff",
    unlocked = true,
    discovered = false,
    mf_rotate_by = math.pi / 4,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_tetosticker", set = "Other" }
        info_queue[#info_queue+1] = G.P_CENTERS["j_nic_pear"]
        return { vars = { } }
    end, 

    use = function(self, card, area, copier)
        if (G.jokers.highlighted[1].config.center.pools or {}).Food then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    G.jokers.highlighted[1]:juice_up()
                    G.jokers.highlighted[1]:set_ability(G.P_CENTERS.j_nic_pear)
                    play_sound('gold_seal', 1.2, 0.4)
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
        elseif G.jokers.highlighted[1].config.center.key == 'j_hpfx_ijiraq' then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    G.jokers.highlighted[1]:juice_up()
                    G.jokers.highlighted[1]:set_ability(G.P_CENTERS.j_nic_tetoraq)
                    play_sound('gold_seal', 1.2, 0.4)
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function() 
                    G.jokers.highlighted[1]:juice_up()
                    G.jokers.highlighted[1]:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Teto, 'teto').key)
                    play_sound('gold_seal', 1.2, 0.4)
                    G.jokers:unhighlight_all()
                    return true 
                end 
            }))
        end
        delay(0.6)
    end,

    can_use = function (self, card) 
        return #G.jokers.highlighted > 0 and #G.jokers.highlighted == 1  and G.jokers.highlighted[1].config.center.rarity ~= "nic_teto" and not G.jokers.highlighted[1].ability.nic_tetosticker
    end,
})

SMODS.Consumable({
    set = "Rotarot",
    name = "rot_Selene",
    key = "rot_selenerewritten",
    pos = { x = 4, y = 0 },
    config = { extra = { phases = 2 } },
    cost = 3,
    atlas = "nicmorefluff",
    unlocked = true,
    discovered = false,
    mf_rotate_by = math.pi / 4,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_specialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        info_queue[#info_queue+1] = G.P_CENTERS["c_nic_fullmoon"]
        return { vars = { card.ability.extra.phases } }
    end,

    use = function(self, card, area, copier)
        for i = 1, math.min(card.ability.extra.phases, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        if pseudorandom('moonchange', G.GAME.phases_numerator, G.GAME.phases_denominator) == G.GAME.phases_numerator then
                            play_sound('nic_glitch')
                            SMODS.add_card({ key = (pseudorandom_element(G.P_CENTER_POOLS.SpecialPhases, 'specialphases', {in_pool = function() return true end}).key), area = G.consumeables })
                        else
                            play_sound('timpani')
                            SMODS.add_card({ key = 'c_nic_fullmoon', area = G.consumeables })
                        end
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end,

    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or (card.area == G.consumeables)
    end
})