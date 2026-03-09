SMODS.Atlas{ -- Boosters
    key = 'nicboosters',
    path = 'nicboosters.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'teto_normal',
    atlas = 'nicboosters',
    pos = {x = 0, y = 0},
    discovered = false,
    weight = 0.5,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Teto',
    group_key = "k_nic_teto_pack",

    ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.NIC_TETO, special_colour = G.C.CLEAR })
    end,

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,

    create_card = function(self, card)
        return { 
            set = "Teto", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}

SMODS.ObjectType{
    key = "Teto",
    cards = {},
    default = 'j_nic_kasanejokto',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Booster{
    key = 'vase_normal_1',
    atlas = 'nicboosters',
    pos = {x = 1, y = 0},
    discovered = false,
    weight = 0.5,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Vase',
    group_key = "k_nic_vase_pack",

    ease_background_colour = function(self)
        ease_background_colour({ new_colour = HEX("96603f"), special_colour = G.C.CLEAR })
    end,

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,

    create_card = function(self, card)
        return { 
            set = "Vase", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}

SMODS.ObjectType{
    key = "Vase",
    cards = {},
    default = 'c_nic_mysteryvase',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Booster{
    key = 'vase_normal_2',
    atlas = 'nicboosters',
    pos = {x = 2, y = 0},
    discovered = false,
    weight = 0.1,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Vase',
    group_key = "k_nic_vase_pack",

    ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.NIC_PLANTS, special_colour = G.C.CLEAR })
    end,

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,

    create_card = function(self, card)
        return { 
            set = "PlantsVase", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}

SMODS.ObjectType{
    key = "PlantsVase",
    cards = {},
    default = 'c_nic_plantsvase',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Booster{
    key = 'tools_normal',
    atlas = 'nicboosters',
    pos = {x = 3, y = 0},
    discovered = false,
    weight = 0,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Tools',
    group_key = "k_tools_pack",
    select_card = 'consumeables',

    ease_background_colour = function(self)
        ease_background_colour({ new_colour = HEX("96603f"), special_colour = G.C.CLEAR })
    end,

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,

    create_card = function(self, card)
        return {
            set = "Tools", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}

SMODS.ObjectType{
    key = "Tools",
    cards = {},
    default = 'c_nic_mysteryvase',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Booster{
    key = 'lunar_normal_1',
    atlas = 'nicboosters',
    pos = {x = 0, y = 1},
    discovered = false,
    weight = 0.5,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Phases',
    group_key = "k_nic_lunar_pack",

    ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = G.C.NIC_PHASES })
    end,

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { key = "nic_specialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,

    create_card = function(self, card, center)
        local phases
        if pseudorandom('moonchange', G.GAME.phases_numerator, G.GAME.phases_denominator) == G.GAME.phases_numerator then
            phases = {
                key = (pseudorandom_element(G.P_CENTER_POOLS.SpecialPhases, 'specialphases', {in_pool = function() return true end}).key),
                area = G.pack_cards,
                skip_materialize = true,
            }
        else
            phases = {  
                set = "BasePhases", 
                area = G.pack_cards,
                skip_materialize = true,
            }
        end
        return phases
    end,
}

SMODS.Booster{
    key = 'lunar_normal_2',
    atlas = 'nicboosters',
    pos = {x = 1, y = 1},
    discovered = false,
    weight = 0.5,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Phases',
    group_key = "k_nic_lunar_pack",

    ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = G.C.NIC_PHASES })
    end,

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { key = "nic_specialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,
    
    create_card = function(self, card)
        local phases
        if pseudorandom('moonchange', G.GAME.phases_numerator, G.GAME.phases_denominator) == G.GAME.phases_numerator then
            phases = {
                key = (pseudorandom_element(G.P_CENTER_POOLS.SpecialPhases, 'specialphases', {in_pool = function() return true end}).key),
                area = G.pack_cards,
                skip_materialize = true,
            }
        else
            phases = {  
                set = "BasePhases", 
                area = G.pack_cards,
                skip_materialize = true,
            }
        end
        return phases
    end,
}

SMODS.Booster{
    key = 'lunar_jumbo',
    atlas = 'nicboosters',
    pos = {x = 2, y = 1},
    discovered = false,
    weight = 0.5,
    cost = 6,
    config = {
        extra = 5,
        choose = 1
    },
    kind = 'Phases',
    group_key = "k_nic_lunar_pack",

    ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = G.C.NIC_PHASES })
    end,

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { key = "nic_specialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,

    create_card = function(self, card)
        local phases
        if pseudorandom('moonchange', G.GAME.phases_numerator, G.GAME.phases_denominator) == G.GAME.phases_numerator then
            phases = {
                key = (pseudorandom_element(G.P_CENTER_POOLS.SpecialPhases, 'specialphases', {in_pool = function() return true end}).key),
                area = G.pack_cards,
                skip_materialize = true,
            }
        else
            phases = {  
                set = "BasePhases", 
                area = G.pack_cards,
                skip_materialize = true,
            }
        end
        return phases
    end,
}

SMODS.Booster{
    key = 'lunar_mega',
    atlas = 'nicboosters',
    pos = {x = 3, y = 1},
    discovered = false,
    weight = 0.125,
    cost = 6,
    config = {
        extra = 5,
        choose = 2
    },
    kind = 'Phases',
    group_key = "k_nic_lunar_pack",

    ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = G.C.NIC_PHASES })
    end,

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { key = "nic_specialphases", set = "Other", vars = { G.GAME.phases_numerator, G.GAME.phases_denominator, } }
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,

    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('c88444'), HEX('1e316b') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,

    create_card = function(self, card)
        local phases
        if pseudorandom('moonchange', G.GAME.phases_numerator, G.GAME.phases_denominator) == G.GAME.phases_numerator then
            phases = {
                key = (pseudorandom_element(G.P_CENTER_POOLS.SpecialPhases, 'specialphases', {in_pool = function() return true end}).key),
                area = G.pack_cards,
                skip_materialize = true,
            }
        else
            phases = {  
                set = "BasePhases", 
                area = G.pack_cards,
                skip_materialize = true,
            }
        end
        return phases
    end,
}