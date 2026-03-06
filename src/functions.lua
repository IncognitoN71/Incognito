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

-- Button

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

-- Changes Variable

function SMODS.current_mod.reset_game_globals(run_start)
    reset_nic_crazytaxi_rank() -- Crazy Taxi
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
    if key == "d" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_d = true })
        end
    end
    if key == "f1" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_f1 = true })
        end
    end
    if key == "1" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_1 = true })
        end
    end
    if key == "2" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_2 = true })
        end
    end
    if key == "3" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_3 = true })
        end
    end
    if key == "4" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_4 = true })
        end
    end
    if key == "5" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_5 = true })
        end
    end
    if key == "6" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_6 = true })
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