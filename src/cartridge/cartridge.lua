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
            local cartridge = card.ability.cartridge_key
            if cartridge and (G.P_CENTERS[cartridge] or {}).loc_vars then
                local vars = G.P_CENTERS[cartridge]:loc_vars(info_queue, {ability = { extra = card.ability.cartridge } }).vars
                info_queue[#info_queue + 1] = { key = cartridge, set = "Cartridge", vars = vars }
            end
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = cartridge and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. (cartridge and localize { type = 'name_text', key = cartridge, set = 'Cartridge' } or localize { type = 'variable', key = 'nic_insert' }) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
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
        local cartridge = card.ability.cartridge_key
        if cartridge and (G.P_CENTERS[cartridge] or {}).cartridge_calculate then
            return G.P_CENTERS[cartridge]:cartridge_calculate(card, context, card.ability.cartridge)
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
                local new_cartridge = SMODS.add_card({ set = 'Cartridge', key = card.ability.cartridge_key })
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
        G.E_MANAGER:add_event(Event({
            func = function()
                ds:juice_up()
                play_sound("nic_click")
                if ds.ability.cartridge_key then
                    local new_cartridge = SMODS.add_card({ set = 'Cartridge', key = ds.ability.cartridge_key })
                    new_cartridge.ability.extra = ds.ability.cartridge
                end
                ds.ability.cartridge = card.ability.extra
                ds.ability.cartridge_key = card.config.center.key
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
    default = 'c_nic_pokemon_heart_gold',
    primary_colour = G.C.NIC_CARTRIDGE,
    secondary_colour = G.C.NIC_CARTRIDGE,
    collection_rows = { 5, 5 },
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
    key = 'pokemon_heart_gold',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 0, y = 0 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.cartridge or 0 } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_spade_steel',
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
    key = 'pokemon_tarot',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 2, y = 0 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_planet',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 3, y = 0 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_spectral',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 4, y = 0 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_sock',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 5, y = 0 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_buskin',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 6, y = 0 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_mark',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 7, y = 0 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_hook',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 8, y = 0 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_star',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 9, y = 0 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_moon',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 0, y = 1 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_onyx_agate',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 1, y = 1 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'pokemon_rough_gem',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 2, y = 1 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'the_joker_delayed_hourglass',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 3, y = 1 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

--[[Incognito.Cartridge({ -- "The Legend of Zelda: Spirit Tracks"
    key = 'idk',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 4, y = 1 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})]]

Incognito.Cartridge({
    key = 'the_joker_midas_mask',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 5, y = 1 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

--[[Incognito.Cartridge({ -- "The Legend of Zelda: Ocarina of Time"
    key = 'idk',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 6, y = 1 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})]]

--[[Incognito.Cartridge({ -- "The Legend of Zelda: A Link Between World"
    key = 'idk',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 7, y = 1 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})]]

--[[Incognito.Cartridge({ -- "Super Mario Bros"
    key = 'idk',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 8, y = 1 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})]]

--[[Incognito.Cartridge({ -- "Mario Kart"
    key = 'idk',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 9, y = 1 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})]]

Incognito.Cartridge({
    key = 'canio_and_yorick',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 0, y = 2 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'paper_canio_sticker_stake',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 1, y = 2 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

--[[Incognito.Cartridge({ -- "Super Mario 3D Land"
    key = 'idk',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 2, y = 2 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})]]

--[[Incognito.Cartridge({ -- "Luigi's Mansion"
    key = 'idk',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 3, y = 2 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})]]

Incognito.Cartridge({
    key = 'rhythm_steven',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 4, y = 2 },
    config = { extra = { mult = 6, mult_base = 6, mult_gain = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
        if context.individual and context.cardarea == G.play then
            local id = context.other_card:get_id()
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == context.other_card then
                    if context.scoring_hand[i - 1] and (context.scoring_hand[i - 1]:get_id() % 2 == 0) and not (context.scoring_hand[i - 1]:get_id() == 14) and not (context.scoring_hand[i - 1]:get_id() == 12) then
                        if (context.scoring_hand[i]:get_id() % 2 == 0) and not (context.scoring_hand[i]:get_id() == 14) and not (context.scoring_hand[i]:get_id() == 12) then
                            SMODS.scale_card(card, {
                                ref_table = cartridge,
                                ref_value = "mult", 
                                scalar_value = "mult_gain",
                                no_message = true,
                            })
                        else
                            local last_chip = cartridge.mult
                            cartridge.mult = cartridge.mult_base
                            if last_chip > cartridge.mult_base then
                                return {
                                    message = localize('k_reset'),
                                }
                            end
                        end
                    end
                end
            end
            if id <= 10 and id >= 0 and id % 2 == 0 then
                return {
                    mult = cartridge.mult
                }
            end
        end
        if context.after then
            local last_chip = cartridge.mult
            cartridge.mult = cartridge.mult_base
            if last_chip > cartridge.mult_base then
                return {
                    message = localize('k_reset'),
                }
            end
        end
    end,
})

Incognito.Cartridge({
    key = 'weetopia',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 5, y = 2 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'balatro',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 6, y = 2 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'cut_the_nope',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 7, y = 2 },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})