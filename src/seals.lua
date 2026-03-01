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
    config = { extra = { odds = 100 } },
    badge_colour = G.C.NIC_PHASES,

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.seal.extra.odds) 
        info_queue[#info_queue + 1] = { key = "nic_specialphases", set = "Other", vars = { new_numerator, new_denominator, } }
        return { vars = { } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == 'unscored' and context.main_scoring and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, ('moonchange'), 1, card.ability.seal.extra.odds) then
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
    end
}