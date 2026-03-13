return {
    descriptions = {
        Back={
            b_nic_plants = {
                name = "Plants Deck",
                text = {
                    "Start run with",
                    "{C:nic_plants,T:j_nic_crazydave}#1#{} joker",
                    "and {C:attention}2{} copies of",
                    "{C:nic_plants,T:c_nic_mysteryvase}#2#{} Card"
                }
            },
            b_nic_tidal = {
                name = "Tidal Deck",
                text = {
                    "Start run with the",
                    "{C:tarot,T:v_crystal_ball}#1#{} voucher{},",
                    "{C:nic_phases,T:c_nic_newmoon}#2#{}, and",
                    "{C:tarot,T:c_high_priestess}#3#"
                }
            }
        },
        Blind={},
        Edition={},
        Enhanced={
            m_nic_soul = {
                name = "Soul Card",
                text = {
                    "When {C:attention}discarded{},",
                    "draw #1# cards and",
                    "{C:red,E:2}self destructs{}.",
                    "{C:inactive,s:0.8}no rank or suit"
                }
            }
        },
        Joker = {
            j_nic_technoblade = {
                name = "Technoblade",
                text = {
                    "Prevents Death {C:attention}#2#{C:inactive} [#1#]{} times",
                    "if chips scored are at least",
                    "{C:attention}#3#%{} of required chips",
                    "{C:inactive,s:0.8}Increases % by 25% every death",
                    "{s:1.1,C:red,E:2}self destructs when [0]",
                }
            },
            j_nic_machinedramon = {
                name = {
                    "Machinedramon",
                    "{C:black,X:white,s:0.6}MEGA{s:0.6}/{C:black,X:white,s:0.6}VIRUS{s:0.6}/{C:black,X:white,s:0.6}MACHINE"
                },
                text = {
                    {"{X:blue,C:white,s:0.8}When`````Attacking",
                    "{C:attention}Steel Cards{} get destroyed,",
                    "gain {C:mult}+#3#{} Mult and {X:mult,C:white}X#4#{} Mult"},
                    {"{X:blue,C:white,s:0.8}End`````of`````Attack",
                    "{C:mult}+#1#{} Mult and {X:mult,C:white}X#2#{} Mult"},
                    {"{X:blue,C:white,s:0.8}End`````of`````Your`````Turn",
                    "non {C:attention}Enhanced Cards{} held in",
                    "hand turn into {C:attention}Steel Cards"},
                }
            },
            j_nic_button = {
                name = "Button",
                text = {
                    "When {C:attention}Clicked{} or {C:attention}Space is",
                    "{C:attention}Pressed{}, gain {X:mult,C:white}X#4#{} Mult and",
                    "has a {C:green}#1# in #2#{} chance that",
                    "this card is destroyed",
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)",
                }
            },
            j_nic_slycooper = {
                name = "Sly Cooper",
                text = {
                    "When {C:attention}Blind{} is defeated, Buy",
                    "{C:attention}One Item{} for {C:green}Free{} in the",
                    "{C:attention}Shop{}, {C:green}#1# in #2#{} chance you get",
                    "{C:red}Caught{} and {C:attention}Pay Double",
                    "{C:inactive}(Currently: #3#)",
                }
            },
            j_nic_stalagmite = {
                name = "Stalagmite",
                text = {
                    {"Scoring {C:attention}Stone{} cards turn {C:dark_edition}Negative,",
                    "Scoring {C:dark_edition}Negative {C:attention}Stone{} cards gets",
                    "destroyed and gain {C:chips}+#2#{} Chips"},
                    {"{C:chips}+#1#{} Chips for each",
                    "{C:attention}Stone{} card held in hand",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"},
                }
            },
            j_nic_dalgonacookie = {
                name = "Dalgona Cookie",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "it becomes {C:attention}1{} of the 4",
                    "{C:attention}Opened Dalgona Cookies",
                }
            },
            j_nic_dalgonacircle = {
                name = "Dalgona Circle",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}High Card{}, {C:attention}Pair{}, or {C:attention}Two Pair",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.8}This Joker breaks if failed {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },
            j_nic_dalgonatriangle = {
                name = "Dalgona Triangle",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}3oak{}, {C:attention}Straight{}, or {C:attention}Flush",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.8}This Joker breaks if failed {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },
            j_nic_dalgonastar = {
                name = "Dalgona Star",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}Full House{}, {C:attention}4oak{}, or {C:attention}Straight Flush",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.8}This Joker breaks if failed {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },
            j_nic_dalgonaumbrella = {
                name = "Dalgona Umbrella",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}5oak{}, {C:attention}Flush House{}, or {C:attention}Flush Five",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.8}This Joker breaks if failed {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },
            j_nic_humantorch = {
                name = "Human Torch",
                text = {
                    "If {C:attention}first played{} hand is a {C:attention}Four",
                    "{C:attention}of a Kind{} with exactly {C:attention}4{} cards,",
                    "level up the {C:attention}hand{} by {C:attention}#1#{}, increase",
                    "the amount by {C:attention}#2#{}, and destroy",
                    "a {C:attention}random played card",
                }
            },
            j_nic_invisiblewoman = {
                name = "Invisible Woman",
                text = {
                    "If {C:attention}first played{} hand is a",
                    "{C:attention}Four of a Kind{} with exactly {C:attention}4",
                    "cards, turn all cards into glass",
                }
            },
            j_nic_thething = {
                name = "The Thing",
                text = {
                    {"When round begins, add",
                    "{C:attention}#1# Stone{} cards with a",
                    "random {C:attention}seal{} to your deck"},
                    {"If {C:attention}first played{} hand is a",
                    "{C:attention}Four of a Kind{} with exactly {C:attention}4",
                    "cards, increase the amount",
                    "of {C:attention}Stone{} cards by {C:attention}#2#"},
                }
            },
            j_nic_misterfantastic = {
                name = "Mister Fantastic",
                text = {
                    "All {C:attention}played hands{} with exactly {C:attention}4",
                    "cards are considered {C:attention}Four of a Kind",
                    "and the {C:attention}cards{} will count when played",
                }
            },
            j_nic_incognito = {
                name = "Incognito",
                text = {
                    {"This Joker gains {X:mult,C:white}X#3#{} Mult when a",
                    "non {C:spades}Spade{} card is destroyed",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)"},
                    {"Each non {C:spades}Spade{} card held in hand",
                    "has a {C:green}#1# in #2#{} chance to be destroyed",
                    "{C:spades}Spade{} cards held in hand gives Mult"},
                }
            },
            j_nic_crazytaxi = {
                name = "Crazy Taxi",
                text = {
                    "Earn {C:money}$#1#{} and increases by {C:money}$#2#",
                    "for each scored {C:attention}#4#{}, resets",
                    "back to {C:money}$#3#{} if {C:attention}scored different{},",
                    "rank changes every round",
                },
            },
            j_nic_strawberrycake = {
                name = "Strawberry Cake",
                text = {
                    {"{C:attention}First hand{} of round turns all",
                    "{C:attention}played cards{} into {C:hearts}Hearts"},
                    {"Each {C:attention}card{} in played {C:attention}Flush",
                    "after {C:attention}first hand{} permanently",
                    "gains {C:mult}+#1#{} Mult when scored"},
                }
            },
            j_nic_ratiotechnique = {
                name = "Ratio Technique",
                text = {
                    "Card located at the {C:attention}7:3{} ratio",
                    "mark {C:attention}held in hand{} gets destroyed",
                    "when the {C:attention}first hand is played",
                    "{C:inactive,s:0.8}| - | - | - | - | - | - | - o - | - | - |",
                    "{C:inactive}(Currently #1##2#)",
                }
            },
            j_nic_invertedspearofheaven = {
                name = "Inverted Spear of Heaven",
                text = {
                    {"When {C:attention}Blind{} is selected, destroy adjacent",
                    "Jokers and gain {X:mult,C:white}X0.5{} Mult for each",
                    "{C:inactive,s:0.8}This also includes Enternals",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"},
                    {"If Both Jokers get destroyed in",
                    "{C:attention}Boss Blind{}, disable {C:attention}Boss Blind{} effects"},
                }
            },
            j_nic_cyan = {
                name = "Cyan",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "{X:attention,C:white}X#1#{} Blind Requirement and",
                    "create {C:attention}1 {C:spectral}Black Hole",
                    "{C:inactive}(Must have room",
                    "{C:inactive}or it won't activate)",
                }
            },
            j_nic_astromancer = {
                name = "Astromancer",
                text = {
                    "Create a {C:planet}Planet{} card",
                    "when {C:attention}Blind{} is selected",
                    "{C:inactive}(Must have room)",
                }
            },
            j_nic_cartonomer = {
                name = "Cartonomer",
                text = {
                    "All {C:tarot}Tarot{} cards and",
                    "{C:tarot}Arcana Packs{} in",
                    "the shop are {C:attention}free",
                },
            },
            j_nic_tierlist = {
                name = "Tierlist",
                text = {
                    "Add rank of first played",
                    "{C:attention}number{} card to Mult",
                    "Minus rank of last played",
                    "{C:attention}number{} card to Mult",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                }
            },
            j_nic_scenario = {
                name = "Scenario",
                text = {
                    "Earn {C:money}$5{} when you beat",
                    "a {C:attention}Blind{} with at least",
                    "one {V:1}#1#{} Joker",
                    "{C:inactive,s:0.8}This Joker doesn't count and",
                    "{C:inactive,s:0.8}Rarity changes when successful",

                }
            },
            j_nic_mending = {
                name = "Mending",
                text = {
                    "Any {C:attention}playing card",
                    "{C:red}destroyed{} gets copied",
                    "into the discard pile",
                }
            },
            j_nic_calligramjoker = {
                name = "Calligram Joker",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "{C:attention}J, O, K, E, R{} in",
                    "adjacent Joker's name",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                }
            },
            j_nic_cloverpit = {
                name = "Clover Pit",
                text = {
                    "When {C:attention}Clicked{} or {C:attention}Space is",
                    "{C:attention}Pressed{}, spend {C:money}$#1#{} and get",
                    "between {C:mult}#2#{} to {C:mult}#3#{} Mult",
                    "{C:inactive}(Currently {C:mult}#4##5#{C:inactive} Mult)",
                    "{C:inactive,s:0.8}Value doubles after {C:attention,s:0.8}Boss Blind",
                    "{C:inactive,s:0.8}and current Mult resets",
                }
            },
            j_nic_jokrle = {
                name = "Jokrle",
                text = {
                    {"This Joker gains {C:mult}+#32#{} Mult per",
                    "remaining guess when solved",
                    "{C:inactive}(Currently {C:mult}+#31#{C:inactive} Mult)"},
                    {"{V:1}[#1#]{} {V:2}[#2#]{} {V:3}[#3#]{} {V:4}[#4#]{} {V:5}[#5#]",
                    "{V:6}[#6#]{} {V:7}[#7#]{} {V:8}[#8#]{} {V:9}[#9#]{} {V:10}[#10#]",
                    "{V:11}[#11#]{} {V:12}[#12#]{} {V:13}[#13#]{} {V:14}[#14#]{} {V:15}[#15#]",
                    "{V:16}[#16#]{} {V:17}[#17#]{} {V:18}[#18#]{} {V:19}[#19#]{} {V:20}[#20#]",
                    "{V:21}[#21#]{} {V:22}[#22#]{} {V:23}[#23#]{} {V:24}[#24#]{} {V:25}[#25#]",
                    "{V:26}[#26#]{} {V:27}[#27#]{} {V:28}[#28#]{} {V:29}[#29#]{} {V:30}[#30#]",
                    "{C:inactive,s:0.8}Answer: {V:31,s:0.8}#33#"},
                }
            },
            j_nic_solareclipse = {
                name = "Solar Eclipse",
                text = {
                    {"Scored based on",
                    "most used {C:tarot}Tarot{},",
                    "If tied uses both"},
                    {"Gains {C:mult}+#3#{} Mult every",
                    "time {C:tarot}The Sun{} is used",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"},
                    {"Gains {C:chips}+#4#{} Chips every",
                    "time {C:tarot}The Moon{} is used",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"},
                }
            },
            j_nic_invert = {
                name = "Invert",
                text = {
                    {"This Joker increases hand size when a",
                    "{C:dark_edition}Negative {C:spades}Spade{} card is destroyed",
                    "{C:inactive}(Currently {C:attention}+#3#{C:inactive} Hand size)",},
                    {"Each {C:spades}Spade{} card held in hand",
                    "has a {C:green}#1# in #2#{} chance to be {C:dark_edition}Negative",
                    "{C:spades}Spade{} cards played get destroyed"},
                }
            },
            j_nic_death = {
                name = "Death",
                text = {
                    "Each played {C:attention}9{} gets",
                    "destroyed and creates",
                    "a {C:dark_edition}Negative {C:tarot}Death",
                }
            },
            j_nic_cuphead = {
                name = "Cuphead",
                text = {
                    {" Each played {C:hearts}Heart{} cards ",
                    "increases {C:attention}Super Meter",
                    "{C:inactive}Super Meter: {V:1}#1# {V:2}#2# {V:3}#3# {V:4}#4# {V:5}#5#"},
                    {"Played hand that doesn't",
                    "contain {C:hearts}Heart{} cards",
                    "uses the {C:attention}Super Meter"},
                    {"{C:hearts}Extra Parry{} increase",
                    "Mult by {C:mult}+#8#{} Mult",
                    "{C:inactive}Each EX does {C:mult}+#6#{C:inactive} Mult",
                    "{C:inactive}SUPER EX does {C:mult}+#7#{C:inactive} Mult"},
                }
            },
            j_nic_mugman = {
                name = "Mugman",
                text = {
                    {" Each played {C:clubs}Club{} cards ",
                    "increases {C:attention}Super Meter",
                    "{C:inactive}Super Meter: {V:1}#1# {V:2}#2# {V:3}#3# {V:4}#4# {V:5}#5#"},
                    {"Played hand that doesn't",
                    "contain {C:clubs}Club{} cards",
                    "uses the {C:attention}Super Meter"},
                    {"{C:clubs}Extra Parry{} increase",
                    "Chips by {C:chips}+#8#{} Chips",
                    "{C:inactive}Each EX does {C:chips}+#6#{C:inactive} Chips",
                    "{C:inactive}SUPER EX does {C:chips}+#7#{C:inactive} Chips"},
                }
            },
            j_nic_selenologist = {
                name = "Selenologist",
                text = {
                    "Create a {C:nic_phases}Phases{} card",
                    "at end of round",
                    "{C:inactive}(Must have room)",
                }
            },
            j_nic_lunation = {
                name = "Lunation",
                text = {
                    "This Joker gains",
                    "{X:chips,C:white}X#2#{} Chips every time",
                    "a {C:nic_phases}Phases{} card is used",
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                }
            },
            j_nic_unleash = {
                name = "Unleash",
                text = {
                    "{C:attention}Osty{} deals {C:mult}+#1#{} Mult. Plus",
                    "Mult equal to {C:attention}Osty's{} HP.",
                }
            },
            j_nic_dirge = {
                name = "Dirge",
                text = {
                    "{C:attention}Summon {C:nic_necrobinder}#1#{} and add one",
                    "{C:nic_soul}Soul Card{} to deck per {C:attention}hand",
                    "{C:attention}remaining{} at end of round.",
                    "{C:inactive}(Currently {C:nic_necrobinder}+#2#{C:inactive} Summon)",
                }
            },
            j_nic_callofthevoid = {
                name = "Call of the Void",
                text = {
                    "Start of your turn,",
                    "add one {C:attention}Enhanced card",
                    "into your {C:attention}hand{}.",
                }
            },
            j_nic_thescythe = {
                name = "The Scythe",
                text = {
                    "On {C:attention}first hand{}, {C:mult}+#1#{} Mult.",
                    "Gain {C:mult}+#2#{} Mult at end of round.",
                }
            },

            j_nic_identity = {
                name = "Identity",
                text = {
                    {"This Joker #1# {B:1,C:white}#2#{}#3#when a",
                    "{V:2}#4#{}#5#{C:spades}Spade{} card is destroyed",
                    "{C:inactive}(Currently {B:3,V:4}#6#{C:inactive} #7#)"},
                    {"Each #8#{C:spades}Spade{} card held in hand",
                    "has a {C:green}#14# in #15#{} chance to be {V:5}#9#",
                    "{V:6}#10#{}#11#{C:spades}Spade{} cards #12# #13#"},
                }
            },

            -- Teto

            j_nic_kasanejokto = {
                name = "Kasane Jokto",
                text = {
                    "{C:attention}Retrigger{} played {C:attention}4s",
                    "an additional {C:attention}#1#{} times",
                    "{C:inactive,s:0.8,E:1}Inspired By: Neato Jokers",
                }
            },
            j_nic_ambassadorteto = {
                name = "Ambassador Teto",
                text = {
                    "All cards held in hand",
                    "change {C:attention}suits{} in this order",
                    "{C:clubs}Clubs{} > {C:diamonds}Diamonds{} >",
                    "{C:spades}Spades{} > {C:hearts}Hearts{}",
                    "{C:inactive}(Stops at {C:hearts}Hearts{C:inactive})",
                    "{C:inactive,s:0.8,E:1} Song By: dada",
                }
            },
            j_nic_pear = {
                name = "Pear",
                text = {
                    "Level up the next {C:attention}#3#{C:inactive} [#2#]",
                    "played {C:attention}Pair{} by {C:attention}#1#{} and",
                    "then {C:red,E:2}self destructs",
                }
            }, 
            j_nic_pearto = {
                name = "Pearto",
                text = {
                    "Level up played {C:attention}Pair{} by {C:attention}#3#",
                    "{C:green}#1# in #2#{} chance this card",
                    "is destroyed at end of round",
                }
            },
            j_nic_doctorkidori = {
                name = "Doctor Kidori",
                text = {
                    "If this {C:attention}Joker{} is in",
                    "leftmost slot, all played",
                    "{C:attention}4s{} changes {C:dark_edition}Edition",
                    "{C:inactive,s:0.8,E:1}Song By: {C:inactive,f:5,s:0.8,E:1}原口沙輔",
                    "{C:inactive,s:0.8,E:1} Hako, Sasuke Haraguchi",
                }
            },
            j_nic_birdbrainteto = { 
                name = "Birdbrain Teto",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "per {C:attention}consecutive Pair",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.8,E:1}Song By: Jamie Paige",

                }
            }, 
            j_nic_tenebrerossosangueteto = { 
                name = "Tenebre Rosso Sangue Teto",
                text = {
                    "This Joker gains {C:money}$#1#{} for",
                    "each {C:hearts}Heart{} card destroyed",
                    "{C:inactive,s:0.8,E:1}Song By: Sandwich",
                }
            },
            j_nic_spokenforteto = { 
                name = "Spoken For Teto",
                text = {
                    "Each {C:nic_teto}Teto{} themed",
                    "{C:attention}Joker{} gives {X:red,C:white} X#1# {} Mult ",
                    "{C:inactive,s:0.8,E:1}Song By: FLAVOR FOLEY",
                }
            },
            j_nic_tetowordoftheday = { 
                name = "Teto Word Of The Day",
                text = {
                    "After {C:attention}#2# Blinds{}, sell",
                    "this card to {C:attention}Create",
                    "a random {C:nic_teto}Teto{} Joker",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)",
                }
            },
            j_nic_mesmerizerteto = { 
                name = "Mesmerizer Teto",
                text = {
                    "If leftmost {C:attention}Joker",
                    "is a {C:nic_teto}Teto{}, copy the",
                    "ability {C:attention}2{} times",
                    "{C:inactive,s:0.8,E:1}Song By: 32ki",
                }
            },
            j_nic_spamteto = {
                name = "[Spamteto]",
                text = {
                    "Earn {X:money,C:white}[ $#1#% ]{} of current",
                    "money at end of round",
                    "{C:inactive}(Cash out {C:money}$#2#{C:inactive})",
                    "{C:inactive,s:0.8} [Press F1 For] HELP",
                }
            },
            j_nic_tetoris = {
                name = "Tetoris",
                text = {
                    "Create a {C:tarot}Sun Tarot{} card",
                    "for every {C:attention}#2#{C:inactive} [#1#] {C:attention}hands{}",
                    "that contains {C:hearts}Hearts",
                    "{C:inactive}(Must have room)",
                    "{C:inactive,s:0.8,E:1}Song By: Hiiragi Magnetit",
                }
            },
            j_nic_minimumrageteto = {
                name = "Minimum Rage Teto",
                text = {
                    "Recent bought {C:attention}card cost",
                    "adds into current {C:mult}Mult{},",
                    "resets when any {C:attention}card{} is {C:attention}sold",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.8,E:1}Song By: MonochroMenace",
                }
            },
            j_nic_tetoterritory = {
                name = "Teto Territory",
                text = {
                    "When {C:attention}Boss Blind{} is selected,",
                    "a random non {C:nic_teto}Teto{} Joker", 
                    "turns into a {C:nic_teto}Teto{} Joker",
                    "{C:inactive,s:0.8} Food Jokers turn into Pears",
                    "{C:inactive,s:0.8,E:1}Song By: Oxi",
                }
            },
            j_nic_contradictionsteto = {
                name = "Contradictions Teto",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "all {C:hearts}Heart{} cards in your",
                    "deck changes {C:attention}Ranks",
                    "{C:inactive,s:0.8,E:1}Song By: darkbluecat",
                }
            },
            j_nic_pearbasket = {
                name = "Pear Basket",
                text = {
                    "This Joker stores a {C:nic_teto}Pear{} for",
                    "each {C:nic_teto}Pear{} card {C:attention}sold{}, level up",
                    "played {C:attention}Pair{} for each {C:nic_teto}Pear{} stored",
                    "{C:inactive}(Currently {C:nic_teto}#1#{C:inactive} Pears)",
                }
            },
            j_nic_keychainteto = {
                name = "Keychain Teto",
                text = {
                    "{C:attention}End of round{}, create",
                    "a free {C:nic_teto}#1#{}",
                    "{C:red,E:2}self destructs",
                }
            },
            j_nic_logoffteto = {
                name = "Log Off Teto",
                text = {
                    "Loses {X:mult,C:white} X#2# {} Mult per",
                    "non {C:hearts}Heart{} card scored",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                    "{C:inactive,s:0.8,E:1}Song By: Staircatte",
                }
            },
            j_nic_tetoos = {
                name = "TetOS 4.1",
                text = {
                    "Level up {C:attention}Pair{} every time",
                    "{C:tarot}The Wheel of Fortune",
                    "{C:red}unsuccessfully{} triggers",
                    "{C:inactive,s:0.8,E:1}Song By: Jamie Paige",
                }
            },
            j_nic_cadmiumcolors = {
                name = "Cadmium Colors",
                text = {
                    "{X:red,C:white} X#1# {} Mult if all cards",
                    "held in hand are",
                    "{C:hearts}Hearts{} or {C:diamonds}Diamonds",
                    "{C:inactive,s:0.8,E:1}Song By: Jamie Paige",
                }
            },

            -- Plants

            j_nic_crazydave = {
                name = "Crazy Dave",
                text = {
                    "Creates an {C:nic_plants}Area",
                    "for the {C:nic_plants}Plants",
                    "{C:inactive,s:0.8}End of every boss round",
                    "{C:inactive,s:0.8}create a free {C:nic_plants,s:0.8}#1#",
                }
            },
            j_nic_peashooter = {
                name = "Peashooter",
                text = {
                    "{C:chips}+#1#{} Chips",
                }
            },
            j_nic_sunflower = {
                name = "Sunflower",
                text = {
                    "Earn {C:money}$#1#{} for",
                    "each scored card",
                }
            },
            j_nic_cherrybomb = {
                name = "Cherry Bomb",
                text = {
                    "Destroys up to",
                    "{C:attention}#1#{} selected cards",
                    "{C:red,E:2}self destructs",
                }
            },
            j_nic_wallnut = {
                name = "Wall-nut",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:blue}+#1#{} Hand or {C:red}+#2#{} Discard"
                }
            },
            j_nic_potatomine = {
                name = "Potato Mine",
                text = {
                    "After {C:attention}#3#{C:inactive} [#2#]{} hands,",
                    "destroys up to",
                    "{C:attention}#1#{} selected cards",
                    "{C:red,E:2}self destructs",
                }
            },
            j_nic_snowpea = {
                name = "Snow Pea",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:blue}+#2#{} Hand",
                }
            },
            j_nic_chomper = {
                name = "Chomper",
                text = {
                    "Destroy {C:attention}#1#{} selected",
                    "card and gain {C:mult}+#5#{} Mult",
                    "every {C:attention}#3#{C:inactive} [#2#]{} hands",
                    "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)",
                }
            },
            j_nic_repeater = {
                name = "Repeater",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:attention}twice",
                }
            },
            j_nic_puffshroom = {
                name = "Puff-shroom",
                text = {
                    "{C:chips}+#1#{} Chips on {C:attention}final",
                    "{C:attention}played hand{} of round"
                }
            },
            j_nic_sunshroom = {
                name = "Sun-shroom",
                text = {
                    "Earn {C:money}$#3#{} for",
                    "each played hand,",
                    "every {C:attention}#2#{C:inactive} [#1#]{} hands,",
                    "double the {C:money}money{} earn",
                }
            },
            j_nic_fumeshroom = {
                name = "Fume-shroom",
                text = {
                    "{C:attention}First played hand{} decreases",
                    "Blind Requirement by {X:attention,C:white}#2#%{}",
                    "{C:chips}+#1#{} Chips for {C:attention}other hands",
                }
            },
            j_nic_gravebuster = {
                name = "Grave Buster",
                text = {
                    "Destroys up to {C:attention}#1#{} selected",
                    "{C:attention}Stone{} cards, each card",
                    "adds {C:attention}#2#{} random {C:attention}Enhanced",
                    "{C:attention}cards{} to your hand",
                    "{C:red,E:2}self destructs",
                }
            },
            j_nic_hypnoshroom = {
                name = "Hypno-shroom",
                text = {
                    "Create {C:attention}#2#{} random {C:attention}Enhanced",
                    "copies of up to {C:attention}#1#{} selected",
                    "cards in your hand",
                    "{C:inactive,s:0.8}doesn't work on stones",
                    "{C:red,E:2}self destructs",
                }
            },
            j_nic_scaredyshroom = {
                name = "Scaredy-shroom",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "However on {C:attention}final played",
                    "{C:attention}hand{} gain {C:blue}+#2#{} Hand",
                    "{C:inactive,s:0.8}only once",
                }
            },
            j_nic_iceshroom = {
                name = "Ice-shroom",
                text = {
                    "Enhances up to {C:attention}#1#",
                    "selected cards",
                    "into {C:attention}Glass Cards",
                    "{C:blue}+#2#{} Hand",
                    "{C:red,E:2}self destructs",
                }
            },
            j_nic_doomshroom = {
                name = "Doom-shroom",
                text = {
                    "Instantly win {C:attention}Blind{},",
                    "Destroy {C:attention}all cards",
                    "held in hand",
                    "{C:red,E:2}self destructs",
                }
            },

            -- Crossmod

            -- MoreFluff
            j_nic_triteto = {
                name = "Tri{C:nic_teto}Teto",
                text = {
                    "{C:attention}Retrigger{} played {C:attention}4s",
                    "if played hand is",
                    "a {C:attention}Three of a Kind",
                }
            },

            -- Alloy
            j_nic_tetorobo = {
                name = "{C:nic_teto}Teto{}Robo",
                text = {
                    {"Lose {C:attention}#3# {C:hearts}Happiness{} when",
                    "{C:attention}Blind{} is selected"},
                    {"{C:attention}End of round{} for every",
                    "{C:attention}10{} Pats given this round,",
                    "increases her {C:hearts}Happiness",
                    "{C:inactive,s:0.8}She'll get overstim if",
                    "{C:inactive,s:0.8}given more than 100"},
                    {"Click to Pet",
                    "{C:inactive,s:0.8}Pets Overall: #1#",
                    "{C:inactive,s:0.8}Pets this Round: #2#"},
                }
            },

            -- LobotomyCorp
            j_nic_mysteto = {
                name = "Mys{C:nic_teto}Teto{}",
                text = {
                    {"{C:attention}Played hand{} containing a {C:attention}Pair",
                    "upgrades level of played {C:attention}poker hand{}"},
                    {"{C:attention}Played hand{} containing a {C:attention}Pair",
                    "has a {C:green}#1# in #2#{} chance to",
                    "destroy all {C:attention}scored cards"},
                    {"If this Abnormality is {C:attention}sold{},",
                    "immediately {C:attention}lose{} the game",
                    "{C:inactive,s:0.8}chirp chirp?"},
                }
            },

            -- Bad Director
            j_nic_tetoxko = {
                name = "{C:nic_teto}Teto{}Xko",
                text = {
                    "{C:dark_edition}Misprint{} one random {C:attention}Joker",
                    "or card {C:attention}held in hand",
                    "for each {C:nic_teto}Teto{} Joker {C:inactive}(#1#)",
                    "at the end of round",
                }
            },

            -- Hyperfixation
            j_nic_faketechnoblade = {
                name = "Technoblade",
                text = {
                    "Prevents Death {C:attention}#2#{C:inactive} [#1#]{} times",
                    "if chips scored are at least",
                    "{C:attention}#3#%{} of required chips{C:hpfx_IjiGray}#5#{}",
                    "{C:inactive,s:0.8}#4# % by 25% every death",
                    "{s:1.1,C:red,E:2}self destructs when [0]",
                }
            },
            j_nic_faketechnoblade_alt = {
                name = "Technoblade{C:hpfx_IjiGray}...?{}",
                text = {
                    "Prevents Death {C:attention}#2#{C:inactive} [#1#]{} times",
                    "if chips scored are at least",
                    "{C:attention}#3#%{} of required chips{C:hpfx_IjiGray}#5#{}",
                    "{C:inactive,s:0.8}#4# % by 25% every death",
                    "{s:1.1,C:red,E:2}self destructs when [0]",
                }
            },

            j_nic_fakemachinedramon = {
                name = {
                    "Machinedramon",
                    "{C:black,X:white,s:0.6}MEGA{s:0.6}/{C:black,X:white,s:0.6}VIRUS{s:0.6}/{C:black,X:white,s:0.6}MACHINE"
                },
                text = {
                    {"{X:blue,C:white,s:0.8}When`````Attacking{C:hpfx_IjiGray} #6#{}",
                    "{C:attention}#5# Cards{} get destroyed,",
                    "gain {C:mult}+#3#{} Mult and {X:mult,C:white}X#4#{} Mult"},
                    {"{X:blue,C:white,s:0.8}End`````of`````Attack",
                    "{C:mult}+#1#{} Mult and {X:mult,C:white}X#2#{} Mult"},
                    {"{X:blue,C:white,s:0.8}End`````of`````Your`````Turn{C:hpfx_IjiGray} #6#{}",
                    "non {C:attention}Enhanced Cards{} held in",
                    "hand turn into {C:attention}#5# Cards"},
                }
            },
            j_nic_fakemachinedramon_alt = {
                name = {
                    "Machinedramon{C:hpfx_IjiGray}...?{}",
                    "{C:black,X:white,s:0.6}MEGA{s:0.6}/{C:black,X:white,s:0.6}VIRUS{s:0.6}/{C:black,X:white,s:0.6}MACHINE"
                },
                text = {
                    {"{X:blue,C:white,s:0.8}When`````Attacking{C:hpfx_IjiGray} #6#{}",
                    "{C:attention}#5# Cards{} get destroyed,",
                    "gain {C:mult}+#3#{} Mult and {X:mult,C:white}X#4#{} Mult"},
                    {"{X:blue,C:white,s:0.8}End`````of`````Attack",
                    "{C:mult}+#1#{} Mult and {X:mult,C:white}X#2#{} Mult"},
                    {"{X:blue,C:white,s:0.8}End`````of`````Your`````Turn{C:hpfx_IjiGray} #6#{}",
                    "non {C:attention}Enhanced Cards{} held in",
                    "hand turn into {C:attention}#5# Cards"},
                }
            },

            j_nic_fakebutton = {
                name = "Button",
                text = {
                    "When {C:attention}Clicked{} or {C:attention}Space is",
                    "{C:attention}Pressed{}, gain {X:mult,C:white}X#4#{} Mult and",
                    "has a {C:green}#1# in #2#{} chance that",
                    "this card is destroyed{C:hpfx_IjiGray}#5#{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)",
                }
            },
            j_nic_fakebutton_alt = {
                name = "Button{C:hpfx_IjiGray}...?{}",
                text = {
                    "When {C:attention}Clicked{} or {C:attention}Space is",
                    "{C:attention}Pressed{}, gain {X:mult,C:white}X#4#{} Mult and",
                    "has a {C:green}#1# in #2#{} chance that",
                    "this card is destroyed{C:hpfx_IjiGray}#5#{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)",
                }
            },

            j_nic_fakeslycooper = {
                name = "Sly Cooper",
                text = {
                    "When {C:attention}Blind{} is defeated, Buy",
                    "{C:attention}One Item{} for {V:1}#4#{} in the",
                    "{C:attention}Shop{}, {C:green}#1# in #2#{} chance you get",
                    "{C:red}Caught{} and {C:attention}Pay {V:2}#5#{C:hpfx_IjiGray}#6#{}",
                    "{C:inactive}(Currently: #3#)",
                }
            },
            j_nic_fakeslycooper_alt = {
                name = "Sly Cooper{C:hpfx_IjiGray}...?{}",
                text = {
                    "When {C:attention}Blind{} is defeated, Buy",
                    "{C:attention}One Item{} for {V:1}#4#{} in the",
                    "{C:attention}Shop{}, {C:green}#1# in #2#{} chance you get",
                    "{C:red}Caught{} and {C:attention}Pay {V:2}#5#{C:hpfx_IjiGray}#6#{}",
                    "{C:inactive}(Currently: #3#)",
                }
            },
            
            j_nic_fakestalagmite = {
                name = "Stalagmite",
                text = {
                    {"Scoring {C:attention}Stone{} cards turn {C:dark_edition}Negative,",
                    "Scoring {C:dark_edition}Negative {C:attention}Stone{} cards gets",
                    "destroyed and gain {C:chips}+#2#{} Chips"},
                    {"{C:chips}+#1#{} Chips for each",
                    "{C:attention}Stone{} card held in hand",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"},
                }
            },
            j_nic_fakestalagmite_alt = {
                name = "Stalagmite{C:hpfx_IjiGray}...?{}",
                text = {
                    {"Scoring {C:attention}Stone{} cards turn {C:dark_edition}Negative,",
                    "Scoring {C:dark_edition}Negative {C:attention}Stone{} cards gets",
                    "destroyed and gain {C:chips}+#2#{} Chips"},
                    {"{C:chips}+#1#{} Chips for each",
                    "{C:attention}Stone{} card held in hand",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"},
                }
            },

            j_nic_fakedalgonacookie = {
                name = "Dalgona Cookie",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "it becomes {C:attention}1{} of the 4",
                    "{C:attention}#1# Dalgona Cookies{C:hpfx_IjiGray}#2#{}",
                }
            },
            j_nic_fakedalgonacookie_alt = {
                name = "Dalgona Cookie{C:hpfx_IjiGray}...?{}",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "it becomes {C:attention}1{} of the 4",
                    "{C:attention}#1# Dalgona Cookies{C:hpfx_IjiGray}#2#{}",
                }
            },

            j_nic_fakedalgonacircle = {
                name = "Dalgona Circle",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}High Card{}, {C:attention}Pair{}, or {C:attention}Two Pair",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){C:hpfx_IjiGray}#6#{}",
                    "{C:inactive,s:0.8}This Joker breaks if #5# {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },
            j_nic_fakedalgonacircle_alt = {
                name = "Dalgona Circle{C:hpfx_IjiGray}...?{}",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}High Card{}, {C:attention}Pair{}, or {C:attention}Two Pair",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){C:hpfx_IjiGray}#6#{}",
                    "{C:inactive,s:0.8}This Joker breaks if #5# {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },

            j_nic_fakedalgonatriangle = {
                name = "Dalgona Triangle",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}3oak{}, {C:attention}Straight{}, or {C:attention}Flush",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){C:hpfx_IjiGray}#6#{}",
                    "{C:inactive,s:0.8}This Joker breaks if #5# {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },
            j_nic_fakedalgonatriangle_alt = {
                name = "Dalgona Triangle{C:hpfx_IjiGray}...?{}",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}3oak{}, {C:attention}Straight{}, or {C:attention}Flush",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){C:hpfx_IjiGray}#6#{}",
                    "{C:inactive,s:0.8}This Joker breaks if #5# {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },

            j_nic_fakedalgonastar = {
                name = "Dalgona Star",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}Full House{}, {C:attention}4oak{}, or {C:attention}Straight Flush",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){C:hpfx_IjiGray}#6#{}",
                    "{C:inactive,s:0.8}This Joker breaks if #5# {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },
            j_nic_fakedalgonastar_alt = {
                name = "Dalgona Star{C:hpfx_IjiGray}...?{}",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}Full House{}, {C:attention}4oak{}, or {C:attention}Straight Flush",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){C:hpfx_IjiGray}#6#{}",
                    "{C:inactive,s:0.8}This Joker breaks if #5# {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },

            j_nic_fakedalgonaumbrella = {
                name = "Dalgona Umbrella",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}5oak{}, {C:attention}Flush House{}, or {C:attention}Flush Five",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){C:hpfx_IjiGray}#6#{}",
                    "{C:inactive,s:0.8}This Joker breaks if #5# {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },
            j_nic_fakedalgonaumbrella_alt = {
                name = "Dalgona Umbrella{C:hpfx_IjiGray}...?{}",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}5oak{}, {C:attention}Flush House{}, or {C:attention}Flush Five",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){C:hpfx_IjiGray}#6#{}",
                    "{C:inactive,s:0.8}This Joker breaks if #5# {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} times",
                }
            },

            j_nic_fakehumantorch = {
                name = "Human Torch",
                text = {
                    "If {C:attention}first played{} hand is a {C:attention}#3#",
                    "{C:attention}of a Kind{} with exactly {C:attention}#4#{} cards,",
                    "level up the {C:attention}hand{} by {C:attention}#1#{}, increase",
                    "the amount by {C:attention}#2#{}, and destroy",
                    "a {C:attention}random played card{C:hpfx_IjiGray}#5#{}",
                }
            },
            j_nic_fakehumantorch_alt = {
                name = "Human Torch{C:hpfx_IjiGray}...?{}",
                text = {
                    "If {C:attention}first played{} hand is a {C:attention}#3#",
                    "{C:attention}of a Kind{} with exactly {C:attention}#4#{} cards,",
                    "level up the {C:attention}hand{} by {C:attention}#1#{}, increase",
                    "the amount by {C:attention}#2#{}, and destroy",
                    "a {C:attention}random played card{C:hpfx_IjiGray}#5#{}",
                }
            },

            j_nic_fakeinvisiblewoman = {
                name = "Invisible Woman",
                text = {
                    "If {C:attention}first played{} hand is a",
                    "{C:attention}#1# of a Kind{} with exactly {C:attention}#2#",
                    "cards, turn all cards into glass{C:hpfx_IjiGray}#3#{}",
                }
            },
            j_nic_fakeinvisiblewoman_alt = {
                name = "Invisible Woman{C:hpfx_IjiGray}...?{}",
                text = {
                    "If {C:attention}first played hand{} is a",
                    "{C:attention}#1# of a Kind{} with exactly {C:attention}#2#",
                    "cards, turn all cards into glass{C:hpfx_IjiGray}#3#{}",
                }
            },

            j_nic_fakethething = {
                name = "The Thing",
                text = {
                    {"When round begins, add",
                    "{C:attention}#1# Stone{} cards with a",
                    "random {C:attention}seal{} to your deck"},
                    {"If {C:attention}first played hand{} is a",
                    "{C:attention}#3# of a Kind{} with exactly {C:attention}#4#",
                    "cards, increase the amount",
                    "of {C:attention}Stone{} cards by {C:attention}#2#{C:hpfx_IjiGray}#5#{}"},
                }
            },
            j_nic_fakethething_alt = {
                name = "The Thing{C:hpfx_IjiGray}...?{}",
                text = {
                    {"When round begins, add",
                    "{C:attention}#1# Stone{} cards with a",
                    "random {C:attention}seal{} to your deck"},
                    {"If {C:attention}first played hand{} is a",
                    "{C:attention}#3# of a Kind{} with exactly {C:attention}#4#",
                    "cards, increase the amount",
                    "of {C:attention}Stone{} cards by {C:attention}#2#{C:hpfx_IjiGray}#5#{}"},
                }
            },

            j_nic_fakemisterfantastic = {
                name = "Mister Fantastic",
                text = {
                    "All {C:attention}played hands{} with exactly {C:attention}#2#",
                    "cards are considered {C:attention}#1#{C:hpfx_IjiGray}#3#{}",
                    "and the {C:attention}cards{} will count when played",
                }
            },
            j_nic_fakemisterfantastic_alt = {
                name = "Mister Fantastic{C:hpfx_IjiGray}...?{}",
                text = {
                    "All {C:attention}played hands{} with exactly {C:attention}#2#",
                    "cards are considered {C:attention}#1#{C:hpfx_IjiGray}#3#{}",
                    "and the {C:attention}cards{} will count when played",
                }
            },

            j_nic_fakeincognito = {
                name = "Incognito",
                text = {
                    {"This Joker gains {X:mult,C:white}X#3#{} Mult when a",
                    "#5# {C:spades}#6#{} card is destroyed",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult){C:hpfx_IjiGray}#7#{}"},
                    {"Each #5# {C:spades}#6#{} card held in hand",
                    "has a {C:green}#1# in #2#{} chance to be destroyed",
                    "{C:spades}#6#{} cards held in hand gives Mult{C:hpfx_IjiGray}#7#{}"},
                }
            },
            j_nic_fakeincognito_alt = {
                name = "Incognito{C:hpfx_IjiGray}...?{}",
                text = {
                    {"This Joker gains {X:mult,C:white}X#3#{} Mult when a",
                    "#5# {C:spades}#6#{} card is destroyed",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult){C:hpfx_IjiGray}#7#{}"},
                    {"Each #5# {C:spades}#6#{} card held in hand",
                    "has a {C:green}#1# in #2#{} chance to be destroyed",
                    "{C:spades}#6#{} cards held in hand gives Mult{C:hpfx_IjiGray}#7#{}"},
                }
            },

            -- Scrapped

            j_nic_overflow = {
                name = "Overflow",
                text = {
                    "Leftover {C:chips}chips{} from the {C:attention}score", 
                    "{C:attention}requirement{} are {C:attention}halved{} and used as",
                    "current {C:chips}chips{} for the {C:attention}first hand",
                    "{C:inactive}(Leftover chips last round: {C:attention}#1#{C:inactive})",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                }
            },
            j_nic_reroll = {
                name = "Infinite Reroll",
                text = {
                    "+1 Extra {C:attention}Shop{} Slot",
                    "{C:green}Infinite Reroll",
                }
            },
            j_nic_thetruefibonaccisequence = {
                name = "The True Fibonacci Sequence",
                text = {
                    "When {C:attention}Scored{}, Increases {X:chips,C:white}XChips",
                    "by the {C:attention}Fibonacci Sequence",
                    "{C:inactive} 1, 2, 3, 5, 8, 13, 21, 34, 55... etc",
                    "{C:inactive}(Currently {X:chips,C:white} X#1# {C:inactive} Chips)",
                }
            },
        },
        ZenGarden = {
            c_nic_mysteryvase = {
                name = "Mystery Vase",
                text = {
                    "Creates a random",
                    "{C:nic_plants}???{} card",
                    "{C:inactive}(Must have room)",
                }
            },
            c_nic_plantsvase = {
                name = "Plants Vase",
                text = {
                    "Creates a random",
                    "{C:nic_plants}Plants{} card",
                    "{C:inactive}(Must have room",
                    "{C:inactive}and Crazy Dave)",
                }
            },
            c_nic_shovel = {
                name = "Shovel",
                text = {
                    "Selected {C:nic_plants}Plants{} gets",
                    "{C:attention}digged up{} and gains",
                    "original {C:attention}cost value",
                }
            },
        },
        Phases = {
            c_nic_newmoon = {
                name = "New Moon",
                text = {
                    "Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips",
                }
            },
            c_nic_waxingcrescent = {
                name = "Waxing Crescent",
                text = {
                    "Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips",
                }
            },
            c_nic_firstquarter = {
                name = "First Quarter",
                text = {
                    "Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips",
                }
            },
            c_nic_waxinggibbous = {
                name = "Waxing Gibbous",
                text = {
                    "Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips",
                }
            },
            c_nic_fullmoon = {
                name = "Full Moon",
                text = {
                    "Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips",
                }
            },
            c_nic_waninggibbous = {
                name = "Waning Gibbous",
                text = {
                    "Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips",
                }
            },
            c_nic_thirdquarter = {
                name = "Third Quarter",
                text = {
                    "Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips",
                }
            },
            c_nic_waningscrescent = {
                name = "Waning Crescent",
                text = {
                    "Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips",
                }
            },
            c_nic_bluemoon = {
                name = "Blue Moon",
                text = {
                    {"Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips"},
                    {"Gains {X:nic_phases,C:white}X#7#{} Modifier for",
                    "every used {C:nic_phases}Phases{} card,",
                    "{C:inactive}(Currently {X:nic_phases,C:white}X#6#{C:inactive} Modifier)"},
                }
            },
            c_nic_bloodmoon = {
                name = "Blood Moon",
                text = {
                    {"Permanently modify last",
                    "played hand type value",
                    "by {C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:inactive}( {V:1}#1#{C:inactive} )",
                    "{s:0.2} ",
                    "{C:mult}+#4#{} x {C:nic_phases}#2#{} Mult and",
                    "{C:chips}+#5#{} x {C:nic_phases}#3#{} chips"},
                    {"Gains {C:nic_phases}+#7#{} Reusability for",
                    "each sold {C:nic_phases}Phases{} card",
                    "{C:inactive}(Currently {C:nic_phases}#6#{C:inactive} Reusability)"},
                }
            },
            c_nic_micromoon = {
                name = "Micromoon",
                text = {
                    "",
                }
            },
            c_nic_supermoon = {
                name = "Supermoon",
                text = {
                    "",
                }
            },
            c_nic_solareclipse = {
                name = "Solar Eclipse",
                text = {
                    "",
                }
            },

            -- Hyperfixation
            c_nic_pinkmoon = {
                name = "Pink Moon",
                text = {
                    {"{C:inactive}Passive Ability",
                    "smth smth",},
                    {"{C:inactive}Ability [USE]",
                    "smth smth",},
                }
            },
        },

        -- MoreFluff
        Colour = {
            c_nic_teto = {
                name = "Teto",
                text = {
                    "Create a {C:dark_edition}Negative {C:nic_teto}Pear{}",
                    "for every {C:attention}#4#{} rounds",
                    "this has been held",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
                }
            }
        },
        Rotarot = {
            c_nic_rot_teto = {
                name = "Tetarot!",
                text = {
                    "Turns selected Joker",
                    "into a {C:nic_teto}Teto{} Joker",
                    "{C:inactive,s:0.8} Food Jokers turn into Pears",
                }
            }
        },

        Partner = {
            pnr_nic_incognito = {
                name = "Incognito",
                text = {
                    "Each {C:spades}Spade{} cards held",
                    "in hand has a {C:green}#1# in #2#",
                    "chance to give {C:mult}+#3#{} Mult",
                }
            },
            pnr_nic_invert = {
                name = "Invert",
                text = {
                    "Each played hand, has",
                    "a {C:green}#1# in #2#{} chance to",
                    "increase handsize by {C:attention}#4#",
                    "{C:inactive}(Currently {C:attention}+#3#{C:inactive} Hand size)",
                }
            },
            pnr_nic_pear = {
                name = "Pear",
                text = {
                    "For every {C:attention}#2#{C:inactive} [#3#]{} played",
                    "{C:attention}Pair{}, level up by {C:attention}#1#{} level",
                }
            },
            pnr_nic_pearto = {
                name = "Pearto",
                text = {
                    "Played {C:attention}Pair{} has a",
                    "{C:green}#1# in #2#{} chance to",
                    "level up by {C:attention}#3#{} level",
                }
            },
        },
        Other = {
            -- Packs
            p_nic_teto_normal = {
                name = "Teto Pack",
                text= {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:nic_teto} Teto{} cards",
                },
            },
            p_nic_vase_normal_1 = {
                name = "Vase Pack",
                text= {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:nic_plants} Vase{} cards",
                },
            },
            p_nic_vase_normal_2 = {
                name = "Vase Pack",
                text= {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:nic_plants} Vase{} cards",
                },
            },
            p_nic_tools_normal = {
                name = "Tools Pack",
                text= {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:nic_plants} Zen Garden{} cards",
                },
            },
            p_nic_lunar_normal_1 = {
                name = "Lunar Pack",
                text= {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:nic_phases} Phases{} cards",
                },
            },
            p_nic_lunar_normal_2 = {
                name = "Lunar Pack",
                text= {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:nic_phases} Phases{} cards",
                },
            },
            p_nic_lunar_jumbo = {
                name = "Jumbo Lunar Pack",
                text= {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:nic_phases} Phases{} cards",
                },
            },
            p_nic_lunar_mega = {
                name = "Mega Lunar Pack",
                text= {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:nic_phases} Phases{} cards",
                },
            },
            
            -- Teto
            nic_tetosticker = {
                name = "Teto",
                text = {
                    "This Joker is",
                    "considered a {C:nic_teto}Teto",
                }
            },

            -- Phases
            nic_teal_seal = {
                name = "Teal Seal",
                text = {
                    "Creates a {C:nic_phases}Phases{} card",
                    "when {C:attention}played{} and {C:attention}unscored",
                    "{C:inactive}(Must have room)",
                },
            },
            nic_changingbasephases = {
                name = "Changing Phases",
                text = {
                    "Changes {C:nic_phases}Phases{} end of",
                    "round, {C:green}#1# in #2#{} chance to",
                    "turn into {C:nic_phases}Special Phases"
                }
            },
            nic_changingspecialphases = {
                name = "Changing Special Phases",
                text = {
                    "End of round,",
                    "{C:green}#1# in #2#{} chance to",
                    "turn into {C:nic_phases}Phases"
                }
            },
            nic_specialphases = {
                name = "Special Phases",
                text = {
                    "{C:green}#1# in #2#{} chance",
                    "to create a",
                    "{C:nic_phases}Special Phases",
                }
            },
            nic_levelupvaluephases = {
                name = "Level Up Value",
                text = {
                    "Last played hand",
                    "{C:planet}Planet{} value times",
                    "{C:nic_phases}Phases{} modifier",
                    "{s:0.2} ",
                    "{C:planet}#3#{} x {C:nic_phases}#1#{} Mult and",
                    "{C:planet}#4#{} x {C:nic_phases}#2#{} chips",
                }
            },
            -- STS
            nic_ostyhp = {
                name = "Osty's HP",
                text = {
                    "{C:inactive}#1# HP"
                }
            },

            -- Other
            nic_spades_no_debuff = {
                name = " Passive Ability ",
                text = {
                    "{C:spades}Spades{} can't", 
                    "be debuffed",
                }
            },

            -- Alloy
            nic_tetorobo_moodmeter = {
                name = "Mood Meter",
                text = {
                    " {V:1}#1#{V:2}#1#{V:3}#1#{V:4}#1#{V:5}#1#{V:6}#1#{V:7}#1#{V:8}#1#{V:9}#1#{V:10}#1#{} #2#/100 ",
                    "{s:0.8}XMult and Shield Bonus",
                    "{s:0.8}is based on her mood",
                }
            },
            nic_tetorobo_shieldbonus = {
                name = "Shield Bonus",
                text = {
                    "If {C:attention}first hand{} wins",
                    "round, gain {X:chips,C:white}Shield`````Bonus",
                    "{C:inactive}(Currently {X:chips,C:white}`#1#`{C:inactive} Shield Bonus)",
                }
            },
            nic_tetorobo_xmult = {
                name = "XMult",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played",
                    "hand is a {C:attention}Pair",
                }
            },

            -- LobotomyCorp
            und_j_nic_mysteto = {
                name = "M-04-01",
                text = {
                    "So can we, Wander for a",
                    "spell, And live in parallel,",
                    "I want it to be true,",
                    "To be like you, My heart,",
                    "Sings a chorus out of tune",
                }
            },
            nic_obs = {
                text = {
                    "{C:inactive}- Observation Level #3# -",
                    "{C:attention}#1#/#2#"
                }
            },
        },
        Planet={},
        Spectral = {
            c_nic_mooncatcher = {
                name = "Mooncatcher",
                text = {
                    "Add a {C:nic_phases}Teal Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },
        },
        Stake={},
        Tag={
            tag_nic_teto = {
                name = "Teto Tag",
                text = {
                    "Shop has a free",
                    "{C:nic_teto}Teto Joker",
                }
            },
            tag_nic_twindrill = {
                name = "Twindrill Tag",
                text = {
                    "Gives a free",
                    "{C:nic_teto}Teto Pack",
                }
            },
            tag_nic_vase1 = {
                name = "Vase Tag",
                text = {
                    "Gives a free",
                    "{C:nic_plants}Vase Pack",
                }
            },
            tag_nic_vase2 = {
                name = "Vase Tag",
                text = {
                    "Gives a free",
                    "{C:nic_plants}Vase Pack",
                }
            },
            tag_nic_lunar = {
                name = "Lunar Tag",
                text = {
                    "Gives a free",
                    "{C:nic_phases}Mega Lunar Pack",
                }
            },
        },
        Tarot = {
            c_nic_tetotarot = {
                name = "Tetarot",
                text = {
                    "Gives selected Joker",
                    "a {C:nic_teto}Teto{} Sticker",
                    "{C:inactive,s:0.8} Food Jokers turn into Pears",
                }
            },
            c_nic_selene = {
                name = "Selene",
                text = {
                    "Creates up to {C:attention}#1#",
                    "random {C:nic_phases}Phases{} cards",
                    "{C:inactive}(Must have room)",
                },
            },
        },
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names = {
            c_nic_incognito = "OOPS? ALL SWOONS!",
            c_nic_invert = "O0p$? @l- HAHAHA!",
            c_nic_machinedramon = "THE FUTURE WILL BE PAVED WITH METAL!",
        },
        collabs={},
        dictionary = {
            -- Rarity
            k_nic_incognito = "Incognito",
            k_nic_teto = "Teto",
            k_nic_plants = "Plants",
            k_nic_scrapped = "Scrapped",
            -- Packs
            k_nic_teto_pack = "Teto Pack",
            k_nic_vase_pack = "Vase Pack",
            k_nic_tools_pack = "Tools Pack",
            k_nic_lunar_pack = "Lunar Pack",
            -- Phases
            k_nic_plus_phases = "+1 Phases",
            k_nic_special_phases = "Special Phases",
            k_nic_apogee = "Apogee",
            k_nic_perigee = "Perigee",
            k_nic_eclipse = "Eclipse",
            -- Death
            ph_nic_technoblade = "TECHNOBLADE NEVER DIES!",
        },
        high_scores={},
        labels = {
            nic_tetosticker = "Teto",
            nic_teal_seal = "Teal Seal",
        },
        poker_hand_descriptions={},
        poker_hands={},
        quips = {
            -- Win

            nic_tetowordofthedaywin1 = {
                "Teto Word Of The Day",
                "      Winner :D"
            },
            nic_peartowin1 = {"Pear"},

            -- Loss

            nic_tetowordofthedayloss1 = {
                "Teto Word Of The Day",
                "      Loser :P"
            },
            nic_deathloss1 = {
                "I just love the",
                "smell of FEAR",
            },
        },
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary = {
            nic_active = "Active!",
            nic_inactive = "Inactive!",
            nic_moneyactive = "Success!",
            nic_moneyinactive = "Working...",
            nic_tetoactive = "Mesmerized!",
            nic_tetoinactive = "No Luck! No Hope!",
        },
        v_text = {
            ch_c_nic_incognito1 = { "You have {C:clubs}Clubs{}, {C:hearts}Hearts{}, {C:diamonds}Diamonds{}" },
            ch_c_nic_incognito2 = { "But you don't have any {C:spades}Spades{}" },
            ch_c_nic_incognito3 = { "Let's see how {C:spades}Incognito{} you are" },
            ch_c_nic_invert1 = { "{C:dark_edition}HAHAHAHAHAHAHAHAHAHAHA"},
            ch_c_nic_machinedramon1 = { "MACHINEDRAMON" },
        },
    },
}