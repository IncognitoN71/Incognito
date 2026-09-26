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
    config = { extra = { cartridge = nil } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.cartridge]
        if card.area and card.area == G.jokers then
            local compatible = card.ability.extra.cartridge
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. (compatible and localize { type = 'name_text', key = card.ability.extra.cartridge, set = 'Cartridge' } or localize { type = 'variable', key = 'nic_insert' }) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
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
            local cartridge = {}
            if card.ability.extra.cartridge and (G.P_CENTERS[card.ability.extra.cartridge] or {}).cartridge_calculate then
                local ret = G.P_CENTERS[card.ability.extra.cartridge]:cartridge_calculate(card, context)
                if ret and next(ret) then
                    cartridge[#cartridge + 1] = ret
                end
            end
            return SMODS.merge_effects(cartridge)
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
                SMODS.add_card({ set = 'Cartridge', key = card.ability.extra.cartridge })
                card.ability.extra.cartridge = nil
                G.jokers:unhighlight_all()
                return true
            end
        }))
    end,

    can_use = function(self, card)
        return card.ability.extra.cartridge
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
        if not ds.ability.extra.cartridge then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ds.ability.extra.cartridge = card.config.center.key
                    return true
                end
            }))
        elseif ds.ability.extra.cartridge ~= card.config.center.key then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({ set = 'Cartridge', key = ds.ability.extra.cartridge })
                    ds.ability.extra.cartridge = card.config.center.key
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
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context)
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

    cartridge_calculate = function(self, card, context)
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