SMODS.Atlas{ -- Bad Director Jokers
    key = "nicbaddirector",
    path = "crossmod/nicbaddirector.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Niko Teto
    key = "tetoxko",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicbaddirector',
    rarity = "nic_teto",
    cost = 5,
    pos = { x = 1, y = 0 },
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
                0, nil, nil, card.children.center, scale_mod, rotate_mod , nil, 0.1)
            card.children.floating_sprite:draw_shader('dissolve',
                nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    },
    config = { extra = { } },
    pools = { ["Teto"] = true },
    dependencies = { 'baddirector' },

    loc_vars = function(self, info_queue, card)
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

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local pool = {}
            for i = 1, #G.hand.cards do
                if not G.hand.cards[i].edition then
                    pool[#pool + 1] = G.hand.cards[i]
                end
            end

            for i = 1, tetoamount do
                local target = pseudorandom_element(pool, 'bruh')
                if target then
                    target:set_edition('e_bd_misprinted', nil, true)
                    target:juice_up(0.3, 0.4)
                end
            end
            play_sound('bd_inapmit')
            card:juice_up(0.3, 0.5)
            check_for_unlock({ type = 'have_edition' })
            delay(1)
        end
    end,
}