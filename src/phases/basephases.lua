SMODS.Atlas{ -- Phases
    key = "phases",
    path = "phases/phases.png",
    px = 71,
    py = 95,
}

SMODS.ConsumableType {
    key = 'Phases',
    default = 'c_nic_new_moon',
    primary_colour = G.C.NIC_PHASES,
    secondary_colour = G.C.NIC_PHASES,
    collection_rows = { 4, 4 },
    shop_rate = 2,
    loc_txt = {
        name = "Phases",
        collection = "Phases",
        undiscovered = {
            name = "Not Discovered",
            text = { 
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does",
            },
        }
    },
}

SMODS.UndiscoveredSprite {
  key = "Phases",
  atlas = "phases",
  pos = { x = 0, y = 2 },
  overlay_pos = { x = 1, y = 2 },
}

SMODS.ObjectType{
    key = "BasePhases",
    cards = {},
    default = 'c_nic_new_moon',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Consumable {
    discovered = false,
    key = 'new_moon',
    set = 'Phases',
    cost = 4,
    atlas = 'phases',
    pos = {x = 0, y = 0 },
    config = { mult = 1, chips = 1, moon = "c_nic_waxing_crescent" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changing_base_phases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.retrigger_joker then
            Incognito.normalshift(card)
        end
    end,

    use = function(self, card, area, copier)
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'waxing_crescent',
    set = 'Phases',
    cost = 4,
    atlas = 'phases',
    pos = {x = 1, y = 0 },
    config = { mult = 1, chips = 1.5, moon = "c_nic_first_quarter" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changing_base_phases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.retrigger_joker then
            Incognito.normalshift(card)
        end
    end,

    use = function(self, card, area, copier)
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'first_quarter',
    set = 'Phases',
    cost = 4,
    atlas = 'phases',
    pos = {x = 2, y = 0 },
    config = { mult = 1, chips = 2, moon = "c_nic_waxing_gibbous" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changing_base_phases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.retrigger_joker then
            Incognito.normalshift(card)
        end
    end,

    use = function(self, card, area, copier)
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'waxing_gibbous',
    set = 'Phases',
    cost = 4,
    atlas = 'phases',
    pos = {x = 3, y = 0 },
    config = { mult = 1.5, chips = 2, moon = "c_nic_full_moon" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changing_base_phases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.retrigger_joker then
            Incognito.normalshift(card)
        end
    end,

    use = function(self, card, area, copier)
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'full_moon',
    set = 'Phases',
    cost = 4,
    atlas = 'phases',
    pos = {x = 4, y = 0 },
    config = { mult = 2, chips = 2, moon = "c_nic_waning_gibbous" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changing_base_phases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.retrigger_joker then
            Incognito.normalshift(card)
        end
    end,

    use = function(self, card, area, copier)
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'waning_gibbous',
    set = 'Phases',
    cost = 4,
    atlas = 'phases',
    pos = {x = 5, y = 0 },
    config = { mult = 1.5, chips = 2, moon = "c_nic_third_quarter" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changing_base_phases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.retrigger_joker then
            Incognito.normalshift(card)
        end
    end,

    use = function(self, card, area, copier)
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'third_quarter',
    set = 'Phases',
    cost = 4,
    atlas = 'phases',
    pos = {x = 6, y = 0 },
    config = { mult = 2, chips = 1, moon = "c_nic_wanings_crescent" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changing_base_phases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.retrigger_joker then
            Incognito.normalshift(card)
        end
    end,

    use = function(self, card, area, copier)
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}

SMODS.Consumable {
    discovered = false,
    key = 'wanings_crescent',
    set = 'Phases',
    cost = 4,
    atlas = 'phases',
    pos = {x = 7, y = 0 },
    config = { mult = 1.5, chips = 1, moon = "c_nic_new_moon" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changing_base_phases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return { 
            vars = { 
                G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none'),
                card.ability.mult, card.ability.chips,
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_mult) or "0",
                (G.GAME.last_hand_played and G.GAME.hands[G.GAME.last_hand_played].l_chips) or "0",

                colours = { 
                    ((not G.GAME.last_hand_played and G.C.UI.TEXT_INACTIVE) or G.C.FILTER)
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.retrigger_joker then
            Incognito.normalshift(card)
        end
    end,

    use = function(self, card, area, copier)
        Incognito.phaseslevelup(card)
    end,

    can_use = function(self, card)
        return G.GAME.last_hand_played
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
}