function exec(args)
	local gameMgr = queryObject("BFGManager")
	if gameMgr ~= nil then
		local entity = gameMgr:BFG_GET_SELECTED_ENTITY()
		if entity ~= nil then
			local argc = table.getn(args)
			if args ~= nil and argc > 0 then
				local attrs = {
					"hunger",
					"thirst",
					"bathroom",
					"stimulation",
					"exercise",
					"reproduction",
					"privacy",
					"rest",
					"hygiene",
					"lifespan",
					"social",
					"health",
					"environment",
					"biome",
					"f_needPointsGood",
					"f_needPointsBad"
				}
				local sa = {}
				for i, a in ipairs(attrs) do
					sa.name = a
					sa.value = 0
					entity:BFG_SET_ATTR_FLOAT(sa)	
				end
				sa.name = args[1].value
				if (argc >= 2) then
					sa.value = tonumber(args[2].value)
				else
					sa.value = 100.0
				end
				entity:BFG_SET_ATTR_FLOAT(sa)
				sa.name = "f_needPointsGood"
				sa.value = 100.0
				entity:BFG_SET_ATTR_FLOAT(sa)
			else
				LUALOG("***** USAGE: so <attribute> [value] *****")
			end
		else
			LUALOG("***** No entity selected *****")
		end
	else
		LUALOG("***** Game manager not found! *****")
	end
end
