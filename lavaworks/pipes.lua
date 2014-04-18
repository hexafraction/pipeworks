-- This file supplies the gold pipes

local REGISTER_COMPATIBILITY = true

local pipes_empty_nodenames = {}
local pipes_full_nodenames = {}

local vti = {4, 3, 2, 1, 6, 5}
local cconnects = {{}, {1}, {1, 2}, {1, 3}, {1, 3, 5}, {1, 2, 3}, {1, 2, 3, 5}, {1, 2, 3, 4}, {1, 2, 3, 4, 5}, {1, 2, 3, 4, 5, 6}}
for index, connects in ipairs(cconnects) do
	local outboxes = {}
	local outsel = {}
	local outimgs = {}
	
	for i = 1, 6 do
		outimgs[vti[i]] = "lavaworks_plain.png"
	end
	
	local jx = 0
	local jy = 0
	local jz = 0
	for _, v in ipairs(connects) do
		if v == 1 or v == 2 then
			jx = jx + 1
		elseif v == 3 or v == 4 then
			jy = jy + 1
		else
			jz = jz + 1
		end
		lavaworks.add_node_box(outboxes, lavaworks.pipe_boxes[v])
		table.insert(outsel, lavaworks.pipe_selectboxes[v])
		outimgs[vti[v]] = "lavaworks_pipe_end.png"
	end

	if #connects == 1 then
		local v = connects[1]
		v = v-1 + 2*(v%2) -- Opposite side
		outimgs[vti[v]] = "^lavaworks_plain.png"
	end

	if #connects >= 2 then
		lavaworks.add_node_box(outboxes, lavaworks.pipe_bendsphere)
	end
	
	if jx == 2 and jy ~= 2 and jz ~= 2 then
		outimgs[5] = lavaworks.liquid_texture.."^lavaworks_windowed_XXXXX.png"
		outimgs[6] = outimgs[5]
	end
	
	local pgroups = {snappy = 3, pipe = 1, not_in_creative_inventory = 1}
	local pipedesc = "Pipe segement".." "..dump(connects).."... You hacker, you."
	local image = nil

	if #connects == 0 then
		pgroups = {snappy = 3, tube = 1}
		pipedesc = "Pipe segment"
		image = "lavaworks_pipe_inv.png"
	end
	
	--table.insert(lavaworks.tubenodes, name.."_"..tname)
	
	minetest.register_node("lavaworks:pipe_"..index.."_empty", {
		description = pipedesc,
		drawtype = "nodebox",
		tiles = lavaworks.fix_image_names(outimgs, "_empty"),
		sunlight_propagates = true,
		inventory_image = image,
		wield_image = image,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = {
	             	type = "fixed",
			fixed = outsel
		},
		node_box = {
			type = "fixed",
			fixed = outboxes
		},
		groups = pgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		drop = "lavaworks:pipe_1_empty",
		after_place_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end
	})
	
	local pgroups = {snappy = 3, pipe = 1, not_in_creative_inventory = 1}

	minetest.register_node("lavaworks:pipe_"..index.."_loaded", {
		description = pipedesc,
		drawtype = "nodebox",
		tiles = lavaworks.fix_image_names(outimgs, "_loaded"),
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = {
	             	type = "fixed",
			fixed = outsel
		},
		node_box = {
			type = "fixed",
			fixed = outboxes
		},
		groups = pgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		drop = "lavaworks:pipe_1_empty",
		after_place_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end
	})
	
	table.insert(pipes_empty_nodenames, "lavaworks:pipe_"..index.."_empty")
	table.insert(pipes_full_nodenames,  "lavaworks:pipe_"..index.."_loaded")
end



if REGISTER_COMPATIBILITY then
	local cempty = "lavaworks:pipe_compatibility_empty"
	local cloaded = "lavaworks:pipe_compatibility_loaded"
	minetest.register_node(cempty, {
		drawtype = "airlike",
		sunlight_propagates = true,
		paramtype = "light",
		inventory_image = "lavaworks_pipe_inv.png",
		wield_image = "lavaworks_pipe_inv.png",
		description = "Pipe Segment (legacy)",
		groups = {not_in_creative_inventory = 1, pipe_to_update = 1},
		drop = "lavaworks:pipe_1_empty",
		after_place_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
	})
	minetest.register_node(cloaded, {
		drawtype = "airlike",
		sunlight_propagates = true,
		paramtype = "light",
		inventory_image = "lavaworks_pipe_inv.png",
		groups = {not_in_creative_inventory = 1, pipe_to_update = 1},
		drop = "lavaworks:pipe_1_empty",
		after_place_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
	})
	for xm = 0, 1 do
	for xp = 0, 1 do
	for ym = 0, 1 do
	for yp = 0, 1 do
	for zm = 0, 1 do
	for zp = 0, 1 do
		local pname = xm..xp..ym..yp..zm..zp
		minetest.register_alias("lavaworks:pipe_"..pname.."_empty", cempty)
		minetest.register_alias("lavaworks:pipe_"..pname.."_loaded", cloaded)
	end
	end
	end
	end
	end
	end
	minetest.register_abm({
		nodenames = {"group:pipe_to_update"},
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local minp = {x = pos.x-1, y = pos.y-1, z = pos.z-1}
			local maxp = {x = pos.x+1, y = pos.y+1, z = pos.z+1}
			if table.getn(minetest.find_nodes_in_area(minp, maxp, "ignore")) == 0 then
				lavaworks.scan_for_pipe_objects(pos)
			end
		end
	})
end

table.insert(pipes_empty_nodenames,"lavaworks:valve_on_empty")
table.insert(pipes_empty_nodenames,"lavaworks:valve_off_empty")
table.insert(pipes_empty_nodenames,"lavaworks:entry_panel_empty")
table.insert(pipes_empty_nodenames,"lavaworks:flow_sensor_empty")

table.insert(pipes_full_nodenames,"lavaworks:valve_on_loaded")
table.insert(pipes_full_nodenames,"lavaworks:entry_panel_loaded")
table.insert(pipes_full_nodenames,"lavaworks:flow_sensor_loaded")

minetest.register_abm({
	nodenames = pipes_empty_nodenames,
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		lavaworks.check_for_inflows(pos,node)
	end
})

minetest.register_abm({
	nodenames = pipes_full_nodenames,
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		lavaworks.check_sources(pos,node)
	end
})

minetest.register_abm({
	nodenames = {"lavaworks:spigot","lavaworks:spigot_pouring"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider) 
		lavaworks.spigot_check(pos,node)
	end
})

minetest.register_abm({
	nodenames = {"lavaworks:fountainhead","lavaworks:fountainhead_pouring"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider) 
		lavaworks.fountainhead_check(pos,node)
	end
})

