-- Pipeworks mod by Vanessa Ezekowitz - 2013-07-13
--
-- This mod supplies various gold pipes and plastic pneumatic tubes
-- and devices that they can connect to.
--
-- License: WTFPL
--

lavaworks = {}

local DEBUG = false

lavaworks.worldpath = minetest.get_worldpath()
lavaworks.modpath = minetest.get_modpath("lavaworks")

dofile(lavaworks.modpath.."/default_settings.txt")

-- Read the external config file if it exists.
if io.open(lavaworks.worldpath.."/lavaworks_settings.txt","r") then
	dofile(lavaworks.worldpath.."/lavaworks_settings.txt")
	io.close()
end

-- Random variables

lavaworks.expect_infinite_stacks = true
if minetest.get_modpath("unified_inventory") or not minetest.setting_getbool("creative_mode") then
	lavaworks.expect_infinite_stacks = false
end

lavaworks.meseadjlist={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=0,y=1,z=0},{x=0,y=-1,z=0},{x=1,y=0,z=0},{x=-1,y=0,z=0}}

lavaworks.rules_all = {{x=0, y=0, z=1},{x=0, y=0, z=-1},{x=1, y=0, z=0},{x=-1, y=0, z=0},
		{x=0, y=1, z=1},{x=0, y=1, z=-1},{x=1, y=1, z=0},{x=-1, y=1, z=0},
		{x=0, y=-1, z=1},{x=0, y=-1, z=-1},{x=1, y=-1, z=0},{x=-1, y=-1, z=0},
		{x=0, y=1, z=0}, {x=0, y=-1, z=0}}

lavaworks.mesecons_rules={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=1,y=0,z=0},{x=-1,y=0,z=0},{x=0,y=1,z=0},{x=0,y=-1,z=0}}

lavaworks.liquid_texture = "default_lava.png"

-- Helper functions

function lavaworks.fix_image_names(table, replacement)
	local outtable={}
	for i in ipairs(table) do
		outtable[i]=string.gsub(table[i], "_XXXXX", replacement)
	end

	return outtable
end

function lavaworks.add_node_box(t, b)
	for i in ipairs(b)
		do table.insert(t, b[i])
	end
end

function lavaworks.node_is_owned(pos, placer)
	local ownername = false
	if type(IsPlayerNodeOwner) == "function" then					-- node_ownership mod
		if HasOwner(pos, placer) then						-- returns true if the node is owned
			if not IsPlayerNodeOwner(pos, placer:get_player_name()) then
				if type(getLastOwner) == "function" then		-- ...is an old version
					ownername = getLastOwner(pos)
				elseif type(GetNodeOwnerName) == "function" then	-- ...is a recent version
					ownername = GetNodeOwnerName(pos)
				else
					ownername = S("someone")
				end
			end
		end

	elseif type(isprotect)=="function" then 					-- glomie's protection mod
		if not isprotect(5, pos, placer) then
			ownername = S("someone")
		end
	elseif type(protector)=="table" and type(protector.can_dig)=="function" then 	-- Zeg9's protection mod
		if not protector.can_dig(5, pos, placer) then
			ownername = S("someone")
		end
	end

	if ownername ~= false then
		minetest.chat_send_player( placer:get_player_name(), S("Sorry, %s owns that spot."):format(ownername) )
		return true
	else
		return false
	end
end

function lavaworks.replace_name(tbl,tr,name)
	local ntbl={}
	for key,i in pairs(tbl) do
		if type(i)=="string" then
			ntbl[key]=string.gsub(i,tr,name)
		elseif type(i)=="table" then
			ntbl[key]=lavaworks.replace_name(i,tr,name)
		else
			ntbl[key]=i
		end
	end
	return ntbl
end

-------------------------------------------
-- Load the various other parts of the mod

dofile(lavaworks.modpath.."/models.lua")
dofile(lavaworks.modpath.."/autoplace_pipes.lua")
dofile(lavaworks.modpath.."/flowing_logic.lua")
dofile(lavaworks.modpath.."/crafts.lua")

if lavaworks.enable_pipes then dofile(lavaworks.modpath.."/pipes.lua") end
if lavaworks.enable_pipe_devices then dofile(lavaworks.modpath.."/devices.lua") end

print("Pipeworks loaded!")

