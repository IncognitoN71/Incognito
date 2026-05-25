SMODS.Atlas{ -- Alloy Jokers
    key = "nicalloy",
    path = "crossmod/nicalloy.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Corobo Teto
    key = "tetorobo",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicalloy',
    rarity = "nic_teto",
    cost = 5,
    pos = { x = 0, y = 1 },
    soul_pos = {
        x = 2,
        y = 0,
        draw = function(card, scale_mod, rotate_mod)
            local speed = 0
            if card.ability.extra.mood <= 10 then speed = 0 -- Depression
            elseif card.ability.extra.mood <= 20 then speed = 0.1 -- Sad
            elseif card.ability.extra.mood <= 40 then speed = 1 -- Normal
            elseif card.ability.extra.mood <= 60 then speed = 1.5 -- Content
            elseif card.ability.extra.mood <= 95 then speed = 2 -- Happy
            elseif card.ability.extra.mood <= 100 then speed = 3 -- Ecstatic
            end

            scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) *
                    math.pi * 14) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            rotate_mod = 0.3 * math.sin(10 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL) * math.pi * 5) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            card.children.floating_sprite:draw_shader('dissolve',
                0, nil, nil, card.children.center, scale_mod, rotate_mod * speed , nil, 0.1)
            card.children.floating_sprite:draw_shader('dissolve',
                nil, nil, nil, card.children.center, scale_mod, rotate_mod * speed)
        end
    },
    config = { 
        extra = { 
            click = 0, 
            click_gain = 100,

            mood = 30,

            sadness = 5,
        } 
    },
    pools = { ["Teto"] = true },
    dependencies = { 'Alloy' },

    loc_vars = function(self, info_queue, card) 
        local shieldbonus = (card.ability.extra.mood / 100) * 25
        local xmult = (card.ability.extra.mood / 100) * 5
        local hashtag = "#"

        if card.ability.extra.mood >= 10 then colour1 = G.C.SUITS.Hearts else colour1 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.mood >= 20 then colour2 = G.C.SUITS.Hearts else colour2 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.mood >= 30 then colour3 = G.C.SUITS.Hearts else colour3 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.mood >= 40 then colour4 = G.C.SUITS.Hearts else colour4 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.mood >= 50 then colour5 = G.C.SUITS.Hearts else colour5 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.mood >= 60 then colour6 = G.C.SUITS.Hearts else colour6 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.mood >= 70 then colour7 = G.C.SUITS.Hearts else colour7 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.mood >= 80 then colour8 = G.C.SUITS.Hearts else colour8 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.mood >= 90 then colour9 = G.C.SUITS.Hearts else colour9 = G.C.UI.TEXT_INACTIVE end
        if card.ability.extra.mood >= 100 then colour10 = G.C.SUITS.Hearts else colour10 = G.C.UI.TEXT_INACTIVE end

        info_queue[#info_queue + 1] = { key = "nic_tetorobo_moodmeter", set = "Other", vars = { colours = { colour1, colour2, colour3, colour4, colour5, colour6, colour7, colour8, colour9, colour10 }, hashtag, card.ability.extra.mood } }
        info_queue[#info_queue + 1] = { key = "nic_tetorobo_shieldbonus", set = "Other", vars = { math.ceil(shieldbonus) } }
        info_queue[#info_queue + 1] = { key = "nic_tetorobo_xmult", set = "Other", vars = { xmult } }
        return { vars = { card.ability.extra.click, card.ability.extra.sadness } }
	end,

    add_to_deck = function (self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                card.ability.extra.mood = 30
                card.ability.extra.click = 0
                return true
            end
        }))
    end,

    update = function(self, card)
        if card.ability.extra.mood <= 10 then card.children.floating_sprite:set_sprite_pos({x = 0, y = 0}) -- Depression
        elseif card.ability.extra.mood <= 20 then card.children.floating_sprite:set_sprite_pos({x = 1, y = 0}) -- Sad
        elseif card.ability.extra.mood <= 40 then card.children.floating_sprite:set_sprite_pos({x = 2, y = 0}) -- Normal
        elseif card.ability.extra.mood <= 60 then card.children.floating_sprite:set_sprite_pos({x = 3, y = 0}) -- Content
        elseif card.ability.extra.mood <= 95 then card.children.floating_sprite:set_sprite_pos({x = 4, y = 0}) -- Happy
        elseif card.ability.extra.mood <= 100 then card.children.floating_sprite:set_sprite_pos({x = 5, y = 0}) -- Ecstatic
        end
        if card.ability.extra.mood < 0 then card.ability.extra.mood = 0 end
        if card.ability.extra.mood > 100 then card.ability.extra.mood = 100 end
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if G.GAME.current_round.hands_played == 1 then
                local shieldbonus = (card.ability.extra.mood / 100) * 25
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ALLOY.ease_shield(math.ceil(shieldbonus))
                        card:juice_up()
                        play_sound("nic_meow")
                        return true
                    end
                }))
                SMODS.calculate_effect({message = "+" .. math.ceil(shieldbonus) .. " Shield", colour = G.C.CHIPS}, card)
			end
		end

        if context.setting_blind and not context.blueprint_compat then
            local sadness = card.ability.extra.sadness
            card.ability.extra.mood = card.ability.extra.mood - sadness
            SMODS.calculate_effect({message = "-" .. sadness .. " Sadness", colour = G.C.CHIPS}, card)
            card.ability.extra.click = 0
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint_compat then
            if G.GAME.blind.boss then
                card.ability.extra.sadness = card.ability.extra.sadness * 2
            end
            local happiness = card.ability.extra.click * 0.1
            if card.ability.extra.mood + happiness > 100 then
                happiness = happiness - card.ability.extra.mood
            end
            card.ability.extra.mood = card.ability.extra.mood + math.floor(happiness)
            SMODS.calculate_effect({message = "+" .. math.floor(happiness) .. " Happiness", colour = G.C.RED}, card)
            card.ability.extra.click = 0
        end

        if context.joker_main then
            if context.scoring_name == "Pair" then
                return {
                    xmult = (card.ability.extra.mood / 100) * 5
                }
            end
        end
    end
}

