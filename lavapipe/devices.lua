-- List of devices that should participate in the autoplace algorithm

local pipereceptor_on = nil
local pipereceptor_off = nil

if mesecon then
	pipereceptor_on = {
		receptor = {
			state = mesecon.state.on,
			rules = lavaworks.mesecons_rules
		}
	}

	pipereceptor_off = {
		receptor = {
			state = mesecon.state.off,
			rules = lavaworks.mesecons_rules
		}
	}
end

local pipes_devicelist = {
	"pump",
	"valve",
	"storage_tank_0",
	"storage_tank_1",
	"storage_tank_2",
	"storage_tank_3",
	"storage_tank_4",
	"storage_tank_5",
	"storage_tank_6",
	"storage_tank_7",
	"storage_tank_8",
	"storage_tank_9",
	"storage_tank_10"
}

-- Now define the nodes.

local states = { "on", "off" }
local dgroups = ""
local pumpboxes = {}

for s in ipairs(states) do

	if states[s] == "off" then
		dgroups = {snappy=3, pipe=1}
	else
		dgroups = {snappy=3, pipe=1, not_in_creative_inventory=1}
	end

	pumpboxes = {}

	lavaworks.add_node_box(pumpboxes, lavaworks.pipe_pumpbody)
	lavaworks.add_node_box(pumpboxes, lavaworks.pipe_topstub)

	minetest.register_node("lavaworks:pump_"..states[s], {
		description = "Pump/Intake Module",
		drawtype = "nodebox",
		tiles = {
			"lavaworks_pump_top.png",
			"lavaworks_pump_bottom.png",
			"lavaworks_pump_sides.png",
			"lavaworks_pump_sides.png",
			"lavaworks_pump_sides.png",
			"lavaworks_pump_"..states[s]..".png"
		},
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = {
	             	type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }
		},
		node_box = {
			type = "fixed",
			fixed = pumpboxes
		},
		groups = dgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		after_place_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
		drop = "lavaworks:pump_off",
		mesecons = {effector = {
			action_on = function (pos, node)
				minetest.add_node(pos,{name="lavaworks:pump_on", param2 = node.param2}) 
			end,
			action_off = function (pos, node)
				minetest.add_node(pos,{name="lavaworks:pump_off", param2 = node.param2}) 
			end
		}},
		on_punch = function(pos, node, puncher)
			local fdir = minetest.get_node(pos).param2
			minetest.add_node(pos, { name = "lavaworks:pump_"..states[3-s], param2 = fdir })
		end
	})
	
	local valveboxes = {}
	lavaworks.add_node_box(valveboxes, lavaworks.pipe_leftstub)
	lavaworks.add_node_box(valveboxes, lavaworks.pipe_valvebody)
	if states[s] == "off" then 
		lavaworks.add_node_box(valveboxes, lavaworks.pipe_valvehandle_off)
	else
		lavaworks.add_node_box(valveboxes, lavaworks.pipe_valvehandle_on)
	end
	lavaworks.add_node_box(valveboxes, lavaworks.pipe_rightstub)
	local tilex = "lavaworks_valvebody_ends.png"
	local tilez = "lavaworks_valvebody_sides.png"

	minetest.register_node("lavaworks:valve_"..states[s].."_empty", {
		description = "Valve",
		drawtype = "nodebox",
		tiles = {
			"lavaworks_valvebody_top_"..states[s]..".png",
			"lavaworks_valvebody_bottom.png",
			tilex,
			tilex,
			tilez,
			tilez,
		},
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = {
	             	type = "fixed",
			fixed = { -8/16, -4/16, -5/16, 8/16, 5/16, 5/16 }
		},
		node_box = {
			type = "fixed",
			fixed = valveboxes
		},
		groups = dgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		after_place_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
	drop = "lavaworks:valve_off_empty",
		mesecons = {effector = {
			action_on = function (pos, node)
				minetest.add_node(pos,{name="lavaworks:valve_on_empty", param2 = node.param2}) 
			end,
			action_off = function (pos, node)
				minetest.add_node(pos,{name="lavaworks:valve_off_empty", param2 = node.param2}) 
			end
		}},
		on_punch = function(pos, node, puncher)
			local fdir = minetest.get_node(pos).param2
			minetest.add_node(pos, { name = "lavaworks:valve_"..states[3-s].."_empty", param2 = fdir })
		end
	})
