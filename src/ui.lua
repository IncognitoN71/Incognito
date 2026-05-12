SMODS.Atlas{ -- Logo
    key = "niclogo",
    path = "niclogo.png",
    px = 333,
    py = 210,
}

-- Logo

Incognito.custom_ui = function(nodes)
    local logo = {
        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = {0,0,0,0},
            r = 0.3,
            padding = 0.25
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = SMODS.create_sprite(
                                0, 0,
                                8, 5,
                                'nic_niclogo',
                                { x = 0, y = 0 }
                            )
                        }
                    }
                }
            }
        }
    }
    table.insert(nodes, 2, logo)
    return nodes
end

SMODS.current_mod.ui_config = {
    author_colour = G.C.NIC_INCOGNITO,
    tab_button_colour = G.C.NIC_INCOGNITO,
    back_colour = G.C.NIC_INCOGNITO,
    bg_colour = adjust_alpha(G.C.NIC_INVERT, 0.95),
    colour = darken(G.C.NIC_INVERT, .2),
    outline_colour = lighten(G.C.NIC_INVERT, .2),
}

-- Config

local old_config = copy_table(Incognito.config)
local function should_restart()
    for k, v in pairs(old_config) do
        if v ~= Incognito.config[k] then
            SMODS.full_restart = 1
            return
        end
    end
    SMODS.full_restart = 0
end

Incognito.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.07, emboss = 0.05, r = 0.1, colour = G.C.NIC_INVERT, minh = 4.5, minw = 7 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.6 },
                nodes = {
                    { n = G.UIT.T, config = { text = "Requires restart!", colour = G.C.NIC_INCOGNITO, scale = 0.6 } },
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.6 },
                nodes = {
                    {
                        n = G.UIT.C,
                        nodes = {
                            create_toggle({
                                label = "Not Finished Concepts [Mid]",
                                ref_table = Incognito.config,
                                ref_value = "not_finished",
                                callback = should_restart,
                            }),
                        },
                    },
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.6 },
                nodes = {
                    { n = G.UIT.T, config = { text = "Doesn't need restart!", colour = G.C.NIC_INCOGNITO, scale = 0.6 } },
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.6 },
                nodes = {
                    {
                        n = G.UIT.C,
                        nodes = {
                            create_toggle({
                                label = "THE ROARING INC?",
                                ref_table = Incognito.config,
                                ref_value = "roaring_inc",
                            }),
                        },
                    },
                },
            },
        },
    }
end

-- Teto Tab

