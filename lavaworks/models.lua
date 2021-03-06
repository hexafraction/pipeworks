
---------------------
-- The various models

-- Pipe models

lavaworks.pipe_leftstub = {
	{ -32/64, -2/64, -6/64,   1/64, 2/64, 6/64 },	-- pipe segment against -X face
	{ -32/64, -4/64, -5/64,   1/64, 4/64, 5/64 },
	{ -32/64, -5/64, -4/64,   1/64, 5/64, 4/64 },
	{ -32/64, -6/64, -2/64,   1/64, 6/64, 2/64 },

	{ -32/64, -3/64, -8/64, -30/64, 3/64, 8/64 },	-- (the flange for it)
	{ -32/64, -5/64, -7/64, -30/64, 5/64, 7/64 },
	{ -32/64, -6/64, -6/64, -30/64, 6/64, 6/64 },
	{ -32/64, -7/64, -5/64, -30/64, 7/64, 5/64 },
	{ -32/64, -8/64, -3/64, -30/64, 8/64, 3/64 }
}

lavaworks.pipe_rightstub = {
	{ -1/64, -2/64, -6/64,  32/64, 2/64, 6/64 },	-- pipe segment against +X face
	{ -1/64, -4/64, -5/64,  32/64, 4/64, 5/64 },
	{ -1/64, -5/64, -4/64,  32/64, 5/64, 4/64 },
	{ -1/64, -6/64, -2/64,  32/64, 6/64, 2/64 },

	{ 30/64, -3/64, -8/64, 32/64, 3/64, 8/64 },	-- (the flange for it)
	{ 30/64, -5/64, -7/64, 32/64, 5/64, 7/64 },
	{ 30/64, -6/64, -6/64, 32/64, 6/64, 6/64 },
	{ 30/64, -7/64, -5/64, 32/64, 7/64, 5/64 },
	{ 30/64, -8/64, -3/64, 32/64, 8/64, 3/64 }
}

lavaworks.pipe_bottomstub = {
	{ -2/64, -32/64, -6/64,   2/64, 1/64, 6/64 },	-- pipe segment against -Y face
	{ -4/64, -32/64, -5/64,   4/64, 1/64, 5/64 },
	{ -5/64, -32/64, -4/64,   5/64, 1/64, 4/64 },
	{ -6/64, -32/64, -2/64,   6/64, 1/64, 2/64 },

	{ -3/64, -32/64, -8/64, 3/64, -30/64, 8/64 },	-- (the flange for it)
	{ -5/64, -32/64, -7/64, 5/64, -30/64, 7/64 },
	{ -6/64, -32/64, -6/64, 6/64, -30/64, 6/64 },
	{ -7/64, -32/64, -5/64, 7/64, -30/64, 5/64 },
	{ -8/64, -32/64, -3/64, 8/64, -30/64, 3/64 }
}

lavaworks.pipe_topstub = {
	{ -2/64, -1/64, -6/64,   2/64, 32/64, 6/64 },	-- pipe segment against +Y face
	{ -4/64, -1/64, -5/64,   4/64, 32/64, 5/64 },
	{ -5/64, -1/64, -4/64,   5/64, 32/64, 4/64 },
	{ -6/64, -1/64, -2/64,   6/64, 32/64, 2/64 },

	{ -3/64, 30/64, -8/64, 3/64, 32/64, 8/64 },	-- (the flange for it)
	{ -5/64, 30/64, -7/64, 5/64, 32/64, 7/64 },
	{ -6/64, 30/64, -6/64, 6/64, 32/64, 6/64 },
	{ -7/64, 30/64, -5/64, 7/64, 32/64, 5/64 },
	{ -8/64, 30/64, -3/64, 8/64, 32/64, 3/64 }
}

lavaworks.pipe_frontstub = {
	{ -6/64, -2/64, -32/64,   6/64, 2/64, 1/64 },	-- pipe segment against -Z face
	{ -5/64, -4/64, -32/64,   5/64, 4/64, 1/64 },
	{ -4/64, -5/64, -32/64,   4/64, 5/64, 1/64 },
	{ -2/64, -6/64, -32/64,   2/64, 6/64, 1/64 },

	{ -8/64, -3/64, -32/64, 8/64, 3/64, -30/64 },	-- (the flange for it)
	{ -7/64, -5/64, -32/64, 7/64, 5/64, -30/64 },
	{ -6/64, -6/64, -32/64, 6/64, 6/64, -30/64 },
	{ -5/64, -7/64, -32/64, 5/64, 7/64, -30/64 },
	{ -3/64, -8/64, -32/64, 3/64, 8/64, -30/64 }
}

lavaworks.pipe_backstub = {
	{ -6/64, -2/64, -1/64,   6/64, 2/64, 32/64 },	-- pipe segment against -Z face
	{ -5/64, -4/64, -1/64,   5/64, 4/64, 32/64 },
	{ -4/64, -5/64, -1/64,   4/64, 5/64, 32/64 },
	{ -2/64, -6/64, -1/64,   2/64, 6/64, 32/64 },

	{ -8/64, -3/64, 30/64, 8/64, 3/64, 32/64 },	-- (the flange for it)
	{ -7/64, -5/64, 30/64, 7/64, 5/64, 32/64 },
	{ -6/64, -6/64, 30/64, 6/64, 6/64, 32/64 },
	{ -5/64, -7/64, 30/64, 5/64, 7/64, 32/64 },
	{ -3/64, -8/64, 30/64, 3/64, 8/64, 32/64 }
} 

