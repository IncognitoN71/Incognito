SMODS.Atlas{ -- Seals
    key = "nicseals",
    path = "nicseals.png",
    px = 71,
    py = 95,
}

SMODS.Seal {
    key = "teal",
    atlas = "nicseals",
    pos = { x = 0, y = 0 },
    config = { extra = { } },
    badge_colour = G.C.NIC_PHASES,
    calculate = function(self, card, context)
        if context.cardarea == 'unscored' and context.main_scoring and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({ set = 'BasePhases', area = G.consumeables })
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return {
                message = localize('k_nic_plus_phases'),
                colour = G.C.NIC_PHASES
            }
        end
    end
}