function Incognito.generate_credits_desc_nodes(entry)

    local name = {} -- Name
    name[#name + 1] = {}
    local loc_vars = { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1 }
    localize { 
        type = 'name', 
        key = entry.joker, 
        set = 'Joker', 
        nodes = name[#name], 
        vars = loc_vars.vars, 
        scale = loc_vars.scale, 
        text_colour = loc_vars.text_colour, 
        shadow = loc_vars.shadow 
    }
    name[#name] = desc_from_rows(name[#name])
    name[#name].config.colour = loc_vars.background_colour or name[#name].config.colour

    local info_nodes = {} -- Song Info
    localize({
        type = "other",
        key = "nic_" .. entry.type .. "_by_" .. entry.language,
        nodes = info_nodes,
        vars = { entry.name, entry.artist }
    })
    info_rows = {}
    for _, v in ipairs(info_nodes) do
        info_rows[#info_rows + 1] = { n = G.UIT.R, config = { align = "cl" }, nodes = v }
    end

    -- Joker of Choice
    local area = CardArea(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W, G.CARD_H,
        { card_limit = 1, type = 'title', highlight_limit = 0, collection = true })                      -- Card Area
    local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[entry.joker]) -- Card Importing

    area:emplace(card)

    if entry.joker == "j_nic_tetoundiscovered" then
    else
        card.no_ui = true
    end
    if entry.link then
        function card:click()
            love.system.openURL(entry.link)
        end
    end

    return {
        n = G.UIT.R,
        config = { minw = 10, minh = 1, emboss = 0.05, r = 0.1, align = "cm", padding = 0.2, colour = G.C.NIC_TETO },
        nodes = {
            -- Name
            {
                n = G.UIT.C,
                config = { align = "cl", padding = 0.05 },
                nodes = {

                    {
                        n = G.UIT.R,
                        config = { minw = 5, emboss = 0.05, r = 0.1, align = "cm", padding = 0.05, colour = G.C.BLACK },
                        nodes = name
                    },
                    { 
                        n = G.UIT.R, 
                        config = { minh = 2, emboss = 0.05, r = 0.1, align = "cm", padding = 0.05, colour = G.C.WHITE },
                        nodes = info_rows
                    },

                }
            },

            -- Card Area
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05, },
                nodes = {
                    { n = G.UIT.O, config = { object = area } }
                }
            }
        }
    }
end

Incognito.teto_table = {
    { joker = "j_nic_kasanejokto", language = "en", type = "inspired", name = "NeatoJokers", link = "https://github.com/neatoqueen/NeatoJokers" },
    { joker = "j_nic_ambassadorteto", language = "jp", type = "song", name = "アンバサダー", artist = "dada", link = "https://www.youtube.com/watch?v=uRjI2ve5v2A" },
    { joker = "j_nic_pear", language = "en", type = "inspired", name = "Pear", link = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0mvneNqgJk_MfQyXg0Z69LfP94aWT-eDDeTSMqIJRqg&s" },
    { joker = "j_nic_pearto", language = "en", type = "inspired", name = "Pearto", link = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8bffIjOEcw_jimt704UWEbjukrGAe1obSlQ&s" },
    { joker = "j_nic_doctorkidori", language = "jp", type = "song", name = "イガク", artist = "原口沙輔", link = "https://www.youtube.com/watch?v=F38EuG2dAyM" },
    { joker = "j_nic_birdbrainteto", language = "en", type = "song", name = "BIRDBRAIN", artist = "Jamie Paige", link = "https://www.youtube.com/watch?v=0iVlSNpq8i8" },
    { joker = "j_nic_tenebrerossosangueteto", language = "en", type = "song", name = "Tenebre Rosso Sangue [Cover]", artist = "Sandwich", link = "https://www.youtube.com/watch?v=ZZowC8QXshQ" },
    { joker = "j_nic_spokenforteto", language = "en", type = "song", name = "Spoken For", artist = "FLAVOR FOLEY", link = "https://www.youtube.com/watch?v=LvYL8u4p-aM" },
    { joker = "j_nic_tetowordoftheday", language = "en", type = "inspired", name = "Love and Stuff <3", link = "https://packaged-media.redd.it/a4bqjhn3dx6f1/pb/m2-res_480p.mp4?m=DASHPlaylist.mpd&c=wh_ben_en&var=sgpssan&v=1&e=1777672800&s=ab936fdd4882dca83bc69ac96e213ecf2bdec0ce" },
    { joker = "j_nic_mesmerizerteto", language = "jp", type = "song", name = "メズマライザー", artist = "32ki", link = "https://www.youtube.com/watch?v=19y8YTbvri8" },
    { joker = "j_nic_spamteto", language = "en", type = "inspired", name = "Koasha Spamteto", link = "https://x.com/koafreedraw/status/1943076068841394300" },
    { joker = "j_nic_tetoris", language = "jp", type = "song", name = "テトリス", artist = "柊マグネタイト", link = "https://www.youtube.com/watch?v=Soy4jGPHr3g" },
    { joker = "j_nic_minimumrageteto", language = "en", type = "song", name = "MINIMUM RAGE", artist = "MonochroMenace", link = "https://www.youtube.com/watch?v=J8vjHOyVxUA" },
    { joker = "j_nic_tetoterritory", language = "jp", type = "song", name = "oxi", artist = "重音territory", link = "https://www.youtube.com/watch?v=JALbemLw3G4"  },
    { joker = "j_nic_contradictionsteto", language = "en", type = "song", name = "CONTRADICTIONS", artist = "Darkbluecat", link = "https://www.youtube.com/watch?v=A0ih5EaG4yw" },
    { joker = "j_nic_pearbasket", language = "en", type = "inspired", name = "The Pears Greed >:3", link = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOjN5WPuEoSRMRFaV9vCrpjYYjB6OQyXtMZg&s" },
    { joker = "j_nic_keychainteto", language = "en", type = "inspired", name = "Portable Teto", link = "https://www.ebay.com/itm/167205736613" },
    { joker = "j_nic_logoffteto", language = "en", type = "song", name = "LOG OFF", artist = "Staircatte", link = "https://www.youtube.com/watch?v=qKOJ5_IkUXY" },
    { joker = "j_nic_tetoos", language = "en", type = "song", name = "Machine Love", artist = "Jamie Paige", link = "https://www.youtube.com/watch?v=sqK-jh4TDXo" },
    { joker = "j_nic_cadmiumcolors", language = "en", type = "song", name = "Cadmium Colors", artist = "Jamie Paige", link = "https://www.youtube.com/watch?v=1U6qefKcOrg" },
}

function Incognito.teto_ui()
    rows = {}

    for _, entry in ipairs(Incognito.teto_table) do
        rows[#rows + 1] = Incognito.generate_credits_desc_nodes(entry)
    end

    local scrollbox = SMODS.UIScrollBox({
		content = {
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.BLACK },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", padding = 0.1 },
						nodes = rows,
					},
				},
			},
			config = { align = "cm" },
		},
		overflow = {
			node_config = {
				maxh = 8,
				r = 0.1,
			},
		},
		sync_mode = "progress",
	})

    return {
		n = G.UIT.ROOT,
		config = { align = "cm", colour = G.C.BLACK, padding = 0.1 },
		nodes = {
            {
                n = G.UIT.C,
                config = { align = "cm", minh = 0.6 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { minh = 1, align = "cm", colour = G.C.WHITE, padding = 0.1, r = 0.1, emboss = 0.05 },
                        nodes = {
                            { 
                                n = G.UIT.T, 
                                config = { 
                                    text = "Click Joker for Information!", 
                                    colour = G.C.NIC_TETO, 
                                    scale = 0.6 
                                } 
                            },
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = { minw = 10, align = "cm", colour = G.C.L_BLACK, padding = 0.1, r = 0.1, emboss = 0.05 },
                        nodes = {
                            {
                                n = G.UIT.O,
                                config = {
                                    align = "cm",
                                    object = scrollbox,
                                },
                            },
                        },
                    },
                    
                },
            },
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					SMODS.GUI.scrollbar({
						h = 9,
						w = 0.3,
						max = 1,
						min = 0,
						bg_colour = { 0, 0, 0, 0.15 },
						scroll_collision_obj = scrollbox,
					}),
				},
			},
		},
	}
