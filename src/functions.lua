-- Object Type

SMODS.ObjectType({
    key = "Food",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
        self:inject_card(G.P_CENTERS.j_gros_michel)
        self:inject_card(G.P_CENTERS.j_egg)
        self:inject_card(G.P_CENTERS.j_ice_cream)
        self:inject_card(G.P_CENTERS.j_cavendish)
        self:inject_card(G.P_CENTERS.j_turtle_bean)
        self:inject_card(G.P_CENTERS.j_diet_cola)
        self:inject_card(G.P_CENTERS.j_popcorn)
        self:inject_card(G.P_CENTERS.j_ramen)
        self:inject_card(G.P_CENTERS.j_selzer)
    end,
})

-- Talisman Bullshit

to_big = to_big or function(num)
    return num
end

to_number = to_number or function(num)
    return num
end

-- Death Text (Lobcorp)

local new_roundref = new_round 
function new_round()
    new_roundref()
    G.GAME.death_text = nil
    G.GAME.death_texture = nil
end

-- Crazy Taxi

local function reset_nic_crazy_taxi_rank()
    G.GAME.current_round.nic_crazy_taxi_card = { rank = 'Ace' }
    local valid_crazy_taxi_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_crazy_taxi_cards[#valid_crazy_taxi_cards + 1] = playing_card
        end
    end
    local crazy_taxi_card = pseudorandom_element(valid_crazy_taxi_cards, 'nic_crazy_taxi' .. G.GAME.round_resets.ante)
    if crazy_taxi_card then
        G.GAME.current_round.nic_crazy_taxi_card.rank = crazy_taxi_card.base.value
        G.GAME.current_round.nic_crazy_taxi_card.id = crazy_taxi_card.base.id
    end
end

-- Moon Ring (What are you doing here bruh)

local function reset_nic_moonring_card()
    G.GAME.current_round.nic_moonring_card = { rank = 'Ace', suit = 'Spades' }
    local valid_moonring_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_moonring_cards[#valid_moonring_cards + 1] = playing_card
        end
    end
    local moonring_card = pseudorandom_element(valid_moonring_cards, 'nic_moonring' .. G.GAME.round_resets.ante)
    if moonring_card then
        G.GAME.current_round.nic_moonring_card.rank = moonring_card.base.value
        G.GAME.current_round.nic_moonring_card.suit = moonring_card.base.suit
        G.GAME.current_round.nic_moonring_card.id = moonring_card.base.id
    end
end

-- Resetting Every Round

function SMODS.current_mod.reset_game_globals(run_start)
    reset_nic_crazy_taxi_rank() -- Crazy Taxi
    reset_nic_moonring_card() -- Moon Ring (What are you doing here bruh)
end

-- Ratio Card Location (ThunderEdge)

local set_sprites_hook = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_sprites_hook(self, _center, _front)
    self.children.ratio_select = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS["nic_jokers"], { x = 9, y = 1 })
    self.children.ratio_select.role.draw_major = self
    self.children.ratio_select.states.hover.can = false
    self.children.ratio_select.states.click.can = false
end

SMODS.draw_ignore_keys.ratio_select = true
SMODS.DrawStep({
    key = "ratio_select",
    order = 201,
    func = function(card, layer)
        if not G.jokers then
            return
        end
        local ratio = false
        for _, v in ipairs(G.jokers.cards) do
            if v.config.center.key == "j_nic_ratio_technique" then
                ratio = true
                break
            end
        end

        local location = 0
        local ratio_location = {}
        for i = 1, #G.hand.cards do
            if not G.hand.cards[i].highlighted then
                ratio_location[#ratio_location + 1] = G.hand.cards[i]
            end
        end
        if (((( #ratio_location ) * (0.70)) * 10) % 10 ) <= 4 then 
            location = math.floor(( #ratio_location ) * (0.70))
        else
            location = math.ceil(( #ratio_location ) * (0.70))
        end

        if ratio and card.area and card.area == G.hand and G.GAME.current_round.hands_played == 0 then
            for i = 1, #ratio_location do
                if ratio_location[location] == card then 
                    card.children.ratio_select:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil)
                end
            end
        end
    end,
	conditions = { vortex = false, facing = "front" },
})

-- Button (Revo and FAC)

local card_highlight = Card.highlight
function Card:highlight(is_higlighted)
    if string.find(self.ability.name, "j_nic_button") or
    string.find(self.ability.name, "j_nic_clover_pit") or
    string.find(self.ability.name, "j_nic_jokrle") then
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
        {n=G.UIT.C, config={ref_table = card, align = "cm",padding = 0.1, r=0.08, minw = 1.25, minh = 0.8, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'nic_use_card', func = "nic_can_use_card", handy_insta_action = 'use'}, nodes={
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

G.FUNCS.nic_can_use_card = function(e)
	local center = e.config.ref_table.config.center
	local card = e.config.ref_table
	if
		center.can_use and center:can_use(e.config.ref_table) and not e.config.ref_table.debuff
		and G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT
		and not (((G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)))
	then
		e.config.colour = G.C.RED
		e.config.button = "nic_use_card"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.nic_use_card = function(e)
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

-- Click in Collection

local card_click_ref = Card.click
function Card:click(...)
    if self.config.center.key == "j_nic_button" and G.SETTINGS.paused then
        if pseudorandom('button', 1, 10) ~= 1 then
            play_sound('nic_click')
            self:juice_up()
        else
            play_sound('nic_explosion')
            self:start_dissolve({G.C.RED})
            self:juice_up(10, 10)
        end
    else
        return card_click_ref(self, ...)
    end
end

-- Boosters

buyingcard = {}

buyingcard.hooks = {}

buyingcard.hooks.Card_open = Card.open
function Card:open()
    if self.ability.set == "Booster" then
        SMODS.calculate_context({buying_booster = true, card = self})
    end
    return buyingcard.hooks.Card_open(self)
end

-- Press Card (Cryptid)

local lcpref = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ cry_press = true })
    end
end

-- Keypress (YAHIMOD)

local nicmodpress = love.keypressed
function love.keypressed(key)
    if key == "space" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_space = true })
        end
    end
    if key == "f1" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_f1 = true })
        end
    end
    return (nicmodpress(key))
end

-- Retrigger Jokers

SMODS.current_mod.optional_features = { cardareas = {}, retrigger_joker = true, post_trigger = true }