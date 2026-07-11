-- Plant Select

local set_sprites_hook = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_sprites_hook(self, _center, _front)
    self.children.plant_select = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS["nic_nicpvzconsumables"], { x = 3, y = 1 })
    self.children.plant_select.role.draw_major = self
    self.children.plant_select.states.hover.can = false
    self.children.plant_select.states.click.can = false
end

SMODS.draw_ignore_keys.plant_select = true
SMODS.DrawStep({ -- (ThunderEdge)
    key = "plant_select",
    order = 201,
    func = function(card, layer)
        if not G.consumeables then
            return
        end
        local shovel = false
        for _, v in ipairs(G.consumeables.highlighted) do
            if v.config.center.key == "c_nic_shovel" then
                shovel = true
                break
            end
        end
        if card.ability and card.config.center.rarity == "nic_plants" and shovel then
            card.children.plant_select:draw_shader('dissolve', 0, nil, nil, card.children.center, nil, nil, nil, 0.1)
            card.children.plant_select:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil)
        end
    end,
	conditions = { vortex = false, facing = "front" },
})

-- Set Cost
local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    if (self.config.center.key == 'j_nic_puffshroom') then 
        self.cost = 0 
    end
    if (self.config.center.rarity == "nic_plants") then
        self.sell_cost = 0
    end
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
end

-- Card Area (Aiko)

local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.zengarden = 0
    return ret
end

local cardUpdateHook = Card.update
function Card:update(dt)
    if self.config.center_key == "j_nic_crazydave" and self.states.drag.is and G.zengarden then
        G.zengarden:set_role{role_type = "Minor", xy_bond = "Strong", major = self, offset = { x = -G.zengarden.T.w/2 + 1, y = 3}}
    end
    local x = {cardUpdateHook(self,dt)}
    return unpack(x)
end

local zengarden_emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    if self == G.jokers and card.config.center.rarity == "nic_plants" then 
		G.zengarden:emplace(card, location, stay_flipped)
		return
    end
    zengarden_emplace(self, card, location, stay_flipped)
end

-- Button Stuff (Revo)

