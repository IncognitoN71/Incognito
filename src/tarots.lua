SMODS.Atlas{ -- Tarots
    key = "nictarots",
    path = "nictarots.png",
    px = 71,
    py = 95,
}

SMODS.Consumable {
    key = 'tetotarot',
    set = 'Tarot',
    unlocked = true,
    discovered = false,
    cost = 4,
    atlas = 'nictarots',
    pos = {x = 0, y = 0 },

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
                    G.jokers.highlighted[1]:add_sticker("nic_tetosticker", true)
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
}

SMODS.Consumable {
    key = 'selene',
    set = 'Tarot',
    cost = 4,
    atlas = 'nictarots',
    pos = {x = 1, y = 0 },
    config = { extra = { phases = 2 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_specialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
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
                            SMODS.add_card({ set = 'BasePhases', area = G.consumeables })
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
}
