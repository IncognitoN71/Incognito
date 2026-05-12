-- Debuff

--[[SMODS.current_mod.set_debuff = function(card)
    if next(SMODS.find_card("j_nic_incognito")) and card.playing_card and card:is_suit("Spades") then
        return "prevent_debuff"
    end
end]]

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

-- G.GAME

local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.phases_numerator = 1
    ret.phases_denominator = 100
    return ret
end

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

-- Cards are Considered Rank (TGOI)

--[[local getiduse = false
local getidref = Card.get_id
function Card:get_id()
	if not getiduse then
		getiduse = true
		local id = getidref(self) or self.base.id
		if next(SMODS.find_card('j_nic_doctorkidori')) then id = 4 end
		getiduse = false
		return id
	else
		getiduse = false
		return getidref(self)
	end
end]]

-- Crazy Taxi

local function reset_nic_crazytaxi_rank()
    G.GAME.current_round.nic_crazytaxi_card = { rank = 'Ace' }
    local valid_crazytaxi_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_crazytaxi_cards[#valid_crazytaxi_cards + 1] = playing_card
        end
    end
    local crazytaxi_card = pseudorandom_element(valid_crazytaxi_cards, 'nic_crazytaxi' .. G.GAME.round_resets.ante)
    if crazytaxi_card then
        G.GAME.current_round.nic_crazytaxi_card.rank = crazytaxi_card.base.value
        G.GAME.current_round.nic_crazytaxi_card.id = crazytaxi_card.base.id
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
    reset_nic_crazytaxi_rank() -- Crazy Taxi
    reset_nic_moonring_card() -- Moon Ring (What are you doing here bruh)
end

-- Use in Jokers

local card_highlighted_ref = Card.highlight
function Card:highlight(is_highlighted)
	self.highlighted = is_highlighted
	if self.highlighted and string.find(self.ability.name, "j_nic_button") and self.area == G.jokers then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.button(self, {
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
    elseif self.highlighted and string.find(self.ability.name, "j_nic_cloverpit") and self.area == G.jokers then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = Incognito.cloverpit(self, {
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

-- Button Joker

Incognito.button = function(card, args)
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
		button = "nic_button", func = "nic_can_button", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "PRESS", colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_button = function(e)
    local card = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        func = function()
            if SMODS.pseudorandom_probability(card, ('j_nic_button'),  1, card.ability.extra["odds"]) then
                card:start_dissolve({G.C.RED})
                card:juice_up(10, 10)
                SMODS.calculate_effect({message = "BOOM!", colour = G.C.RED}, card)
                return { play_sound("nic_explosion") }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult", 
                    scalar_value = "xmult_gain",
                    no_message = true,
                })
                card:juice_up()
                return { play_sound("nic_click") }
            end
            return true
        end
    }))
end

G.FUNCS.nic_can_button = function(e)
    local card = e.config.ref_table
	e.config.colour = G.C.RED
	e.config.button = "nic_button"
end

-- Cloverpit Joker

Incognito.cloverpit = function(card, args)
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
		button = "nic_cloverpit", func = "nic_can_cloverpit", },
		
		nodes = { { n = G.UIT.B, config = { w = 0.1, h = 0, }, }, { n = G.UIT.C, config = { align = "tm", },
		nodes = { { n = G.UIT.R, config = { align = "cm", maxw = 1.25, },
		nodes = { { n = G.UIT.T, config = { text = "$" .. card.ability.extra["dollars_loss"], colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true, }, }, }, }, }, }, }, }, }, 
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

G.FUNCS.nic_cloverpit = function(e)
    local card = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        func = function()
            ease_dollars(-card.ability.extra.dollars_loss, true)
            card.ability.extra["mult"] = pseudorandom('j_nic_cloverpit', card.ability.extra["min"], card.ability.extra["max"])
            card:juice_up()
            SMODS.calculate_effect({message = "LETS GO GAMBLING!", colour = G.C.RED}, card)
            return true
        end
    }))
end

G.FUNCS.nic_can_cloverpit = function(e)
    local card = e.config.ref_table
    if G.GAME.dollars > (card.ability.extra["dollars_loss"] - 1) then
        e.config.colour = G.C.GOLD
		e.config.button = "nic_cloverpit"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
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

-- Vouchers/Boosters

buyingcard = {}

function nic_ctx(context)
    if context.nic_buying_voucher then return 'buy a voucher' end
    if context.nic_buying_booster then return 'buy a booster pack' end
end

buyingcard.hooks = {}

buyingcard.hooks.Card_open = Card.open
function Card:open()
    if self.ability.set == "Booster" then
        SMODS.calculate_context({nic_buying_booster = true, card = self})
    end
    return buyingcard.hooks.Card_open(self)
end

buyingcard.hooks.Card_redeem = Card.redeem
function Card:redeem()
    if self.ability.set == "Voucher" then
        SMODS.calculate_context({nic_buying_voucher = true, card = self})
    end
    return buyingcard.hooks.Card_redeem(self)
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

-- Gradient

--[[SMODS.Gradient{
    key = 'rainbow',
    colours = {
        HEX('e50000'),
        HEX('ff8d00'),
        HEX('ffee00'),
        HEX('028121'),
        HEX('004cff'),
        HEX('770088')
    },
}]]

--G.ARGS.LOC_COLOURS['nic_rainbow'] = SMODS.Gradients['rainbow']

-- card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "71!", colour = HEX("d0d0d0")})