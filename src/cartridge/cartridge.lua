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
        local ds = false
        if card:has_attribute('ds') then
            if #G.jokers.highlighted == 1 and (G.jokers.highlighted[1]:has_attribute('ds') or G.jokers.highlighted[1]:has_attribute('3ds')) then
                ds = true
            end
        elseif card:has_attribute('3ds') then
            if #G.jokers.highlighted == 1 and G.jokers.highlighted[1]:has_attribute('3ds') then
                ds = true
            end
        end
        return ds
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
    attributes = { "ds" },

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
    pos = {x = 1, y = 0 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { } },
    attributes = { "ds" },

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
    attributes = { "ds" },

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
    attributes = { "ds" },

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
    attributes = { "ds" },

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
    attributes = { "ds" },

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
    attributes = { "ds" },

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
    config = { extra = { mult = 3 } },
    attributes = { "3ds" },

    loc_vars = function(self, info_queue, card)
        local face_tally = 0
        if G.playing_cards then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i]:is_face() and G.hand.cards[i].facing == 'back' then
                    face_tally = face_tally + 1 
                end
            end 
        end
        return { vars = { card.ability.extra.mult, card.ability.extra.mult * face_tally } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
        if context.stay_flipped and context.to_area == G.hand and
            context.other_card:is_face(true) then
            return {
                stay_flipped = true
            }
        end
        if context.joker_main then
            local face_tally = 0
            for i = 1, #G.hand.cards do
                if G.hand.cards[i]:is_face() and G.hand.cards[i].facing == 'back' then
                    face_tally = face_tally + 1 
                end
            end 
            return {
                mult = cartridge.mult * face_tally
            }
        end
    end,
})

Incognito.Cartridge({
    key = 'pokemon_hook',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 8, y = 0 },
    config = { extra = { discard = false } },
    attributes = { "3ds" },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
        if context.press_play or context.setting_blind then 
            cartridge.discard = true
        end

        if context.drawing_cards and cartridge.discard == true then
            if #G.discard.cards > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _cards = {}
                        for _, playing_card in ipairs(G.discard) do
                            _cards[#_cards + 1] = playing_card
                        end
                        for i = 1, 2 do
                            card:juice_up()
                            local discard_card = pseudorandom_element(_cards, 'c_pokemon_hook')
                            draw_card(G.discard, G.hand, 90, 'up', true, discard_card)
                        end
                        play_sound('tarot2')
                        return true
                    end
                }))
            end
            cartridge.discard = false
        end
    end
})

Incognito.Cartridge({
    key = 'pokemon_star',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 9, y = 0 },
    config = { extra = { } },
    attributes = { "3ds" },

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
    attributes = { "3ds" },

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
    attributes = { "3ds" },

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
    attributes = { "3ds" },

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
    attributes = { "ds" },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'the_joker_midas_mask',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 5, y = 1 },
    config = { extra = { } },
    attributes = { "3ds" },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'canio_and_yorick',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 0, y = 2 },
    config = { extra = { } },
    attributes = { "3ds" },

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
    attributes = { "3ds" },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})

Incognito.Cartridge({
    key = 'rhythm_steven',
    set = 'Cartridge',
    atlas = 'cartridge',
    overlay_atlas = 'nic_cartridge_overlay',
    pos = {x = 4, y = 2 },
    pixel_size = { h = 67, w = 63 },
    config = { extra = { mult = 6, mult_base = 6, mult_gain = 2 } },
    attributes = { "ds" },

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
    attributes = { "3ds" },

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
    attributes = { "3ds" },

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
    attributes = { "3ds" },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    cartridge_calculate = function(self, card, context, cartridge)
    end,
})