end

SMODS.Atlas { -- Teto Undiscovered
    key = 'nictetoundiscovered',
    path = "crossmod/nictetoundiscovered.png",
    px = 71,
    py = 95
}

SMODS.Joker{ -- Teto Undiscovered
    key = "tetoundiscovered",
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nictetoundiscovered',
    rarity = 'nic_teto',
    cost = 4,
    pos = {x = 0, y = 0},
    config = { extra = { } },

    in_pool = function(self, args)
        return false
    end,

    add_to_deck = function(self, card, from_debuff)
        card:juice_up()
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1.5,
            func = function()
                G.GAME.death_text = "tetoundiscovered"
                G.GAME.death_texture = "nictetoundiscovered"
                G.STATE = G.STATES.GAME_OVER
                G.FILE_HANDLER.force = true
                G.STATE_COMPLETE = false
                return true
            end
        }))
    end
}

Incognito.cool_mods_table = {
    { joker = (Hyperfixation and "j_nic_tetoraq") or "j_nic_tetoundiscovered", language = "en", type = "mod", name = "Hyperfixation", artist = Hyperfixation and "got the mod :3" or "get the mod >:(" , link = "https://github.com/tomatoseandcrying/hyperfixation-OLD-/tree/dev" },
    { joker = (Hyperfixation and "j_nic_tetolyne") or "j_nic_tetoundiscovered", language = "en", type = "mod", name = "Hyperfixation", artist = Hyperfixation and "got the mod :3" or "get the mod >:(" , link = "https://github.com/tomatoseandcrying/hyperfixation-OLD-/tree/dev" },
    { joker = (MoreFluff and "j_nic_triteto") or (FLUFF and "j_nic_tritetorewritten") or "j_nic_tetoundiscovered", language = "en", type = "mod", name = "MoreFluff", artist = (MoreFluff or FLUFF) and "got the mod :3" or "get the mod >:(" , link = "https://github.com/notmario/MoreFluff" },
    { joker = (ALLOY and "j_nic_tetorobo") or "j_nic_tetoundiscovered", language = "en", type = "mod", name = "ALLOY", artist = ALLOY and "got the mod :3" or "get the mod >:(" , link = "https://github.com/TheCoroboCorner/Alloy" },
    { joker = (next(SMODS.find_mod("LobotomyCorp")) and "j_nic_mysteto") or "j_nic_tetoundiscovered", language = "en", type = "mod", name = "LobotomyCorp", artist = next(SMODS.find_mod("LobotomyCorp")) and "got the mod :3" or "get the mod >:(" , link = "https://github.com/Mysthaps/LobotomyCorp" },
    { joker = (next(SMODS.find_mod("baddirector")) and "j_nic_tetoxko") or "j_nic_tetoundiscovered", language = "en", type = "mod", name = "BadDirector", artist = next(SMODS.find_mod("baddirector")) and "got the mod :3" or "get the mod >:(" , link = "https://github.com/Clickseee/BadDirector" },
    { joker = (next(SMODS.find_mod("entr")) and "j_nic_rubteto") or "j_nic_tetoundiscovered", language = "en", type = "mod", name = "Entropy", artist = next(SMODS.find_mod("entr")) and "got the mod :3" or "get the mod >:(" , link = "https://github.com/lord-ruby/Entropy" },
}

