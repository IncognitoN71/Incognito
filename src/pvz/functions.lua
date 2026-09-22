-- Plant Select (ThunderEdge)

local set_sprites_hook = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_sprites_hook(self, _center, _front)
    self.children.plant_select = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS["nic_pvz_consumables"], { x = 3, y = 1 })
    self.children.plant_select.role.draw_major = self
    self.children.plant_select.states.hover.can = false
    self.children.plant_select.states.click.can = false
end

SMODS.draw_ignore_keys.plant_select = true
SMODS.DrawStep({
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

-- No Sell (Hyperfixation)

local nosell_hook = Card.can_sell_card
function Card:can_sell_card(context)
	if self.config.center.key == 'j_nic_crater' then
		return false
	else
		return nosell_hook(self, context)
	end
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

--[[local zengarden_emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    if self == G.jokers and card.config.center.rarity == "nic_plants" then 
		G.zengarden:emplace(card, location, stay_flipped)
		return
    end
    zengarden_emplace(self, card, location, stay_flipped)
end]]

Incognito.get_card_limit = function(card)
    return card and card.ability and card.ability.card_limit or 0
end

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.ability.set ~= 'Joker' then return check_for_buy_space_ref(card) end
    if card.config.center.rarity == "nic_plants" then
        if #G.zengarden.cards < G.zengarden.config.card_limit + Incognito.get_card_limit(card) then
            return true
        else
            alert_no_space(card, G.zengarden)
            return false
        end
    end
    return check_for_buy_space_ref(card)
end

-- Clicky click

local card_click_ref = Card.click
function Card:click(...)
    if self.config.center.key == "j_nic_crazy_dave" and G.SETTINGS.paused then
        play_sound("nic_crazydave" ..  pseudorandom('j_nic_crazy_dave', 1, 12))
        self:juice_up()
    elseif self.config.center.key == "j_nic_cherry_bomb" and G.SETTINGS.paused then
        play_sound('nic_cherrybomb')
        self:start_dissolve()
        self:juice_up()
    elseif self.config.center.key == "j_nic_potato_mine" and G.SETTINGS.paused then
        play_sound('nic_potatomineexplode')
        self:start_dissolve()
        self:juice_up()
    elseif self.config.center.key == "j_nic_chomper" and G.SETTINGS.paused then
        play_sound('nic_chomper')
        self.children.center:set_sprite_pos({x = 8, y = 0})
        self:juice_up()
    elseif self.config.center.key == "j_nic_grave_buster" and G.SETTINGS.paused then
        play_sound('nic_gravebuster')
        self:start_dissolve()
        self:juice_up()
    elseif self.config.center.key == "j_nic_hypno_shroom" and G.SETTINGS.paused then
        play_sound('nic_hypnoshroom')
        self:start_dissolve()
        self:juice_up()
    elseif self.config.center.key == "j_nic_scaredy_shroom" and G.SETTINGS.paused then
        play_sound('tarot1')
        self.children.center:set_sprite_pos({x = 8, y = 1})
        self:juice_up()
    elseif self.config.center.key == "j_nic_ice_shroom" and G.SETTINGS.paused then
        play_sound('nic_iceshroom')
        self:start_dissolve()
        self:juice_up()
    elseif self.config.center.key == "j_nic_doom_shroom" and G.SETTINGS.paused then
        play_sound('nic_doomshroom')
        self:set_ability('j_nic_crater')
        self:juice_up()
    else
        return card_click_ref(self, ...)
    end
end

-- Button (Revo and FAC)

local card_highlight = Card.highlight
function Card:highlight(is_higlighted)
    if self.config.center.rarity == "nic_plants" or string.find(self.ability.name, "j_nic_crazy_dave") then
        self.highlighted = is_higlighted
		if self.highlighted and self.area and self.area.config.type ~= "shop" and self.area.config.type ~= "consumeable" then
            self.children.use_button = UIBox({
                definition = Incognito.use_and_sell_buttons(self),
                config = {
                    align = "cr",
                    offset = {
                        x = -0.4,
                        y = 0,
                    },
                    parent = self,
                },
            })
        elseif self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		else
		    card_highlight(self, is_higlighted)
	    end
	else
		card_highlight(self, is_higlighted)
	end
end