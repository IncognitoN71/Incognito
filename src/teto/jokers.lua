SMODS.Atlas{ -- Teto Jokers
    key = "nictetojokers",
    path = "teto/nictetojokers.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Kasane Jokto
    key = "kasane_jokto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 0, y = 0},
    config = { extra = { repetitions = 2 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "NeatoJokers"
        info_queue[#info_queue + 1] = { key = "nic_inspired_by_en", set = "Other", vars = { name } }
        return { vars = { card.ability.extra.repetitions } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if context.other_card:get_id() == 4 then
                return {
                    message = localize('k_again_ex'),
                    colour = G.C.NIC_TETO,
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}

SMODS.Joker{ -- Ambassador Teto
    key = "ambassador_teto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 1, y = 0},
    config = { extra = { xmult = 1.5 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "アンバサダー"
        local artist = "dada"
        info_queue[#info_queue + 1] = { key = "nic_song_by_jp", set = "Other", vars = { name, artist } }
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            for _, playing_card in ipairs(G.hand.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        playing_card:juice_up()
                        play_sound('tarot2', 1.1, 0.6)
                        if playing_card:is_suit("Clubs") then
                            playing_card:change_suit('Diamonds')
                        elseif playing_card:is_suit("Diamonds") then
                            playing_card:change_suit('Spades')
                        elseif playing_card:is_suit("Spades") then
                            playing_card:change_suit('Hearts')    
                        elseif playing_card:is_suit("Hearts") then
                            playing_card:change_suit('Clubs')
                        end
                        return true
                    end
                }))
            end
            return {
                message = localize('k_nic_blood_ex'),
                colour = G.C.NIC_TETO,
            }
        end
    end
}

SMODS.Joker{ -- Pear
    key = "pear",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 2, y = 0},
    config = { extra = { levels = 1, pear = 5, pear_needed = 5, pear_loss = 1 } },
    pools = { Food = true, ["Teto"] = true, ["Pear"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.pear, card.ability.extra.pear_needed } }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint and context.scoring_name == "Pair" then
            if card.ability.extra.pear - card.ability.extra.pear_loss <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                G.GAME.pool_flags.nic_pear = true
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.NIC_TETO
                }
            else
                card.ability.extra.pear = card.ability.extra.pear - card.ability.extra.pear_loss
            end
        end

        if context.before and context.scoring_name == "Pair" then
            return {
                level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                message = localize('k_nic_teto_pear_ex'),
                colour = G.C.NIC_TETO
            }
        end
    end
}

SMODS.Joker{ -- Pearto
    key = "pearto",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 7,
    pos = {x = 3, y = 0},
    config = { extra = { levels = 3, odds = 1000 } },
    pools = { Food = true, ["Teto"] = true, ["Pear"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return { vars = { new_numerator, new_denominator, card.ability.extra.levels } }
    end,

    in_pool = function(self, args)
        return G.GAME.pool_flags.nic_pear
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, ('j_nic_pearto'), 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.NIC_TETO
                }
            else
                return {
                    message = localize('k_safe_ex'),
                    colour = G.C.NIC_TETO
                }
            end
        end

        if context.before and context.scoring_name == "Pair" then
            return {
                level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                message = localize('k_nic_teto_pear_ex'),
                colour = G.C.NIC_TETO
            }
        end
    end
}

SMODS.Joker{ -- Doctor Kidori
    key = "doctor_kidori",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 8,
    pos = {x = 4, y = 0},
    config = { extra = { } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "イガク"
        local artist = "原口沙輔"
        info_queue[#info_queue + 1] = { key = "nic_song_by_jp", set = "Other", vars = { name, artist } }
        return { vars = { } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 4 and not context.blueprint then
            if G.jokers.cards[1] == card then
                local other_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up()
                        other_card:juice_up()
                        play_sound('tarot1')
                        other_card:set_edition(SMODS.poll_edition { guaranteed = true }, nil, true)
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Joker{ -- Birdbrain Teto
    key = "birdbrain_teto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 5, y = 0},
    config = { extra = { mult = 0, mult_gain = 5 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "BIRDBRAIN"
        local artist = "Jamie Paige"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Pair" then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult", 
                    scalar_value = "mult_gain",
                })
            else
                card.ability.extra.mult = 0
                return {
                    message = localize('k_nic_my_penis_ex'),
                    colour = G.C.NIC_TETO
                }
            end
        end
        if context.joker_main and card.ability.extra.mult ~= 0 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Tenebre Rosso Sangue Teto
    key = "tenebre_rosso_sangue_teto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 7,
    pos = {x = 6, y = 0},
    config = { extra = { dollars = 4 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "Tenebre Rosso Sangue [Cover]"
        local artist = "Sandwich"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { vars = { card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards then
            local heart_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_suit("Hearts") then
                    heart_cards = heart_cards + 1
                end
            end
            if heart_cards > 0 then
                return {
                    message = "BLOOD RED RAIN!",
                    colour = G.C.NIC_TETO,
                    dollars = card.ability.extra.dollars * heart_cards
                }
            end
        end
    end
}

SMODS.Joker{ -- Spoken For Teto
    key = "spoken_for_teto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 8,
    pos = {x = 7, y = 0},
    config = { extra = { xmult = 1.5 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "Spoken For"
        local artist = "FLAVOR FOLEY"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { vars = { card.ability.extra.xmult } }
    end, 

    calculate = function(self, card, context)
        if (context.other_joker and (context.other_joker.config.center.rarity == "nic_teto" or context.other_joker.ability.nic_tetosticker)) then
            return {
                xmult = card.ability.extra.xmult,
                colour = G.C.NIC_TETO
            }
        end
    end,

}

SMODS.Joker{ -- Teto Word Of The Day
    key = "teto_word_of_the_day",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 8,
    pos = {x = 8, y = 0},
    config = { extra = { teto = 0, teto_rounds = 2 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.teto, card.ability.extra.teto_rounds } }
    end, 

    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint and not context.retrigger_joker and (card.ability.extra.teto == card.ability.extra.teto_rounds) then
            if #G.jokers.cards <= G.jokers.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({ set = 'Joker', rarity = 'nic_teto' })
                        return true
                    end
                }))
                return { 
                    message = localize('k_nic_teto_ex'),
                    colour = G.C.NIC_TETO 
                }
            else
                return { 
                    message = localize('k_no_room_ex'),
                    colour = G.C.NIC_TETO 
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.teto ~= card.ability.extra.teto_rounds then
                card.ability.extra.teto = card.ability.extra.teto + 1
                if card.ability.extra.teto == card.ability.extra.teto_rounds then
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                    play_sound("nic_tetowordoftheday")
                end
                return {
                    message = (card.ability.extra.teto < card.ability.extra.teto_rounds) and (card.ability.extra.teto .. '/' .. card.ability.extra.teto_rounds) or localize('k_nic_teto_word_of_the_day_ex'),
                    colour = G.C.NIC_TETO 
                }
            else
                return {
                    message = localize('k_nic_active_ex'),
                    colour = G.C.NIC_TETO 
                }
            end
        end
    end
}

SMODS.Joker{ -- Mesmerizer Teto
    key = "mesmerizer_teto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 8,
    pos = {x = 9, y = 0},
    config = { extra = { } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "メズマライザー"
        local artist = "32ki"
        info_queue[#info_queue + 1] = { key = "nic_song_by_jp", set = "Other", vars = { name, artist } }
        if card.area and card.area == G.jokers then
            local compatible = G.jokers.cards[1] and G.jokers.cards[1] ~= card and
                (G.jokers.cards[1].config.center.rarity == "nic_teto" or G.jokers.cards[1].ability.nic_tetosticker) and G.jokers.cards[1].config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize { type = 'variable', key = (compatible and 'nic_mesmerizeractive' or 'nic_mesmerizerinactive') } .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { 
                vars = { },
                main_end = main_end 
            }
        end
    end,

    calculate = function(self, card, context)
        if G.jokers.cards[1] and G.jokers.cards[1] ~= card and
        (G.jokers.cards[1].config.center.rarity == "nic_teto" or G.jokers.cards[1].ability.nic_tetosticker) and G.jokers.cards[1].config.center.blueprint_compat then
            local ret1 = SMODS.blueprint_effect(card, G.jokers.cards[1], context)
            local ret2 = SMODS.blueprint_effect(card, G.jokers.cards[1], context)
            local ret3 = SMODS.merge_effects(
                { ret1 or {} },
                { ret2 or {} }
            )
            if ret3 then
                ret3.colour = G.C.NIC_TETO
            end
            return ret3
        end
    end
}

SMODS.Joker{ -- Spamteto 
    key = "spamteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 0, y = 1},
    config = { extra = { dollars = 30, dollars_final = 0, uses = 0 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "Koasha Spamteto"
        info_queue[#info_queue + 1] = { key = "nic_inspired_by_en", set = "Other", vars = { name } }
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_final } }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars_final
    end,

    update = function(self, card)
        card.ability.extra.dollars_final = math.floor(G.GAME.dollars * (card.ability.extra.dollars/100))
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.uses = 1
        end

        if context.key_press_f1 then
            if card.ability.extra.uses == 1 then 
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("nic_spamtonf1")
                        ease_discard(pseudorandom("discard", 0, 1))
                        ease_hands_played(1)
                        card.ability.extra.uses = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_nic_big_shot'),
                    colour = G.C.NIC_TETO
                }
            end
        end

        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.uses = 0
            return {
                message = ('[$' .. card.ability.extra.dollars_final .. ']'),
                colour = G.C.MONEY
            }
        end
    end
}

SMODS.Joker{ -- Tetoris 
    key = "tetoris",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 1, y = 1},
    config = { extra = { hearts = 5, hearts_needed = 5, hearts_loss = 1 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "テトリス"
        local artist = "柊マグネタイト"
        info_queue[#info_queue + 1] = { key = "nic_song_by_jp", set = "Other", vars = { name, artist } }
        return { vars = { card.ability.extra.hearts, card.ability.extra.hearts_needed } }
    end, 

    calculate = function(self, card, context)
        if context.joker_main then
            local heart_cards = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Hearts") then
                    heart_cards = true
                end
            end

            if heart_cards then
                if card.ability.extra.hearts <= 1 then
                    if not context.blueprint then
                        card.ability.extra.hearts = card.ability.extra.hearts_needed
                    end
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card({ set = 'Tarot', key = "c_sun" })
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                        return { 
                            message = localize('k_nic_tetoris_ex'),
                            colour = G.C.NIC_TETO 
                        }
                    else
                        return {
                            message = localize('k_no_room_ex'),
                            colour = G.C.NIC_TETO 
                        }
                    end
                else
                    if not context.blueprint then
                        card.ability.extra.hearts = card.ability.extra.hearts - card.ability.extra.hearts_loss
                        return { 
                            message = localize('k_nic_teto_ex'),
                            colour = G.C.NIC_TETO 
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker{ -- Minimum Rage Teto 
    key = "minimum_rage_teto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 2, y = 1},
    config = { extra = { mult = 0 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "MINIMUM RAGE"
        local artist = "MonochroMenace"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { vars = { card.ability.extra.mult } }
    end, 

    calculate = function(self, card, context)
        if (context.buying_card or context.buying_booster) and not context.blueprint and context.card.cost > 0 then
            card.ability.extra.mult = card.ability.extra.mult + context.card.cost
            return { 
                message = localize { type = 'variable', key = 'a_mult', vars = { context.card.cost } }, 
                colour = G.C.NIC_TETO
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Teto Territory
    key = "teto_territory",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 3, y = 1},
    config = { extra = { } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "oxi"
        local artist = "重音territory"
        info_queue[#info_queue + 1] = { key = "nic_song_by_jp", set = "Other", vars = { name, artist } }
        if card.area and card.area == G.jokers then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            local compatible = my_pos and G.jokers.cards[my_pos + 1] and G.jokers.cards[my_pos + 1].config.center.rarity ~= "nic_teto" and not G.jokers.cards[my_pos + 1].ability.nic_tetosticker
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize { type = 'variable', key = (compatible and 'nic_territoryactive' or 'nic_territoryinactive') } .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { 
                vars = { },
                main_end = main_end 
            }
        end
        return { vars = {  } }
    end, 

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].getting_sliced 
            and G.jokers.cards[my_pos + 1].config.center.rarity ~= "nic_teto" and not G.jokers.cards[my_pos + 1].ability.nic_tetosticker then
                local joker_to_teto = G.jokers.cards[my_pos + 1]
                if ((joker_to_teto.config.center.pools or {}).Food) or joker_to_teto:has_attribute('food') then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            joker_to_teto:juice_up(0.5, 0.5)
                            play_sound('tarot2', 1.1, 0.6)
                            joker_to_teto:set_ability(G.P_CENTERS.j_nic_pear)
                            return true
                        end
                    }))
                else
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            joker_to_teto:juice_up(0.5, 0.5)
                            play_sound('tarot2', 1.1, 0.6)
                            joker_to_teto:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Teto, 'teto').key)
                            return true
                        end
                    }))
                end
                return { 
                    message = localize('k_nic_territory_ex'),
                    colour = G.C.NIC_TETO 
                }
            end
        end
    end
}

SMODS.Joker{ -- Contradictions Teto
    key = "contradictions_teto",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 4, y = 1},
    config = { extra = { } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "CONTRADICTIONS"
        local artist = "Darkbluecat"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { vars = { } }
    end, 

    calculate = function(self, card, context)
        if context.setting_blind then
            for i = 1, #G.playing_cards do
                local other_card = G.playing_cards[i]
                if (other_card:is_suit("Hearts") or other_card.base.suit == "Hearts") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local rank = pseudorandom_element(SMODS.Ranks, 'ranks').key
                            assert(SMODS.change_base(other_card, nil, rank))
                            return true
                        end
                    }))
                end
            end
            return {
                message = localize('k_nic_contradictions_ex'),
                colour = G.C.NIC_TETO
            }
        end
    end
}

SMODS.ObjectType{
    key = "Pear",
    cards = {},
    default = 'j_nic_pear',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Joker{ -- Pear Basket
    key = "pear_basket",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 7,
    pos = {x = 5, y = 1},
    config = { extra = { levels = 0, levels_gain = 1 } },
    pools = { Food = true, ["Teto"] = true, ["Pear"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.levels_gain }, }
    end,

    in_pool = function(self, args)
        return G.GAME.pool_flags.nic_pear
    end,

    calculate = function(self, card, context)
        if context.selling_card and not context.blueprint and (context.card.config.center.pools or {}).Pear then
            card.ability.extra.levels = card.ability.extra.levels + card.ability.extra.levels_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.NIC_TETO,
            }
        end

        if context.before and context.scoring_name == "Pair" then
            if card.ability.extra.levels > 0 then
                return {
                    level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                    message = localize('k_nic_teto_pear_ex'),
                    colour = G.C.NIC_TETO,
                }
            end
        end
    end
}

SMODS.Joker{ -- Keychain Teto
    key = "keychain_teto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 6, y = 1},
    config = { extra = {} },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_nic_twindrill', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_nic_twindrill' } } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    card:juice_up()
                    add_tag(Tag('tag_nic_twindrill'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1.5,
                func = (function()
                    card:start_dissolve()
                    return true
                end)
            }))
            return {
                message = localize('k_nic_yay_ex'),
                colour = G.C.NIC_TETO,
            }
        end
    end
}

SMODS.Joker{ -- Log Off Teto
    key = "log_off_teto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 7, y = 1},
    pixel_size = { h = 71 },
    config = { extra = { xmult = 3, xmult_loss = 0.01 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "LOG OFF"
        local artist = "Staircatte"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_loss }, }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint and not context.other_card:is_suit("Hearts") then
            if card.ability.extra.xmult - card.ability.extra.xmult_loss < 1 then
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult", 
                    scalar_value = "xmult_loss",
                    no_message = true,
                    operation = "-",
                })
                return {
                    message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.xmult_loss } },
                    colour = G.C.NIC_TETO,
                }
            end
        end

        if context.after and not context.blueprint then
            if card.ability.extra.xmult - card.ability.extra.xmult_loss <= 1 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_nic_logging_off_ex'),
                    colour = G.C.NIC_TETO
                }
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{ -- TetOS 4.1
    key = "tetoos",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 8, y = 1},
    pixel_size = { h = 71 },
    config = { extra = { levels = 1 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local name = "Machine Love"
        local artist = "Jamie Paige"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { vars = { }, }
    end,

    calculate = function(self, card, context)
        if context.pseudorandom_result and context.identifier == "wheel_of_fortune" and not context.result then
            return {
                level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                message = localize('k_level_up_ex'),
                colour = G.C.NIC_TETO
            }
        end
    end
}

SMODS.Joker{ -- Cadmium Colors
    key = "cadmium_colors",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 9, y = 1},
    config = { extra = { xmult = 3, suit1 = "Hearts", suit2 = "Diamonds" } },
    pools = { ["Teto"] = true },
    
    loc_vars = function(self, info_queue, card)
        local name = "Cadmium Colors"
        local artist = "Jamie Paige"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { 
            vars = { 
                card.ability.extra.xmult, card.ability.extra.suit1, card.ability.extra.suit2, 
                colours = { G.C.SUITS[card.ability.extra.suit1], G.C.SUITS[card.ability.extra.suit2] } 
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local suit1 = false
            local suit2 = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit(card.ability.extra.suit1) then
                    suit1 = true
                end
            end
            for i = 1, #G.hand.cards do
                if G.hand.cards[i]:is_suit(card.ability.extra.suit2) then
                    suit2 = true
                end
            end
            if suit1 and suit2 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local suit1 = card.ability.extra.suit1
            local suit2 = card.ability.extra.suit2
            card.ability.extra.suit1 = suit2
            card.ability.extra.suit2 = suit1
            card:juice_up()
            return {
                message = localize('k_swapped_ex'),
                colour = G.C.NIC_TETO
            }
        end
    end
}

SMODS.Joker{ -- HITO Mania
    key = "hito_mania",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 0, y = 2},
    pixel_size = { w = 59 },
    config = { extra = { } },
    pools = { ["Teto"] = true },
    
    loc_vars = function(self, info_queue, card)
        local name = "人マニア"
        local artist = "原口沙輔"
        info_queue[#info_queue + 1] = { key = "nic_song_by_jp", set = "Other", vars = { name, artist } }
        return { vars = { } }
    end,

    calculate = function(self, card, context)
    end
}

SMODS.Joker{ -- Rot For Clout
    key = "rot_for_clout",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 1, y = 2},
    config = { extra = { } },
    pools = { ["Teto"] = true },
    
    loc_vars = function(self, info_queue, card)
        local name = "Rot For Clout"
        local artist = "Jamie Paige"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { vars = { } }
    end,

    calculate = function(self, card, context)
    end
}

SMODS.Joker{ -- Bread
    key = "bread",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 2, y = 2},
    config = { extra = { } },
    pools = { ["Teto"] = true },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    calculate = function(self, card, context)
    end
}

SMODS.Joker{ -- Machine Love
    key = "machine_love",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 3, y = 2},
    soul_pos = {x = 4, y = 2},
    config = { extra = { } },
    pools = { ["Teto"] = true },
    
    loc_vars = function(self, info_queue, card)
        local name = "Machine Love"
        local artist = "Jamie Paige"
        info_queue[#info_queue + 1] = { key = "nic_song_by_en", set = "Other", vars = { name, artist } }
        return { vars = { } }
    end,

    calculate = function(self, card, context)
    end
}