SMODS.Atlas{ -- Backs
    key = 'backs',
    path = 'backs.png',
    px = 71,
    py = 95,
}

SMODS.Back {
    key = "plants",
    atlas = 'backs',
    pos = { x = 0, y = 0 },
    config = { joker = 'j_nic_crazy_dave', consumables = { 'c_nic_mystery_vase', 'c_nic_mystery_vase' } },
    loc_vars = function(self, info_queue, back)
        return {
            vars = { localize ({ type = 'name_text', key = self.config.joker, set = 'Joker' }),
                localize { type = 'name_text', key = self.config.consumables[1], set = 'ZenGarden' },
            }
        }
    end,
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card({
						set = "Joker",
						key = self.config.joker,
					})
					return true
				end
			end,
		}))
	end,
}

SMODS.Back {
    key = "tidal",
    atlas = 'backs',
    pos = { x = 1, y = 0 },
    config = { voucher = 'v_crystal_ball', consumables = { 'c_nic_new_moon', 'c_high_priestess' } },

    loc_vars = function(self, info_queue, back)
        return {
            vars = { localize { type = 'name_text', key = self.config.voucher, set = 'Voucher' },
                localize { type = 'name_text', key = self.config.consumables[1], set = 'Phases' },
                localize { type = 'name_text', key = self.config.consumables[2], set = 'Tarot' }
            }
        }
    end,
}

SMODS.Back {
    key = "3decks",
    atlas = 'backs',
    pos = { x = 2, y = 0 },
    config = { joker = 'j_nic_3ds', consumables = { 'c_nic_pokemon_heart_gold' } },
    loc_vars = function(self, info_queue, back)
        return {
            vars = { localize ({ type = 'name_text', key = self.config.joker, set = 'Joker' }),
                localize { type = 'name_text', key = self.config.consumables[1], set = 'Cartridge' },
            }
        }
    end,
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card({
						set = "Joker",
						key = self.config.joker,
					})
					return true
				end
			end,
		}))
	end,
}