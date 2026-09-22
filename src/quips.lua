-- Win

SMODS.JimboQuip{
    key = 'nic_teto_word_of_the_day_win_1',
    type = 'win',
    extra = { 
        center = 'j_nic_teto_word_of_the_day', 
        sound = 'nic_tetowordoftheday',
        times = 1,
        particle_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") }, 
        materialize_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") } 
    },
    filter = function()
        if next(SMODS.find_card('j_nic_teto_word_of_the_day')) then
            return true, { weight = 100 }
        end
        return false
    end,
}

SMODS.JimboQuip{
    key = 'pearto_win_1',
    type = 'win',
    extra = { 
        center = 'j_nic_pearto', 
        particle_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") }, 
        materialize_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") } 
    },
    filter = function()
        if next(SMODS.find_card('j_nic_pearto')) then
            return true, { weight = 100 }
        end
        return false
    end,
}

-- Loss

SMODS.JimboQuip{
    key = 'nic_teto_word_of_the_day_loss_1',
    type = 'loss',
    extra = { 
        center = 'j_nic_teto_word_of_the_day', 
        sound = 'nic_tetowordoftheday',
        times = 1,
        particle_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") }, 
        materialize_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") } 
    },
    filter = function()
        if next(SMODS.find_card('j_nic_teto_word_of_the_day')) then
            return true, { weight = 100 }
        end
        return false
    end,
}

SMODS.JimboQuip{
    key = 'death_lose_1',
    type = 'loss',
    extra = { 
        center = 'j_nic_death', 
        sound = 'nic_deathwhistle',
        times = 1,
        pitch = 1,
        particle_colours = { HEX("830000"), HEX("830000"), HEX("830000") }, 
        materialize_colours = { HEX("000000"), HEX("000000"), HEX("000000") } 
    },
    filter = function()
        if next(SMODS.find_card('j_nic_death')) then
            return true, { weight = 100 }
        end
        return false
    end,
}