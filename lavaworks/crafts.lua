-- Crafting recipes for pipes

minetest.register_craft( {
        output = "lavaworks:pipe_1_empty 12",
        recipe = {
                { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot" },
                { "", "", "" },
                { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot" }
        },
})

minetest.register_craft( {
        output = "lavaworks:spigot 3",
        recipe = {
                { "lavaworks:pipe_1_empty", "" },
                { "", "lavaworks:pipe_1_empty" },
        },
})

minetest.register_craft( {
	output = "lavaworks:entry_panel_empty 2",
	recipe = {
		{ "", "default:gold_ingot", "" },
		{ "", "lavaworks:pipe_1_empty", "" },
		{ "", "default:gold_ingot", "" },
	},
})

-- Various ancillary pipe devices

minetest.register_craft( {
        output = "lavaworks:pump_off 2",
        recipe = {
                { "default:stone", "default:gold_ingot", "default:stone" },
                { "moreores:copper_ingot", "default:mese_crystal_fragment", "moreores:copper_ingot" },
                { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot" }
        },
})

minetest.register_craft( {
        output = "lavaworks:valve_off_empty 2",
        recipe = {
                { "", "default:stick", "" },
                { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot" },
                { "", "default:gold_ingot", "" }
        },
})

minetest.register_craft( {
        output = "lavaworks:storage_tank_0 2",
        recipe = {
                { "", "default:gold_ingot", "default:gold_ingot" },
                { "default:gold_ingot", "default:glass", "default:gold_ingot" },
                { "default:gold_ingot", "default:gold_ingot", "" }
        },
})

minetest.register_craft( {
        output = "lavaworks:grating 2",
        recipe = {
                { "default:gold_ingot", "", "default:gold_ingot" },
                { "", "lavaworks:pipe_1_empty", "" },
                { "default:gold_ingot", "", "default:gold_ingot" }
        },
})

minetest.register_craft( {
        output = "lavaworks:flow_sensor_empty 2",
        recipe = {
                { "lavaworks:pipe_1_empty", "mesecons:mesecon", "lavaworks:pipe_1_empty" },
        },
})

minetest.register_craft( {
        output = "lavaworks:fountainhead 2",
        recipe = {
                { "lavaworks:pipe_1_empty" },
				{ "lavaworks:pipe_1_empty" }
        },
})





