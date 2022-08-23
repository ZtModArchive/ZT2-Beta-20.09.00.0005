function exec(args)
	local gameMgr = queryObject("BFGManager")
	if gameMgr == nil then
		LUALOG(SYSERROR, "***** Can't find the game manager! *****")
		return
	end
	local mode = queryObject("ZTMode")
	if mode == nil then
		LUALOG(SYSERROR, "***** Can't find the UI root mode! *****")
		return
	end
	local entityType = args[1].value
	local entityList = gameMgr:BFG_GET_ENTITIES(entityType)
	if entityList ~= nil and type(entityList) == "table" then
		LUALOG("***** Found "..table.getn(entityList).." entities of type "..entityType.." *****")
		local selectedEntity = gameMgr:BFG_GET_SELECTED_ENTITY()
		table.foreachi(
			entityList,
			function (i, v)
				local obj = resolveTable(v.value)
				if obj ~= nil then
					LUALOG("***** Selecting "..entityType.." #"..i.." *****")
					mode:sendMessage("ZT_SET_SELECTED_ENTITY", obj)
					local start = os.clock()
					local delay = 2.0
					while os.clock() - start < delay do
						gameMgr:BFG_UPDATEONCE()
					end
				end
			end
		)
		mode:sendMessage("ZT_SET_SELECTED_ENTITY", selectedEntity)
	else
		LUALOG(SYSERROR, "***** Could not get a valid entity list! *****")
	end
end
