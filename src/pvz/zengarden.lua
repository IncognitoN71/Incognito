SMODS.Atlas{ -- Plant Consumables
    key = "nicpvzconsumables",
    path = "pvz/nicpvzconsumables.png",
    px = 71,
    py = 95,
}

SMODS.ConsumableType {
    key = 'ZenGarden',
    default = 'c_nic_mysteryvase',
    primary_colour = G.C.NIC_PLANTS,
    secondary_colour = G.C.NIC_PLANTS,
    collection_rows = { 6, 6 },
    shop_rate = 0,
    loc_txt = {
        name = " Zen Garden ",
        collection = "Zen Garden",
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

SMODS.Consumable { -- Mystery Vase
    key = 'mysteryvase',
    set = 'ZenGarden',
    cost = 4,
    atlas = 'nicpvzconsumables',
    pos = {x = 0, y = 1 },
    soul_pos = {x = 0, y = 0 },
    config = { },
    pools = { ["Vase"] = true },

    loc_vars = function(self, info_queue, center) 
		info_queue[#info_queue+1] = G.P_CENTERS["j_nic_crazydave"]
	end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local crazy = 1
                if next(SMODS.find_card("j_nic_crazydave")) then
                    crazy = 0
                else
                    crazy = 1
                end
                local random = pseudorandom('c_nic_mysteryvase', 1 + crazy, 4)
                play_sound('nic_vasebreak')

                if random == 1 then
                    SMODS.calculate_effect({message = "Plants", colour = G.C.NIC_PLANTS }, card)
                    if #G.zengarden.cards < G.zengarden.config.card_limit then
                        SMODS.add_card({ area = G.zengarden, set = 'Joker', rarity = 'nic_plants', no_edition = true })
                    end
                elseif random == 2 then
                    SMODS.calculate_effect({message = "Joker" }, card)
                    if #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card({ set = 'Joker' })
                    end 
                elseif random == 3 then
                    SMODS.calculate_effect({message = "Consumeables" }, card)
                    if #G.consumeables.cards < G.consumeables.config.card_limit then
                        SMODS.add_card({ set = 'Consumeables' })
                    end 
                elseif random == 4 then
                    SMODS.calculate_effect({message = "Playing Card" }, card)
                    local _card = SMODS.create_card { 
                        set = "Base", 
                        edition = SMODS.poll_edition({ mod = 2 }), 
                        seal = SMODS.poll_seal({ mod = 10 }), 
                        area = G.discard 
                    }
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    _card.playing_card = G.playing_card
                    table.insert(G.playing_cards, _card)
                    
                    _card:start_materialize()
                    G.play:emplace(_card)
                    delay(1)
                    draw_card(G.play, G.deck, 90, 'up')
                end

                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,

    can_use = function(self, card)
        return true
    end,
}

SMODS.Consumable { -- Plants Vase
    key = 'plantsvase',
    set = 'ZenGarden',
    cost = 4,
    atlas = 'nicpvzconsumables',
    pos = {x = 1, y = 1 },
    soul_pos = {x = 1, y = 0 },
    config = { },
    pools = { ["Vase"] = true, ["PlantVase"] = true },

    loc_vars = function(self, info_queue, center) 
		info_queue[#info_queue+1] = G.P_CENTERS["j_nic_crazydave"]
	end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("c_nic_plantsvase")) or next(SMODS.find_card("j_nic_crazydave")) 
        }
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.calculate_effect({message = "Plants", colour = G.C.NIC_PLANTS }, card)
                play_sound('nic_vasebreak')
                SMODS.add_card({ area = G.zengarden, set = 'Joker', rarity = 'nic_plants', no_edition = true })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,

    can_use = function(self, card)
        return G.zengarden and #G.zengarden.cards < G.zengarden.config.card_limit and next(SMODS.find_card("j_nic_crazydave"))
    end,
}

SMODS.Consumable { -- Shovel
    key = 'shovel',
    set = 'ZenGarden',
    cost = 4,
    atlas = 'nicpvzconsumables',
    pos = {x = 2, y = 1 },
    soul_pos = {x = 2, y = 0 },
    config = { },
    pools = { ["Tools"] = true },

    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.zengarden or card.area == G.consumeables then
            local compatible = #G.zengarden.highlighted > 0 and #G.zengarden.highlighted == 1 and G.zengarden.highlighted[1].config.center.rarity == "nic_plants"
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GOLD, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. (compatible and (G.localization.descriptions.Joker[G.zengarden.highlighted[1].config.center.key].name .. ': $' .. G.zengarden.highlighted[1].config.center.cost) or 'Nothing') .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,

    use = function(self, card, area, copier)
        SMODS.calculate_effect({message = ("$" .. G.zengarden.highlighted[1].config.center.cost), colour = G.C.GOLD}, G.zengarden.highlighted[1])
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.6,
            func = function()
                ease_dollars(G.zengarden.highlighted[1].config.center.cost, true)
                G.zengarden.highlighted[1]:juice_up()
                return true 
            end 
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1.2,
            func = function()
                SMODS.destroy_cards(G.zengarden.highlighted[1])
                play_sound('nic_shovel', 1.2, 0.4)
                card:juice_up()
                return true 
            end 
        }))
    end,

    keep_on_use = function (self,card)
        return true
    end,

    can_use = function (self, card) 
        return #G.zengarden.highlighted > 0 and #G.zengarden.highlighted == 1 and G.zengarden.highlighted[1].config.center.rarity == "nic_plants"
    end,
}