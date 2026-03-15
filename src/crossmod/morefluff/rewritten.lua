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
	end,

    calculate = function(self, card, context)
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
        upgrade_rounds = 2
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