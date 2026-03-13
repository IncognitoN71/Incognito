SMODS.Atlas{ -- STS Mult Text
    key = "nicstsmulttext",
    path = "sts/nicstsmulttext.png",
    px = 71,
    py = 7,
}

SMODS.Atlas{ -- STS Summon Text
    key = "nicstssummontext",
    path = "sts/nicstssummontext.png",
    px = 71,
    py = 7,
}

local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.osty_hp = 0
    return ret
end

SMODS.draw_ignore_keys.sprite = true

-- Mult
local function mult_sprite(canvas, x, y, pos) -- (Ruby Entropy)
    local quad = love.graphics.newQuad(71 * pos.x, 7 * pos.y, 71, 7, 142, 84)
    canvas:renderTo(function() love.graphics.draw(G.ASSET_ATLAS["nic_nicstsmulttext"].image, quad, x, y, 0, 1, 1, 0, 0) end)
end

SMODS.DrawStep({ -- Unleash
	key = "unleash",
	order = 25,
	func = function(self)
        local card = self.config.center_key
        if card ~= "j_nic_unleash" or not G.P_CENTERS[card].discovered or not G.P_CENTERS[card].unlocked then return end

        if not self.children.sprite then 
            self.children.sprite = SMODS.CanvasSprite(
                {X=0, Y=0, W=71, H=95, canvasW=71, canvasH=95, canvasScale=1}
            )
        end

        local sprite = self.children.sprite
        love.graphics.push()
        love.graphics.origin()
        sprite.canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
        local str = number_format(math.floor(self.ability.extra.total)):gsub("%,", "")
        local len = string.len(str)
        mult_sprite(sprite.canvas, (2 * (len - 1)) - 20, 64, {x = 0, y = math.min(len-1, 10)})
        local char_map = {
            ["0"] = {x = 1, y = 0},
            ["1"] = {x = 1, y = 1},
            ["2"] = {x = 1, y = 2},
            ["3"] = {x = 1, y = 3},
            ["4"] = {x = 1, y = 4},
            ["5"] = {x = 1, y = 5},
            ["6"] = {x = 1, y = 6},
            ["7"] = {x = 1, y = 7},
            ["8"] = {x = 1, y = 8},
            ["9"] = {x = 1, y = 9},
            ["e"] = {x = 1, y = 10},
            ["."] = {x = 1, y = 11},
        }
        for i = 1, len do
            mult_sprite(sprite.canvas, (2 * (len - 1) - 4 * ((len - i))) - 20, 64, char_map[str:sub(i,i)] or {x = 999, y = 999})
        end
        love.graphics.pop()

        sprite.role.draw_major = self
        sprite:draw_shader("dissolve", nil, nil, nil, self.children.center)
	end,
	conditions = { vortex = false, facing = "front" },
})

SMODS.DrawStep({ -- The Scythe
	key = "thescythe",
	order = 25,
	func = function(self)
        local card = self.config.center_key
        if card ~= "j_nic_thescythe" or not G.P_CENTERS[card].discovered or not G.P_CENTERS[card].unlocked then return end

        if not self.children.sprite then 
            self.children.sprite = SMODS.CanvasSprite(
                {X=0, Y=0, W=71, H=95, canvasW=71, canvasH=95, canvasScale=1}
            )
        end

        local sprite = self.children.sprite
        love.graphics.push()
        love.graphics.origin()
        sprite.canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
        local str = number_format(math.floor(self.ability.extra.mult)):gsub("%,", "")
        local len = string.len(str)
        mult_sprite(sprite.canvas, (2 * (len - 1)) - 20, 64, {x = 0, y = math.min(len-1, 10)})
        local char_map = {
            ["0"] = {x = 1, y = 0},
            ["1"] = {x = 1, y = 1},
            ["2"] = {x = 1, y = 2},
            ["3"] = {x = 1, y = 3},
            ["4"] = {x = 1, y = 4},
            ["5"] = {x = 1, y = 5},
            ["6"] = {x = 1, y = 6},
            ["7"] = {x = 1, y = 7},
            ["8"] = {x = 1, y = 8},
            ["9"] = {x = 1, y = 9},
            ["e"] = {x = 1, y = 10},
            ["."] = {x = 1, y = 11},
        }
        for i = 1, len do
            mult_sprite(sprite.canvas, (2 * (len - 1) - 4 * ((len - i))) - 20, 64, char_map[str:sub(i,i)] or {x = 999, y = 999})
        end
        love.graphics.pop()

        sprite.role.draw_major = self
        sprite:draw_shader("dissolve", nil, nil, nil, self.children.center)
	end,
	conditions = { vortex = false, facing = "front" },
})

-- Summon
local function summon_sprite(canvas, x, y, pos) -- (Ruby Entropy)
    local quad = love.graphics.newQuad(71 * pos.x, 7 * pos.y, 71, 7, 142, 84)
    canvas:renderTo(function() love.graphics.draw(G.ASSET_ATLAS["nic_nicstssummontext"].image, quad, x, y, 0, 1, 1, 0, 0) end)
end

SMODS.DrawStep({ -- Dirge
	key = "dirge",
	order = 25,
	func = function(self)
        local card = self.config.center_key
        if card ~= "j_nic_dirge" or not G.P_CENTERS[card].discovered or not G.P_CENTERS[card].unlocked then return end

        if not self.children.sprite then 
            self.children.sprite = SMODS.CanvasSprite(
                {X=0, Y=0, W=71, H=95, canvasW=71, canvasH=95, canvasScale=1}
            )
        end

        local sprite = self.children.sprite
        love.graphics.push()
        love.graphics.origin()
        sprite.canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
        local str = number_format(math.floor(self.ability.extra.total)):gsub("%,", "")
        local len = string.len(str)
        summon_sprite(sprite.canvas, (2 * (len - 1)) - 12, 76, {x = 0, y = math.min(len-1, 10)})
        local char_map = {
            ["0"] = {x = 1, y = 0},
            ["1"] = {x = 1, y = 1},
            ["2"] = {x = 1, y = 2},
            ["3"] = {x = 1, y = 3},
            ["4"] = {x = 1, y = 4},
            ["5"] = {x = 1, y = 5},
            ["6"] = {x = 1, y = 6},
            ["7"] = {x = 1, y = 7},
            ["8"] = {x = 1, y = 8},
            ["9"] = {x = 1, y = 9},
            ["e"] = {x = 1, y = 10},
            ["."] = {x = 1, y = 11},
        }
        for i = 1, len do
            summon_sprite(sprite.canvas, (2 * (len - 1) - 4 * ((len - i))) - 12, 76, char_map[str:sub(i,i)] or {x = 999, y = 999})
        end
        love.graphics.pop()

        sprite.role.draw_major = self
        sprite:draw_shader("dissolve", nil, nil, nil, self.children.center)
	end,
	conditions = { vortex = false, facing = "front" },
})