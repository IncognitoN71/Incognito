SMODS.Atlas { -- Tags
  key = "nictags",
  px = 34,
  py = 34,
  path = "nictags.png" 
}

SMODS.Tag { -- Teto Tag
    key = "teto",
    atlas = 'nictags',
    pos = { x = 0, y = 0 },

    in_pool = function(self, args)
        return false
    end,

    apply = function(self, tag, context)
        if context.type == 'store_joker_create' then
            local card = SMODS.create_card {
                set = "Joker",
                rarity = "nic_teto",
                area = context.area,
            }
            create_shop_card_ui(card, 'Joker', context.area)
            card.states.visible = false
            tag:yep('+', HEX("e15d73"), function()
                card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
                return true
            end)
            tag.triggered = true
            return card
        end
    end
}

SMODS.Tag { -- Twindrill Tag
    key = "twindrill",
    atlas = 'nictags',
    pos = { x = 1, y = 0 },

    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_nic_teto_booster
    end,

    in_pool = function(self, args)
        return false
    end,
    
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', HEX("e15d73"), function()
                local booster = SMODS.create_card { key = 'p_nic_teto_booster', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

SMODS.Tag { -- Vase Tag
    key = "vase",
    atlas = 'nictags',
    pos = { x = 2, y = 0 },

    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_nic_vase_booser1
    end,

    in_pool = function(self, args)
        return false
    end,
    
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', HEX("e15d73"), function()
                local booster = SMODS.create_card { key = 'p_nic_vase_booster' .. math.random(1, 2), area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}