end

local valveboxes = {}
lavaworks.add_node_box(valveboxes, lavaworks.pipe_leftstub)
lavaworks.add_node_box(valveboxes, lavaworks.pipe_valvebody)
lavaworks.add_node_box(valveboxes, lavaworks.pipe_rightstub)
lavaworks.add_node_box(valveboxes, lavaworks.pipe_valvehandle_on)

minetest.register_node("lavaworks:valve_on_loaded", {
	description = "Valve",
	drawtype = "nodebox",
	tiles = {
		"lavaworks_valvebody_top_on.png",
		"lavaworks_valvebody_bottom.png",
		"lavaworks_valvebody_ends.png",
		"lavaworks_valvebody_ends.png",
		"lavaworks_valvebody_sides.png",
		"lavaworks_valvebody_sides.png",
	},
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = {
             	type = "fixed",
		fixed = { -8/16, -4/16, -5/16, 8/16, 5/16, 5/16 }
	},
	node_box = {
		type = "fixed",
		fixed = valveboxes
	},
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	drop = "lavaworks:valve_off_empty",
	mesecons = {effector = {
		action_on = function (pos, node)
			minetest.add_node(pos,{name="lavaworks:valve_on_empty", param2 = node.param2}) 
		end,
		action_off = function (pos, node)
			minetest.add_node(pos,{name="lavaworks:valve_off_empty", param2 = node.param2}) 
		end
	}},
	on_punch = function(pos, node, puncher)
		local fdir = minetest.get_node(pos).param2
		minetest.add_node(pos, { name = "lavaworks:valve_off_empty", param2 = fdir })
	end
})

-- grating

minetest.register_node("lavaworks:grating", {
	description = "Decorative grating",
	tiles = {
		"lavaworks_grating_top.png",
		"lavaworks_grating_sides.png",
		"lavaworks_grating_sides.png",
		"lavaworks_grating_sides.png",
		"lavaworks_grating_sides.png",
		"lavaworks_grating_sides.png"
	},
	sunlight_propagates = true,
	paramtype = "light",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
})

-- outlet spigot

	local spigotboxes = {}
	lavaworks.add_node_box(spigotboxes, lavaworks.pipe_backstub)
	lavaworks.add_node_box(spigotboxes, lavaworks.spigot_bottomstub)
	lavaworks.add_node_box(spigotboxes, lavaworks.pipe_bendsphere)

	local spigotboxes_pouring = {}
	lavaworks.add_node_box(spigotboxes_pouring, lavaworks.spigot_stream)
	lavaworks.add_node_box(spigotboxes_pouring, lavaworks.pipe_backstub)
	lavaworks.add_node_box(spigotboxes_pouring, lavaworks.spigot_bottomstub)
	lavaworks.add_node_box(spigotboxes_pouring, lavaworks.pipe_bendsphere)

minetest.register_node("lavaworks:spigot", {
	description = "Spigot outlet",
	drawtype = "nodebox",
	tiles = {
		"lavaworks_spigot_sides.png",
		"lavaworks_pipe_end_empty.png",
		"lavaworks_spigot_sides.png",
		"lavaworks_spigot_sides.png",
		"lavaworks_pipe_end_empty.png",
		"lavaworks_spigot_sides.png"
	},
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	node_box = {
		type = "fixed",
		fixed = spigotboxes,
	},
	selection_box = {
		type = "fixed",
		fixed = { -2/16, -6/16, -2/16, 2/16, 2/16, 8/16 }
	}
})

minetest.register_node("lavaworks:spigot_pouring", {
	description = "Spigot outlet",
	drawtype = "nodebox",
	tiles = {
		"lavaworks_spigot_sides.png",
		"default_lava.png^lavaworks_spigot_bottom2.png",
		{ name = "default_lava_flowing_animated.png^lavaworks_spigot_sides2.png",
			animation = {
				type = "vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=0.8
			}
		},
		{ name = "default_lava_flowing_animated.png^lavaworks_spigot_sides2.png",
			animation = {
				type = "vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=0.8
			}
		},
		{ name = "default_lava_flowing_animated.png^lavaworks_spigot_sides2.png",
			animation = {
				type = "vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=0.8
			}
		},
		{ name = "default_lava_flowing_animated.png^lavaworks_spigot_sides2.png",
			animation = {
				type = "vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=0.8
			}
		},
	},
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	node_box = {
		type = "fixed",
		fixed = spigotboxes_pouring,
	},
	selection_box = {
		type = "fixed",
		fixed = { -2/16, -6/16, -2/16, 2/16, 2/16, 8/16 }
	},
	drop = "lavaworks:spigot",
})

