SMODS.Atlas{ -- STS Jokers
    key = "nicstsjokers",
    path = "sts/nicstsjokers.png",
    px = 71,
    py = 95,
}

SMODS.Joker { -- Unleash
    key = "unleash",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicstsjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 0, y = 0},
    config = { extra = { mult = 6, total = 6 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_ostyhp", set = "Other", vars = { G.GAME.osty_hp, G.GAME.osty_maxhp } }
        return { vars = { (card.ability.extra.mult + G.GAME.osty_hp) * G.GAME.lethality } }
    end,

    update = function(self, card)
        card.ability.extra.total = (card.ability.extra.mult + G.GAME.osty_hp) * G.GAME.lethality
    end,

    calculate = function(self, card, context)
        if context.joker_main then 
            return {
                mult = card.ability.extra.total
            }
        end
    end,
}

SMODS.Joker { -- Dirge
    key = "dirge",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicstsjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 1, y = 0},
    config = { extra = { summon = 3, total = 0 } }, 
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_nic_soul
        info_queue[#info_queue + 1] = { key = "nic_ostyhp", set = "Other", vars = { G.GAME.osty_hp, G.GAME.osty_maxhp } }
        return { vars = { card.ability.extra.summon, G.GAME.current_round.hands_left * card.ability.extra.summon } }
    end,

    update = function(self, card)
        card.ability.extra.total = G.GAME.current_round.hands_left * card.ability.extra.summon
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            G.GAME.osty_hp = G.GAME.osty_hp + (G.GAME.current_round.hands_left * card.ability.extra.summon)
            G.GAME.osty_maxhp = G.GAME.osty_maxhp + (G.GAME.current_round.hands_left * card.ability.extra.summon)

            for i = 1, G.GAME.current_round.hands_left do 
                G.E_MANAGER:add_event(Event({
                    func = function()                    
                        local soul_card = SMODS.create_card { set = "Base", enhancement = "m_nic_soul", area = G.discard }
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        soul_card.playing_card = G.playing_card
                        table.insert(G.playing_cards, soul_card)
                        
                        soul_card:start_materialize()
                        G.play:emplace(soul_card)
                        draw_card(G.play, G.deck, 1, 'up', true, soul_card, nil, mute)
                        return true
                    end
                }))
            end

            return {
                message = "+" .. (G.GAME.current_round.hands_left * card.ability.extra.summon) .. " Summon",
                colour = G.C.NIC_NECROBINDER
            }
        end
    end
}

SMODS.Joker { -- Call of the Void
    key = "callofthevoid",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicstsjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 2, y = 0},
    config = { extra = { discard = false} },

    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint_compat then
            card.ability.extra.discard = false
        end

        if context.press_play or context.setting_blind and not context.blueprint_compat then 
            card.ability.extra.discard = true
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint_compat then
            card.ability.extra.discard = false
        end

        if context.drawing_cards and card.ability.extra.discard == true then
            G.E_MANAGER:add_event(Event({
                func = function()                    
                    local void = SMODS.create_card { set = "Base", area = G.discard }
                        
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    void.playing_card = G.playing_card
                    table.insert(G.playing_cards, void)
                        
                    void:start_materialize()
                    void:set_ability(SMODS.poll_enhancement({ guaranteed = true }), true)
                    G.hand:emplace(void)
                    G.hand:sort()
                    return true
                end
            }))
            return {
                message = "+1 Card",
                colour = G.C.NIC_NECROBINDER
            }
        end
    end
}

SMODS.Joker { -- The Scythe
    key = "thescythe",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicstsjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 3, y = 0},
    config = { extra = { mult = 13, mult_gain = 3, total = 13 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { (card.ability.extra.mult * G.GAME.lethality), card.ability.extra.mult_gain } }
    end,

    update = function(self, card)
        card.ability.extra.total = card.ability.extra.mult * G.GAME.lethality
    end,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then 
            return {
                mult = card.ability.extra.mult * G.GAME.lethality
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint_compat then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = "+" .. card.ability.extra.mult .. " Mult",
                colour = G.C.NIC_NECROBINDER
            }
        end
    end,
}

SMODS.Joker { -- Lethality
    key = "lethality",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicstsjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 4, y = 0},
    config = { extra = { increase = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increase } }
    end,

    remove_from_deck = function(self, card, from_debuff)
        local increase = ( 1 + (card.ability.extra.increase/100) )
        if G.GAME.current_round.hands_played == 0 then
            G.GAME.lethality = G.GAME.lethality / increase
        end
    end,

    calculate = function(self, card, context)
        local increase = ( 1 + (card.ability.extra.increase/100) )
        if context.setting_blind and not context.blueprint_compat then 
            G.GAME.lethality = G.GAME.lethality * increase
            return {
                message = "Increase by X" .. increase,
                colour = G.C.NIC_NECROBINDER
            }
        end

        if context.after and G.GAME.current_round.hands_played == 0 then 
            G.GAME.lethality = G.GAME.lethality / increase
        end
    end,
}