lavaworks.pipe_boxes = {lavaworks.pipe_leftstub, lavaworks.pipe_rightstub, lavaworks.pipe_bottomstub, lavaworks.pipe_topstub, lavaworks.pipe_frontstub, lavaworks.pipe_backstub}

lavaworks.pipe_selectboxes = {
	{ -32/64,  -8/64,  -8/64,  8/64,  8/64,  8/64 },
	{ -8/64 ,  -8/64,  -8/64, 32/64,  8/64,  8/64 },
	{ -8/64 , -32/64,  -8/64,  8/64,  8/64,  8/64 },
	{ -8/64 ,  -8/64,  -8/64,  8/64, 32/64,  8/64 },
	{ -8/64 ,  -8/64, -32/64,  8/64,  8/64,  8/64 },
	{ -8/64 ,  -8/64,  -8/64,  8/64,  8/64, 32/64 }
}

lavaworks.pipe_bendsphere = {	
	{ -4/64, -4/64, -4/64, 4/64, 4/64, 4/64 },
	{ -5/64, -3/64, -3/64, 5/64, 3/64, 3/64 },
	{ -3/64, -5/64, -3/64, 3/64, 5/64, 3/64 },
	{ -3/64, -3/64, -5/64, 3/64, 3/64, 5/64 }
}



-- Device models

lavaworks.pipe_pumpbody = {
	{ -7/16, -6/16, -7/16, 7/16,  5/16, 7/16 },
	{ -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 }
}

lavaworks.pipe_valvebody = {
	{ -4/16, -4/16, -4/16, 4/16, 4/16, 4/16 }
}

lavaworks.pipe_valvehandle_on = {
	{ -5/16, 4/16, -1/16, 0, 5/16, 1/16 }
}

lavaworks.pipe_valvehandle_off = {
	{ -1/16, 4/16, -5/16, 1/16, 5/16, 0 }
}

lavaworks.pipe_sensorbody = {
	{ -3/16, -2/16, -2/16, 3/16, 2/16, 2/16 }
}

lavaworks.spigot_bottomstub = {
	{ -2/64, -16/64, -6/64,   2/64, 1/64, 6/64 },	-- pipe segment against -Y face
	{ -4/64, -16/64, -5/64,   4/64, 1/64, 5/64 },
	{ -5/64, -16/64, -4/64,   5/64, 1/64, 4/64 },
	{ -6/64, -16/64, -2/64,   6/64, 1/64, 2/64 },

	{ -3/64, -16/64, -8/64, 3/64, -14/64, 8/64 },	-- (the flange for it)
	{ -5/64, -16/64, -7/64, 5/64, -14/64, 7/64 },
	{ -6/64, -16/64, -6/64, 6/64, -14/64, 6/64 },
	{ -7/64, -16/64, -5/64, 7/64, -14/64, 5/64 },
	{ -8/64, -16/64, -3/64, 8/64, -14/64, 3/64 }
}

lavaworks.spigot_stream = { 
	{ -3/64, (-41/64)-0.01, -5/64, 3/64, -16/64, 5/64 },
	{ -4/64, (-41/64)-0.01, -4/64, 4/64, -16/64, 4/64 },
	{ -5/64, (-41/64)-0.01, -3/64, 5/64, -16/64, 3/64 }
}

lavaworks.entry_panel = {
	{ -8/16, -8/16, -1/16, 8/16, 8/16, 1/16 }
}

lavaworks.fountainhead_model = {
	{ -2/64, -32/64, -6/64,   2/64, 21/64, 6/64 },	-- main segment
	{ -4/64, -32/64, -5/64,   4/64, 21/64, 5/64 },
	{ -5/64, -32/64, -4/64,   5/64, 21/64, 4/64 },
	{ -6/64, -32/64, -2/64,   6/64, 21/64, 2/64 },

	{ -3/64, -32/64, -8/64, 3/64, -30/64, 8/64 },	-- bottom flange
	{ -5/64, -32/64, -7/64, 5/64, -30/64, 7/64 },
	{ -6/64, -32/64, -6/64, 6/64, -30/64, 6/64 },
	{ -7/64, -32/64, -5/64, 7/64, -30/64, 5/64 },
	{ -8/64, -32/64, -3/64, 8/64, -30/64, 3/64 },

	{ -3/64, 20/64, -8/64, 3/64, 32/64, 8/64 },	-- top flange/outlet
	{ -5/64, 20/64, -7/64, 5/64, 32/64, 7/64 },
	{ -6/64, 20/64, -6/64, 6/64, 32/64, 6/64 },
	{ -7/64, 20/64, -5/64, 7/64, 32/64, 5/64 },
	{ -8/64, 20/64, -3/64, 8/64, 32/64, 3/64 }
}