-- sealed pipe entry/exit (horizontal pipe passing through a metal
-- wall, for use in places where walls should look like they're airtight)

local airtightboxes = {}
lavaworks.add_node_box(airtightboxes, lavaworks.pipe_frontstub)
lavaworks.add_node_box(airtightboxes, lavaworks.pipe_backstub)
lavaworks.add_node_box(airtightboxes, lavaworks.entry_panel)

minetest.register_node("lavaworks:entry_panel_empty", {
	description = "Airtight Pipe entry/exit",
	drawtype = "nodebox",
	tiles = {
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_pipe_end_empty.png",
		"lavaworks_pipe_end_empty.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	node_box = {
		type = "fixed",
		fixed = airtightboxes,
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -2/16, -2/16, -8/16, 2/16, 2/16, 8/16 },
			{ -8/16, -8/16, -1/16, 8/16, 8/16, 1/16 }
		}
	},
	on_place = function(itemstack, placer, pointed_thing)
		if not lavaworks.node_is_owned(pointed_thing.under, placer) 
		   and not lavaworks.node_is_owned(pointed_thing.above, placer) then
			local node = minetest.get_node(pointed_thing.under)

			if not minetest.registered_nodes[node.name]
			    or not minetest.registered_nodes[node.name].on_rightclick then
				local pitch = placer:get_look_pitch()
				local above = pointed_thing.above
				local under = pointed_thing.under
				local fdir = minetest.dir_to_facedir(placer:get_look_dir())
				local undernode = minetest.get_node(under)
				local abovenode = minetest.get_node(above)
				local uname = undernode.name
				local aname = abovenode.name
				local isabove = (above.x == under.x) and (above.z == under.z) and (pitch > 0)
				local pos1 = above

				if above.x == under.x
				    and above.z == under.z
				    and ( string.find(uname, "lavaworks:pipe_")
					 or string.find(uname, "lavaworks:storage_")
					 or string.find(uname, "lavaworks:expansion_")
					 or ( string.find(uname, "lavaworks:grating") and not isabove )
					 or ( string.find(uname, "lavaworks:pump_") and not isabove )
					 or ( string.find(uname, "lavaworks:entry_panel")
					      and undernode.param2 == 13 )
					 )
				then
					fdir = 13
				end

				if minetest.registered_nodes[uname]["buildable_to"] then
					pos1 = under
				end

				if not minetest.registered_nodes[minetest.get_node(pos1).name]["buildable_to"] then return end

				minetest.add_node(pos1, {name = "lavaworks:entry_panel_empty", param2 = fdir })
				lavaworks.scan_for_pipe_objects(pos1)

				if not lavaworks.expect_infinite_stacks then
					itemstack:take_item()
				end

			else
				minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer, itemstack)
			end
		end
		return itemstack
	end
})

minetest.register_node("lavaworks:entry_panel_loaded", {
	description = "Airtight Pipe entry/exit",
	drawtype = "nodebox",
	tiles = {
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_pipe_end_empty.png",
		"lavaworks_pipe_end_empty.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	node_box = {
		type = "fixed",
		fixed = airtightboxes,
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -2/16, -2/16, -8/16, 2/16, 2/16, 8/16 },
			{ -8/16, -8/16, -1/16, 8/16, 8/16, 1/16 }
		}
	},
	drop = "lavaworks:entry_panel_empty"
})

local sensorboxes = {}
lavaworks.add_node_box(sensorboxes, lavaworks.pipe_leftstub)
lavaworks.add_node_box(sensorboxes, lavaworks.pipe_sensorbody)
lavaworks.add_node_box(sensorboxes, lavaworks.pipe_rightstub)

minetest.register_node("lavaworks:flow_sensor_empty", {
	description = "Flow Sensor",
	drawtype = "nodebox",
	tiles = {
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_windowed_empty.png",
		"lavaworks_windowed_empty.png"
	},
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	on_construct = function(pos)
		if mesecon then
			mesecon:receptor_off(pos, rules) 
		end
	end,
	node_box = {
		type = "fixed",
		fixed = sensorboxes,
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -2/16, -2/16, 8/16, 2/16, 2/16 },
		}
	},
	mesecons = pipereceptor_off
})

