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
assert(SMODS.load_file("src/enhancements.lua"))()
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

-- STS
assert(SMODS.load_file("src/sts/jokers.lua"))()
assert(SMODS.load_file("src/sts/functions.lua"))()

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

-- Hyperfixation
if Hyperfixation then
    SMODS.load_file("src/crossmod/hyperfixation.lua")()
    if Hyperfixation.hypercross then
        if type(Hyperfixation) == "table" and type(Hyperfixation.hypercross) == "function" then
            Hyperfixation.hypercross('Incognito', 'j_nic_technoblade', 'j_nic_faketechnoblade', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_machinedramon', 'j_nic_fakemachinedramon', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_button', 'j_nic_fakebutton', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_slycooper', 'j_nic_fakeslycooper', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_stalagmite', 'j_nic_fakestalagmite', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonacookie', 'j_nic_fakedalgonacookie', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonacircle', 'j_nic_fakedalgonacircle', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonatriangle', 'j_nic_fakedalgonatriangle', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonastar', 'j_nic_fakedalgonastar', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonaumbrella', 'j_nic_fakedalgonaumbrella', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_humantorch', 'j_nic_fakehumantorch', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_invisiblewoman', 'j_nic_fakeinvisiblewoman', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_thething', 'j_nic_fakethething', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_misterfantastic', 'j_nic_fakemisterfantastic', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_incognito', 'j_nic_fakeincognito', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_crazytaxi', 'j_nic_fakecrazytaxi', false)
        end
    end
end

-- MoreFluff (notMario)
if MoreFluff then -- Main
    SMODS.load_file("src/crossmod/morefluff/main.lua")()
elseif FLUFF then -- Rewritten
    SMODS.load_file("src/crossmod/morefluff/rewritten.lua")()
end

-- Alloy (Corobo)
if ALLOY then
    SMODS.load_file("src/crossmod/alloy.lua")()
end

-- LobotomyCorp (Myst)
if next(SMODS.find_mod("LobotomyCorp")) then
    SMODS.load_file("src/crossmod/lobotomycorp.lua")()
end

-- Bad Director (Niko)
if next(SMODS.find_mod("baddirector")) then
    SMODS.load_file("src/crossmod/baddirector.lua")()
end

-- Entropy (Ruby)
if next(SMODS.find_mod("entr")) then
    SMODS.load_file("src/crossmod/entropy.lua")()
end

-- JokerDisplay
if JokerDisplay then
    SMODS.load_file("src/crossmod/jokerdisplay.lua")()
end

-- Partner
if next(SMODS.find_mod("partner")) then
    SMODS.load_file("src/crossmod/partners.lua")()
end