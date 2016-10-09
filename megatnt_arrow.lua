minetest.register_craftitem("throwing:megatnt_arrow", {
	description = "Mega TNT Arrow",
	inventory_image = "throwing_arrow.png",
})

minetest.register_node("throwing:arrow_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft / Stiel
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			--Spitze / Arrow Head
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			--Federn / Feather
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},
			
			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"throwing_arrow.png", "throwing_arrow.png", "throwing_arrow_back.png", "throwing_arrow_front.png", "throwing_arrow_2.png", "throwing_arrow.png"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_ARROW_ENTITY={
	physical = false,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"throwing:arrow_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}

THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	-- Not the first on_step call?
	if self.lastpos.x~=nil then
		if node.name ~= "air" then
			minetest.env:add_item(self.lastpos, 'throwing:arrow')
			self.object:remove()
			minetest.set_node(pos, {name="supertnt:megatnt_burning"})
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity("throwing:megatnt_arrow_entity", THROWING_ARROW_ENTITY)

minetest.register_craft({
	output = 'throwing:megatnt_arrow 16',
	recipe = {
		{'default:stick', 'default:stick', 'supertnt:mega_tnt'},
	}
})
