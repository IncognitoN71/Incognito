-- Button (Revo and FAC)

local card_highlight = Card.highlight
function Card:highlight(is_higlighted)
    if string.find(self.ability.name, "j_nic_3ds") then
        self.highlighted = is_higlighted
		if self.highlighted and self.area and self.area.config.type ~= "shop" and self.area.config.type ~= "consumeable" then
            self.children.use_button = UIBox({
                definition = Incognito.use_and_sell_buttons(self),
                config = {
                    align = "cr",
                    offset = {
                        x = -0.4,
                        y = 0,
                    },
                    parent = self,
                },
            })
        elseif self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		else
		    card_highlight(self, is_higlighted)
	    end
	else
		card_highlight(self, is_higlighted)
	end
end

-- 3DS Overlay

SMODS.draw_ignore_keys.cartridge_overlay = true
SMODS.DrawStep({
    key = "cartridge_overlay",
    order = 201,
    func = function(card, layer)
        if card.config.center.key == "j_nic_3ds" and card.ability then
            local cartridge = G.P_CENTERS[card.ability.extra.cartridge]
            if card.ability.extra.cartridge then
                card.children.cartridge_overlay = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS[cartridge.overlay_atlas], cartridge.pos)
                card.children.cartridge_overlay.role.draw_major = card
                card.children.cartridge_overlay:draw_shader("dissolve", nil, nil, nil, card.children.center, nil, nil)
            end
        end
    end,
	conditions = { vortex = false, facing = "front" },
})