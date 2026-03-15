SMODS.Atlas{ -- Entropy Jokers
    key = "nicentropy",
    path = "crossmod/nicentropy.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Ruby Teto
    key = "rubteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicentropy',
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
    config = { extra = { handname = "Pair"} },
    pools = { ["Teto"] = true },
    dependencies = { 'entr' },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "asc_power_tutorial", set = "Other" }
        local tetoamount = 0
        if card.area and card.area == G.jokers then
            for _, c in pairs(G.jokers.cards) do
                if c:is_rarity('nic_teto') or c.ability.nic_tetosticker then
                    tetoamount = tetoamount + 1
                end
            end
        end
        return { vars = { tetoamount } }
    end,

    calculate = function(self, card, context)
        local tetoamount = 0
        for _, c in pairs(G.jokers.cards) do
            if c:is_rarity('nic_teto') or c.ability.nic_tetosticker then
                tetoamount = tetoamount + 1
            end
        end
        if context.setting_blind or (context.end_of_round and context.game_over == false and context.main_eval) then
            SMODS.upgrade_poker_hands({hands = "Pair", ascension_power = tetoamount * (1 + (G.GAME.entr_black_dwarf or 0))})
        end
    end
}