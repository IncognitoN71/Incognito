SMODS.Atlas{ -- DS
    key = "ds",
    path = "cartridge/ds.png",
    px = 95,
    py = 95,
}

SMODS.Attribute { -- DS
	key = 'ds'
}

SMODS.Attribute { -- 3DS
	key = '3ds'
}

SMODS.Joker { -- DS
    key = "ds",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ds',
    rarity = 2,
    cost = 6,
    pos = {x = 0, y = 0},
    display_size = { w = 95 },
    config = { cartridge = nil, cartridge_key = nil },
    attributes = { "ds" },

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
        local ds_amount = 0
        if G.jokers then
            for _, ds in pairs(G.jokers.cards) do
                if (ds:has_attribute('ds') or ds:has_attribute('3ds')) and ds ~= card then
                    ds_amount = ds_amount + 1
                end
            end
            if ds_amount > 0 then
                card.children.center:set_sprite_pos({x = 1, y = 0})
            else
                card.children.center:set_sprite_pos({x = 0, y = 0})
            end
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

SMODS.Joker { -- 3DS
    key = "3ds",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ds',
    rarity = 2,
    cost = 6,
    pos = {x = 2, y = 0},
    display_size = { w = 95 },
    config = { cartridge = nil, cartridge_key = nil },
    attributes = { "3ds" },

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
        local ds_amount = 0
        if G.jokers then
            for _, ds in pairs(G.jokers.cards) do
                if (ds:has_attribute('ds') or ds:has_attribute('3ds')) and ds ~= card then
                    ds_amount = ds_amount + 1
                end
            end
            if ds_amount > 0 then
                card.children.center:set_sprite_pos({x = 3, y = 0})
            else
                card.children.center:set_sprite_pos({x = 2, y = 0})
            end
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
