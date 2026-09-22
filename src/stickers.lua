SMODS.Atlas{ -- Sticker
    key = "stickers",
    path = "stickers.png",
    px = 71,
    py = 95,
}

SMODS.Sticker {
    key = "teto_sticker",
    badge_colour = HEX("e15d73"),
    rate = 0.0,
    atlas = "stickers",
    pos = { x = 0, y = 0 },
    config = { repetitions = 1 },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end, 

}