function Incognito.cool_mods_ui()
    rows = {}

    for _, entry in ipairs(Incognito.cool_mods_table) do
        rows[#rows + 1] = Incognito.generate_credits_desc_nodes(entry)
    end

    local scrollbox = SMODS.UIScrollBox({
		content = {
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.BLACK },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", padding = 0.1 },
						nodes = rows,
					},
				},
			},
			config = { align = "cm" },
		},
		overflow = {
			node_config = {
				maxh = 8,
				r = 0.1,
			},
		},
		sync_mode = "progress",
	})

    return {
		n = G.UIT.ROOT,
		config = { align = "cm", colour = G.C.BLACK, padding = 0.1 },
		nodes = {
            {
                n = G.UIT.C,
                config = { align = "cm", minh = 0.6 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { minh = 1, align = "cm", colour = G.C.WHITE, padding = 0.1, r = 0.1, emboss = 0.05 },
                        nodes = {
                            { 
                                n = G.UIT.T, 
                                config = { 
                                    text = "Click Joker for Information!", 
                                    colour = G.C.NIC_TETO, 
                                    scale = 0.6 
                                } 
                            },
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = { minw = 10, align = "cm", colour = G.C.L_BLACK, padding = 0.1, r = 0.1, emboss = 0.05 },
                        nodes = {
                            {
                                n = G.UIT.O,
                                config = {
                                    align = "cm",
                                    object = scrollbox,
                                },
                            },
                        },
                    },
                    
                },
            },
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					SMODS.GUI.scrollbar({
						h = 9,
						w = 0.3,
						max = 1,
						min = 0,
						bg_colour = { 0, 0, 0, 0.15 },
						scroll_collision_obj = scrollbox,
					}),
				},
			},
		},
	}
end

-- Extra Tabs

SMODS.current_mod.extra_tabs = function() --Mod Tabs
    return {
        {
            label = 'Teto Info',
            tab_definition_function = Incognito.teto_ui,
        },
        {
            label = 'Cool Mods',
            tab_definition_function = Incognito.cool_mods_ui,
        },
    }
end