local card_highlighted_ref = Card.highlight
function Card:highlight(is_highlighted)
	self.highlighted = is_highlighted
	if self.highlighted and string.find(self.ability.name, "j_nic_crazydave") and self.area == G.jokers then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.crazydave(self, {
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
	elseif self.highlighted and string.find(self.ability.name, "j_nic_cherrybomb") and self.area == G.zengarden then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.cherrybomb(self, {
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
	elseif self.highlighted and string.find(self.ability.name, "j_nic_potatomine") and self.area == G.zengarden then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.potatomine(self, {
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
	elseif self.highlighted and string.find(self.ability.name, "j_nic_chomper") and self.area == G.zengarden then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.chomper(self, {
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
		elseif self.highlighted and string.find(self.ability.name, "j_nic_gravebuster") and self.area == G.zengarden then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.gravebuster(self, {
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
	elseif self.highlighted and string.find(self.ability.name, "j_nic_hypnoshroom") and self.area == G.zengarden then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.hypnoshroom(self, {
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
	elseif self.highlighted and string.find(self.ability.name, "j_nic_iceshroom") and self.area == G.zengarden then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.iceshroom(self, {
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
	elseif self.highlighted and string.find(self.ability.name, "j_nic_doomshroom") and self.area == G.zengarden then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.doomshroom(self, {
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
	elseif self.highlighted and self.config.center.rarity == "nic_plants" and self.area == G.zengarden then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.defaultplant(self, {
				sell = true,
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

-- Default Plant

Incognito.defaultplant = function(card, args)
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

	return { n = G.UIT.ROOT, config = { align = "cr", padding = 0, colour = G.C.CLEAR, },
	nodes = { { n = G.UIT.C, config = { padding = 0.15, align = "cl", },
	nodes = {
		sell and { n = G.UIT.R, config = { align = "cl", }, nodes = { sell }, } or nil,
	}, }, },
	}
end

-- Crazy Dave

Incognito.crazydave = function(card, args)
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
		button = "nic_crazydave", func = "nic_can_crazydave", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "USE", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_crazydave = function(e)
	local card = e.config.ref_table
	if G.zengarden.states.visible == false then
    	G.zengarden.states.visible = true
	else
		G.zengarden.states.visible = false
	end
	G.E_MANAGER:add_event(Event({
        func = function()
            card:juice_up()
			local random = pseudorandom('j_nic_crazydave', 1, 12)
            if random == 1 then
				play_sound("nic_crazydave1")
			elseif random == 2 then
				play_sound("nic_crazydave2")
			elseif random == 3 then
				play_sound("nic_crazydave3")
			elseif random == 4 then
				play_sound("nic_crazydave4")
			elseif random == 5 then
				play_sound("nic_crazydave5")
            elseif random == 6 then
                play_sound("nic_crazydave6")
            elseif random == 7 then
                play_sound("nic_crazydave7")
			elseif random == 8 then
				play_sound("nic_crazydave8")
			elseif random == 9 then
				play_sound("nic_crazydave9")
			elseif random == 10 then
				play_sound("nic_crazydave10")
			elseif random == 11 then
				play_sound("nic_crazydave11")
			elseif random == 12 then
				play_sound("nic_crazydave12")
			end
			return true
		end
	}))
end

G.FUNCS.nic_can_crazydave = function(e)
    local card = e.config.ref_table
	e.config.colour = G.C.RED
	e.config.button = "nic_crazydave"
end

-- Cherry Bomb

Incognito.cherrybomb = function(card, args)
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
		button = "nic_cherrybomb", func = "nic_can_cherrybomb", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "BOOM", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_cherrybomb = function(e)
    local card = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        func = function()
            SMODS.destroy_cards(G.hand.highlighted)
            SMODS.destroy_cards(card)
            return true
        end
    }))
    return { play_sound("nic_cherrybomb") }
end

G.FUNCS.nic_can_cherrybomb = function(e)
    local card = e.config.ref_table
	if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra["max_highlighted"] then
		e.config.colour = G.C.RED
		e.config.button = "nic_cherrybomb"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

-- Potato Mine

Incognito.potatomine = function(card, args)
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
		button = "nic_potatomine", func = "nic_can_potatomine", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "BOOM", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_potatomine = function(e)
    local card = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        func = function()
            SMODS.destroy_cards(G.hand.highlighted)
            SMODS.destroy_cards(card)
            return true
        end
    }))
    return { play_sound("nic_potatomine") }
end

G.FUNCS.nic_can_potatomine = function(e)
    local card = e.config.ref_table
	if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra["max_highlighted"] and card.ability.extra.countdown == card.ability.extra.countdown_needed then
		e.config.colour = G.C.RED
		e.config.button = "nic_potatomine"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

-- Chomper

Incognito.chomper = function(card, args)
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
		button = "nic_chomper", func = "nic_can_chomper", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "CHOMP", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_chomper = function(e)
    local card = e.config.ref_table
	card.ability.extra["mult"] = card.ability.extra["mult"] + card.ability.extra["mult_gain"]
	card.ability.extra["countdown"] = 0
    G.E_MANAGER:add_event(Event({
        func = function()
			card:juice_up()
			G.zengarden:unhighlight_all()
            SMODS.destroy_cards(G.hand.highlighted)
            return true
        end
    }))
	return { play_sound("nic_chomper") }
end

G.FUNCS.nic_can_chomper = function(e)
    local card = e.config.ref_table
	if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra["max_highlighted"] and card.ability.extra.countdown == card.ability.extra.countdown_needed then
		e.config.colour = G.C.RED
		e.config.button = "nic_chomper"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

-- Grave Buster

Incognito.gravebuster = function(card, args)
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
		button = "nic_gravebuster", func = "nic_can_gravebuster", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "GRAVE", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_gravebuster = function(e)
    local card = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        func = function()
            SMODS.destroy_cards(G.hand.highlighted)
            SMODS.destroy_cards(card)
			local cards = {}
			for i = 1, card.ability.extra["amount"] * #G.hand.highlighted do
				local cen_pool = {}
				for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
					if enhancement_center.key ~= 'm_stone' and not enhancement_center.overrides_base_rank then
						cen_pool[#cen_pool + 1] = enhancement_center
					end
				end
				local enhancement = pseudorandom_element(cen_pool, 'nic_gravebuster')
				cards[i] = SMODS.add_card { set = "Base", enhancement = enhancement.key }
			end
			SMODS.calculate_context({ playing_card_added = true, cards = cards })
            return true
        end
    }))
    return { play_sound("nic_gravebuster") }
end

G.FUNCS.nic_can_gravebuster = function(e)
    local card = e.config.ref_table
	local stone = false
	if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra["max_highlighted"] then
		for i = 1, #G.hand.highlighted do
			for _, playing_card in ipairs(G.hand.highlighted) do
				if not SMODS.has_enhancement(playing_card, 'm_stone') then
					stone = true
				end
			end
		end
		if stone then
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		else
			e.config.colour = G.C.RED
			e.config.button = "nic_gravebuster"
		end
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

-- Hypno-shroom

Incognito.hypnoshroom = function(card, args)
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
		button = "nic_hypnoshroom", func = "nic_can_hypnoshroom", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "HYPNO", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_hypnoshroom = function(e)
    local card = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        func = function()
            SMODS.destroy_cards(card)
			for i = 1, card.ability.extra["amount"] do
				for i = 1, #G.hand.highlighted do 
					local cen_pool = {}
					for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
						if enhancement_center.key ~= 'm_stone' and not enhancement_center.overrides_base_rank then
							cen_pool[#cen_pool + 1] = enhancement_center
						end
					end
					local enhancement = pseudorandom_element(cen_pool, 'nic_hypnoshroom')

					local cards = copy_card(G.hand.highlighted[i], nil, nil, G.playing_card)

					G.playing_card = (G.playing_card and G.playing_card + 1) or 1
					cards.playing_card = G.playing_card
					table.insert(G.playing_cards, cards)
							
					cards:start_materialize()
					cards:set_ability(enhancement, true)
					G.hand:emplace(cards)
					G.hand:sort()
				end
			end
			SMODS.calculate_context({ playing_card_added = true, cards = cards })
			G.hand:unhighlight_all()
            return true
        end
    }))
    return { play_sound("nic_hypnoshroom") }
end

G.FUNCS.nic_can_hypnoshroom = function(e)
    local card = e.config.ref_table
	if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra["max_highlighted"] then
		e.config.colour = G.C.RED
		e.config.button = "nic_hypnoshroom"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

-- Ice-shroom

Incognito.iceshroom = function(card, args)
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
		button = "nic_iceshroom", func = "nic_can_iceshroom", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "FREEZE", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_iceshroom = function(e)
    local card = e.config.ref_table
	G.E_MANAGER:add_event(Event({
		func = function()
			SMODS.destroy_cards(card)
			ease_hands_played(card.ability.extra.hand)
			return true
		end
	}))
	for i = 1, #G.hand.highlighted do 
		G.E_MANAGER:add_event(Event({
			func = function()
				G.hand.highlighted[i]:juice_up()
				G.hand.highlighted[i]:set_ability("m_glass")
				return true
			end
		}))
	end
	G.E_MANAGER:add_event(Event({
		func = function()
			G.hand:unhighlight_all()
			return true
		end
	}))
	return { play_sound("nic_iceshroom") }
end

G.FUNCS.nic_can_iceshroom = function(e)
    local card = e.config.ref_table
	if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra["max_highlighted"] then
		e.config.colour = G.C.RED
		e.config.button = "nic_iceshroom"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

-- Doom-shroom

Incognito.doomshroom = function(card, args)
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
		button = "nic_doomshroom", func = "nic_can_doomshroom", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "BOOM", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_doomshroom = function(e)
    local card = e.config.ref_table
	G.E_MANAGER:add_event(Event({
		func = function()
			SMODS.destroy_cards(card)
			G.GAME.chips = G.GAME.blind.chips
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.STATE = G.STATES.HAND_PLAYED
			G.STATE_COMPLETE = true
			end_round()
			return true
		end
	}))
	for i = 1, #G.hand.cards do 
		G.E_MANAGER:add_event(Event({
			func = function()
				SMODS.destroy_cards(G.hand.cards[i])
				return true
			end
		}))
	end
	return { play_sound("nic_doomshroom") }
end

G.FUNCS.nic_can_doomshroom = function(e)
    local card = e.config.ref_table
	if G.STATE == G.STATES.SELECTING_HAND then
		e.config.colour = G.C.RED
		e.config.button = "nic_doomshroom"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end