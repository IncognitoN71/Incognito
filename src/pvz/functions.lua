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

-- Button (Revo and FAC)

local card_highlight = Card.highlight
function Card:highlight(is_higlighted)
    if self.config.center.rarity == "nic_plants" or string.find(self.ability.name, "j_nic_crazydave") then
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
		end
	else
		card_highlight(self, is_higlighted)
	end
end

function Incognito.use_and_sell_buttons(card)
    local sell = {n=G.UIT.C, config={align = "cr"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'buy_or_sell'}, nodes={
            {n=G.UIT.B, config = {w=0.1,h=0.6}},
            {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                    {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.55, shadow = true}},
                    {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
            }}
        }},
    }}
    
    local use = {n=G.UIT.C, config={align = "cr"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cm",padding = 0.1, r=0.08, minw = 1.25, minh = 0.8, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'use_plant', func = "can_use_plant", handy_insta_action = 'use'}, nodes={
            {n=G.UIT.B, config = {w=0.1,h=0.6}},
            {n=G.UIT.C, config={align = "cm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                    {n=G.UIT.T, config={text = localize("b_use"), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                }},
            }},
        }},
    }}

    local ret = {
    n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
            {n=G.UIT.R, config={align = 'cl'}, nodes={
                sell
            }},
            card.config.center.use and {n=G.UIT.R, config={align = 'cl'}, nodes={
                use
            }},
        }},
    }}
    return ret
end

G.FUNCS.can_use_plant = function(e)
	local center = e.config.ref_table.config.center
	local card = e.config.ref_table
	if
		center.can_use and center:can_use(e.config.ref_table) and not e.config.ref_table.debuff
		and G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT
		and not (((G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)))
	then
		e.config.colour = G.C.RED
		e.config.button = "use_plant"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.use_plant = function(e)
	local card = e.config.ref_table
	local prev_state = G.TAROT_INTERRUPT
	G.TAROT_INTERRUPT = G.STATE
	G.CONTROLLER.locks.use = true
	
	local center = card.config.center
	local keep_on_use = false
	if center.keep_on_use and type(center.keep_on_use) == 'function' then
        keep_on_use = center:keep_on_use(card)
    end
	if center.use and type(center.use) == 'function' then
		center:use(card)
	end

	G.E_MANAGER:add_event(Event({
		delay = 0.2,
		func = function()
			if not keep_on_use then card:start_dissolve() end
			G.E_MANAGER:add_event(Event({
				delay = 0.1,
				func = function()
					G.TAROT_INTERRUPT = prev_state
					G.CONTROLLER.locks.use = false
					return true;
				end
			}))
			return true;
		end
	}))

	SMODS.calculate_context{use_plant = card, kept_on_use = keep_on_use}
end