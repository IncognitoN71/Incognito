SMODS.Atlas{ -- Phases
    key = "nicphases",
    path = "phases/nicphases.png",
    px = 71,
    py = 95,
}

SMODS.ConsumableType {
    key = 'Phases',
    default = 'c_nic_newmoon',
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
  atlas = "nicphases",
  pos = { x = 0, y = 2 },
  overlay_pos = { x = 1, y = 2 },
}

SMODS.ObjectType{
    key = "BasePhases",
    cards = {},
    default = 'c_nic_newmoon',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Consumable {
    discovered = false,
    key = 'newmoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 0, y = 0 },
    config = { mult = 1, chips = 1, moon = "c_nic_waxingcrescent" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingbasephases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
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
    key = 'waxingcrescent',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 1, y = 0 },
    config = { mult = 1, chips = 1.5, moon = "c_nic_firstquarter" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingbasephases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
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
    key = 'firstquarter',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 2, y = 0 },
    config = { mult = 1, chips = 2, moon = "c_nic_waxinggibbous" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingbasephases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
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
    key = 'waxinggibbous',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 3, y = 0 },
    config = { mult = 1.5, chips = 2, moon = "c_nic_fullmoon" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingbasephases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
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
    key = 'fullmoon',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 4, y = 0 },
    config = { mult = 2, chips = 2, moon = "c_nic_waninggibbous" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingbasephases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
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
    key = 'waninggibbous',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 5, y = 0 },
    config = { mult = 1.5, chips = 2, moon = "c_nic_thirdquarter" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingbasephases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
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
    key = 'thirdquarter',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 6, y = 0 },
    config = { mult = 2, chips = 1, moon = "c_nic_waningscrescent" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingbasephases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
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
    key = 'waningscrescent',
    set = 'Phases',
    cost = 4,
    atlas = 'nicphases',
    pos = {x = 7, y = 0 },
    config = { mult = 1.5, chips = 1, moon = "c_nic_newmoon" },
    pools = { ["BasePhases"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_changingbasephases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
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