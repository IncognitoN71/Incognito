Incognito = SMODS.current_mod
assert(SMODS.load_file("config.lua"))()

SMODS.Atlas { -- Icon
  key = "modicon",
  px = 34,
  py = 34,
  path = "nicicon.png" 
}

-- Base Stuff

assert(SMODS.load_file("src/jokers.lua"))()

assert(SMODS.load_file("src/backs.lua"))()
assert(SMODS.load_file("src/boosters.lua"))()
assert(SMODS.load_file("src/challenges.lua"))()
assert(SMODS.load_file("src/draw.lua"))()
assert(SMODS.load_file("src/functions.lua"))()
assert(SMODS.load_file("src/music.lua"))()
assert(SMODS.load_file("src/quips.lua"))()
assert(SMODS.load_file("src/rarity.lua"))()
assert(SMODS.load_file("src/seals.lua"))()
assert(SMODS.load_file("src/sounds.lua"))()
assert(SMODS.load_file("src/stickers.lua"))()
assert(SMODS.load_file("src/spectrals.lua"))()
assert(SMODS.load_file("src/tags.lua"))()
assert(SMODS.load_file("src/tarots.lua"))()
assert(SMODS.load_file("src/texturedeck.lua"))()
assert(SMODS.load_file("src/ui.lua"))()

-- Teto
assert(SMODS.load_file("src/teto/jokers.lua"))()

-- Pvz
assert(SMODS.load_file("src/pvz/functions.lua"))()
assert(SMODS.load_file("src/pvz/jokers.lua"))()
assert(SMODS.load_file("src/pvz/zengarden.lua"))()

-- Phases
assert(SMODS.load_file("src/phases/functions.lua"))()
assert(SMODS.load_file("src/phases/basephases.lua"))()
assert(SMODS.load_file("src/phases/specialphases.lua"))()

-- Poopoo

if Incognito.config.not_finished then
	SMODS.load_file("src/scrapped/scrapped.lua")()
end

-- MoreFluff

if MoreFluff then
    SMODS.load_file("src/crossmod/morefluff.lua")()
end

-- Alloy

if ALLOY then
    SMODS.load_file("src/crossmod/alloy.lua")()
end

-- LobotomyCorp

if next(SMODS.find_mod("LobotomyCorp")) then
    SMODS.load_file("src/crossmod/lobotomycorp.lua")()
end

-- Bad Director

if next(SMODS.find_mod("baddirector")) then
    SMODS.load_file("src/crossmod/baddirector.lua")()
end

-- Ijiraq

if Hyperfixation then
    SMODS.load_file("src/crossmod/hyperfixation.lua")()
end

-- JokerDisplay

if JokerDisplay then
    SMODS.load_file("src/crossmod/jokerdisplay.lua")()
end

-- Partner

if next(SMODS.find_mod("partner")) then
    SMODS.load_file("src/crossmod/partners.lua")()
end