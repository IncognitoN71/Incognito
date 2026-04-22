SMODS.Sound{ -- Black Knife
    key = "music_black_knife",
    path = "music/black_knife.ogg",
    select_music_track = function (self)
        if not Incognito.config.roaring_inc then return false end
        return next(SMODS.find_card("j_nic_incognito")) or next(SMODS.find_card("j_nic_fakeincognito")) and 1e10 or nil
    end,
    pitch = 1,
}