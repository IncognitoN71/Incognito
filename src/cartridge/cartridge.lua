SMODS.Atlas{ -- Cartridge
    key = "cartridge",
    path = "cartridge/cartridge.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- Cartridge Overlay
    key = "cartridge_overlay",
    path = "cartridge/cartridge_overlay.png",
    px = 95,
    py = 95,
}

SMODS.Atlas{ -- 3DS
    key = "3ds",
    path = "cartridge/3ds.png",
    px = 95,
    py = 95,
}

SMODS.Joker { -- 3DS
    key = "3ds",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = '3ds',
    rarity = 2,
    cost = 6,
    pos = {x = 0, y = 0},
    display_size = { w = 95 },
    config = { cartridge = nil, cartridge_key = nil },

    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local compatible = card.ability.cartridge_key
            if compatible then
                info_queue[#info_queue + 1] = G.P_CENTERS[compatible.config.center.key]
            end
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. (compatible and localize { type = 'name_text', key = compatible.config.center.key, set = 'Cartridge' } or localize { type = 'variable', key = 'nic_insert' }) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { 
                main_end = main_end 
            }
        end
    end, 

    update = function(self, card)
        if #SMODS.find_card("j_nic_3ds") > 1 then
            card.children.center:set_sprite_pos({x = 1, y = 0})
        else
            card.children.center:set_sprite_pos({x = 0, y = 0})
        end
    end,

    calculate = function(self, card, context)
		if not context.blueprint then
            local cartridge = card.ability.cartridge_key
            if cartridge and (G.P_CENTERS[cartridge.config.center.key] or {}).cartridge_calculate then
                return G.P_CENTERS[cartridge.config.center.key]:cartridge_calculate(card, context, card.ability.cartridge)
            end
        end
	end,

    keep_on_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up()
                play_sound("nic_click")
                local new_cartridge = SMODS.copy_card(card.ability.cartridge_key)
                new_cartridge.ability.extra = card.ability.cartridge
                card.ability.cartridge = nil
                card.ability.cartridge_key = nil
                G.jokers:unhighlight_all()
                return true
            end
        }))
    end,

    can_use = function(self, card)
        return card.ability.cartridge
    end
}

Incognito.Cartridge = SMODS.Consumable:extend({
	object_type = "Consumable",
	set = "Cartridge",
    overlay_atlas = 'cartridge_overlay',
	cost = 10,
	unlocked = true,
	discovered = false,
	pixel_size = { h = 67 },

    use = function(self, card, area, copier)
        local ds = G.jokers.highlighted[1]
        if not ds.ability.cartridge_key then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ds.ability.cartridge = card.ability.extra
                    ds.ability.cartridge_key = card
                    return true
                end
            }))
        elseif ds.ability.cartridge_key ~= card then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local new_cartridge = SMODS.copy_card(ds.ability.cartridge_key)
                    new_cartridge.ability.extra = ds.ability.cartridge
                    ds.ability.cartridge = card.ability.extra
                    ds.ability.cartridge_key = card
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                ds:juice_up()
                play_sound("nic_click")
                G.jokers:unhighlight_all()
                return true
            end
        }))
    end,

    can_use = function(self, card)
        return #G.jokers.highlighted == 1 and G.jokers.highlighted[1].config.center.key == "j_nic_3ds"
    end,
})

SMODS.ConsumableType {
    key = 'Cartridge',
    default = 'c_nic_empty',
    primary_colour = G.C.NIC_CARTRIDGE,
    secondary_colour = G.C.NIC_CARTRIDGE,
    collection_rows = { 6, 6 },
    shop_rate = 0,
    loc_txt = {
        name = " Cartridge ",
        collection = "Cartridge",
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

Incognito.Cartridge({
    key = 'default',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 0, y = 0 },
    config = { extra = { mult = 4 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
        if context.joker_main then
            return {
                mult = cartridge.mult
            }
        end
        if context.before then 
            cartridge.mult = cartridge.mult * 2
        end
    end,
})

Incognito.Cartridge({
    key = 'pokemon_heart_gold',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 1, y = 0 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_spade_steel',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 2, y = 0 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_star',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 3, y = 0 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_moon',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 4, y = 0 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context)
    end,
})

Incognito.Cartridge({
    key = 'rhythm_steven',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 5, y = 0 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context)
    end,
})

Incognito.Cartridge({
    key = 'the_joker_midas_mask',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 6, y = 0 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context)
    end,
})

Incognito.Cartridge({
    key = 'weetopia',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 7, y = 0 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context)
    end,
})

Incognito.Cartridge({
    key = 'balatro',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 8, y = 0 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context)
    end,
})