local card_highlighted_ref = Card.highlight
function Card:highlight(is_highlighted)
	self.highlighted = is_highlighted
	if self.highlighted and string.find(self.ability.name, "j_nic_tetorobo") and self.area == G.jokers then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.tetorobo(self, {
				sell = true,
				use = true,
			}),
			config = {
				align = "cr",
				offset = {
					x = -0.4,
					y = 0,
				},
				parent = self,
			},
		})
    else
		card_highlighted_ref(self, is_highlighted)
	end
end

Incognito.tetorobo = function(card, args)
	local args = args or {}
	local sell = nil
	local use = nil

	if args.sell then
		sell = { n = G.UIT.C, config = { align = "cr", },
		nodes = { { n = G.UIT.C, config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, 
		one_press = true, button = "sell_card", func = "can_sell_card", },

		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0.6, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = localize("b_sell"), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true, }, }, }, }, { n = G.UIT.R, config = { align = "cm", },
		nodes = { { n = G.UIT.T, config = { text = localize("$"), colour = G.C.WHITE, scale = 0.4, shadow = true, }, }, { n = G.UIT.T, config = { ref_table = card, ref_value = "sell_cost_label", colour = G.C.WHITE, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
		}
	end

	if args.use then
		use = { n = G.UIT.C, config = { align = "cr", }, 
		nodes = { { n = G.UIT.C, config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 0, minh = 0.8, hover = true, shadow = true, colour = G.C.RED,
		button = "nic_tetorobo", func = "nic_can_tetorobo", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "PET", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
		}
	end

	return { n = G.UIT.ROOT, config = { align = "cr", padding = 0, colour = G.C.CLEAR, },
	nodes = { { n = G.UIT.C, config = { padding = 0.15, align = "cl", },
	nodes = {
		sell and { n = G.UIT.R, config = { align = "cl", }, nodes = { sell }, } or nil,
		use and { n = G.UIT.R, config = { align = "cl", }, nodes = { use }, } or nil, 
	}, }, },
	}
end

G.FUNCS.nic_tetorobo = function(e)
    local card = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        func = function()
            card.ability.extra["click"] = card.ability.extra["click"] + card.ability.extra["click_gain"]
            card:juice_up()
            return true
        end
    }))
    return { play_sound("nic_meow") }
end

G.FUNCS.nic_can_tetorobo = function(e)
    local card = e.config.ref_table
	if G.STATE == G.STATES.SELECTING_HAND then
		e.config.colour = G.C.RED
		e.config.button = "nic_tetorobo"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end