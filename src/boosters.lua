SMODS.Atlas{ -- Boosters
    key = 'nicboosters',
    path = 'nicboosters.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'teto_booster',
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
        ease_background_colour({ new_colour = HEX("e15d73")})
    end,
    loc_vars = function(self,info_queue,center)
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
    key = 'vase_booster1',
    atlas = 'nicboosters',
    pos = {x = 0, y = 1},
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
        ease_background_colour({ new_colour = HEX("96603f")})
    end,
    loc_vars = function(self,info_queue,center)
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
    key = 'vase_booster2',
    atlas = 'nicboosters',
    pos = {x = 1, y = 1},
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
        ease_background_colour({ new_colour = HEX("408c2f")})
    end,
    loc_vars = function(self,info_queue,center)
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

--[[SMODS.Booster{
    key = 'tools_booster',
    atlas = 'nicboosters',
    pos = {x = 2, y = 1},
    discovered = false,
    weight = 0.5,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Tools',
    group_key = "k_tools_pack",
    select_card = 'consumeables',
    ease_background_colour = function(self)
        ease_background_colour({ new_colour = HEX("92431c")})
    end,
    loc_vars = function(self,info_queue,center)
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
}]]

SMODS.Booster{
    key = 'lunar_booster1',
    atlas = 'nicboosters',
    pos = {x = 0, y = 2},
    discovered = false,
    weight = 0.5,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Phases',
    group_key = "k_nic_lunar_pack",
    select_card = 'consumeables',
    ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.NIC_PHASES})
    end,
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,
    create_card = function(self, card)
        return { 
            set = "BasePhases", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}

SMODS.Booster{
    key = 'lunar_booster2',
    atlas = 'nicboosters',
    pos = {x = 1, y = 2},
    discovered = false,
    weight = 0.5,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Phases',
    group_key = "k_nic_lunar_pack",
    select_card = 'consumeables',
    ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.NIC_PHASES})
    end,
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,
    create_card = function(self, card)
        return { 
            set = "BasePhases", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}