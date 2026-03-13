SMODS.Atlas{ -- Jokers
    key = "nicenhancements",
    path = "nicenhancements.png",
    px = 71,
    py = 95,
}

SMODS.Enhancement {
    key = 'soul',
    atlas = 'nicenhancements',
    pos = { x = 0, y = 0 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { draw = 2, allow = false },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.draw } }
    end,

    calculate = function(self, card, context) -- Thank you N' for the 3 EVENTS
        if context.discard and context.other_card == card then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot2")
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve({G.C.NIC_SOUL})
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.draw_cards( card.ability.draw )
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return true
                end
            }))
            return {
                message = "+" .. card.ability.draw .. " Cards",
                colour = G.C.NIC_SOUL,
            }
        end
    end
}
