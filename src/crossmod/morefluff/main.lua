SMODS.Atlas{ -- MoreFluff Jokers
    key = "nicmorefluff",
    path = "crossmod/morefluff/nicmorefluff.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- MoreFluff Jokers
    key = "nicroteto",
    path = "crossmod/morefluff/nicroteto.png",
    px = 107,
    py = 107,
}

SMODS.Joker{ -- Triangle Teto
    key = "triteto",
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
	end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if context.scoring_name == "Three of a Kind" then
                if context.other_card:get_id() == 4 then
                    return {
                        message = localize('k_again_ex'),
                        colour = HEX("e15d73"),
                        repetitions = card.ability.extra.repetitions
                    }
                end
            end
        end
    end
}

SMODS.Consumable({
    object_type = "Consumable",
    set = "Colour",
    name = "col_Teto",
    key = "teto",
    pos = { x = 2, y = 0 },
    config = {
        val = 0,
        partial_rounds = 0,
        upgrade_rounds = 2,
    },
    cost = 4,
    atlas = "nicmorefluff",
    unlocked = true,
    discovered = false,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["j_nic_pear"]
        local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
        return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
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
    end
})

SMODS.Consumable({
    object_type = "Consumable",
    set = "Rotarot",
    name = "rot_Teto",
    key = "rot_teto",
    pos = { x = 0, y = 0 },
    config = {},
    cost = 3,
    atlas = "nicroteto",
    unlocked = true,
    discovered = false,
    display_size = { w = 107, h = 107 },

    can_use = function (self, card) 
        return #G.jokers.highlighted > 0 and #G.jokers.highlighted == 1  and G.jokers.highlighted[1].config.center.rarity ~= "nic_teto" and not G.jokers.highlighted[1].ability.nic_tetosticker
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
                    play_sound('tarot2', 1.1, 0.6)
                    G.jokers:unhighlight_all()
                    return true 
                end 
            }))
        end
        delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS["j_nic_pear"]
        return { vars = { } }
    end, 
})