minetest.register_node("lavaworks:flow_sensor_loaded", {
	description = "Flow sensor (on)",
	drawtype = "nodebox",
	tiles = {
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_plain.png",
		"lavaworks_sensor_sides_on.png",
		"lavaworks_sensor_sides_on.png"
	},
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	on_construct = function(pos)
		if mesecon then
			mesecon:receptor_on(pos, rules) 
		end
	end,
	node_box = {
		type = "fixed",
		fixed = sensorboxes,
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -2/16, -2/16, 8/16, 2/16, 2/16 },
		}
	},
	drop = "lavaworks:flow_sensor_empty",
	mesecons = pipereceptor_on
})

-- tanks

for fill = 0, 10 do
	local filldesc="empty"
	local sgroups = {snappy=3, pipe=1, tankfill=fill+1}
	local image = nil

	if fill ~= 0 then
		filldesc=fill.."0% full"
		sgroups = {snappy=3, pipe=1, tankfill=fill+1, not_in_creative_inventory=1}
		image = "lavaworks_storage_tank_fittings.png"
	end

	minetest.register_node("lavaworks:expansion_tank_"..fill, {
		description = "Expansion Tank ("..filldesc..")... You hacker, you.",
		tiles = {
			"lavaworks_storage_tank_fittings.png",
			"lavaworks_storage_tank_fittings.png",
			"lavaworks_storage_tank_back.png",
			"lavaworks_storage_tank_back.png",
			"lavaworks_storage_tank_back.png",
			lavaworks.liquid_texture.."^lavaworks_storage_tank_front_"..fill..".png"
		},
		inventory_image = image,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=3, pipe=1, tankfill=fill+1, not_in_creative_inventory=1},
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		drop = "lavaworks:storage_tank_"..fill,
		after_place_node = function(pos)
			lavaworks.look_for_stackable_tanks(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
	})

	minetest.register_node("lavaworks:storage_tank_"..fill, {
		description = "Fluid Storage Tank ("..filldesc..")",
		tiles = {
			"lavaworks_storage_tank_fittings.png",
			"lavaworks_storage_tank_fittings.png",
			"lavaworks_storage_tank_back.png",
			"lavaworks_storage_tank_back.png",
			"lavaworks_storage_tank_back.png",
			lavaworks.liquid_texture.."^lavaworks_storage_tank_front_"..fill..".png"
		},
		inventory_image = image,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = sgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		after_place_node = function(pos)
			lavaworks.look_for_stackable_tanks(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			lavaworks.scan_for_pipe_objects(pos)
		end,
	})
end

-- fountainhead

minetest.register_node("lavaworks:fountainhead", {
	description = "Fountainhead",
	drawtype = "nodebox",
	tiles = {
		"lavaworks_fountainhead_top.png",
		"lavaworks_pipe_end.png",
		"lavaworks_plain.png",
	},
	sunlight_propagates = true,
	paramtype = "light",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	on_construct = function(pos)
		if mesecon then
			mesecon:receptor_on(pos, rules) 
		end
	end,
	node_box = {
		type = "fixed",
		fixed = lavaworks.fountainhead_model ,
	},
	selection_box = {
		type = "fixed",
		fixed = { -2/16, -8/16, -2/16, 2/16, 8/16, 2/16 }
	},
})

minetest.register_node("lavaworks:fountainhead_pouring", {
	description = "Fountainhead",
	drawtype = "nodebox",
	tiles = {
		"lavaworks_fountainhead_top.png",
		"lavaworks_pipe_end.png",
		"lavaworks_plain.png",
	},
	sunlight_propagates = true,
	paramtype = "light",
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	after_place_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		lavaworks.scan_for_pipe_objects(pos)
	end,
	on_construct = function(pos)
		if mesecon then
			mesecon:receptor_on(pos, rules) 
		end
	end,
	node_box = {
		type = "fixed",
		fixed = lavaworks.fountainhead_model,
	},
	selection_box = {
		type = "fixed",
		fixed = { -2/16, -8/16, -2/16, 2/16, 8/16, 2/16 },
	},
	drop = "lavaworks:fountainhead"
})

minetest.register_alias("lavaworks:valve_off_loaded", "lavaworks:valve_off_empty")

