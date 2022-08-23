function exec(args)
	local gameMgr = queryObject("BFGManager")
	if gameMgr ~= nil then
		local entity = gameMgr:BFG_GET_SELECTED_ENTITY()
		if entity ~= nil then
			if (args ~= nil) then
				local argc = table.getn(args)
				local ard = { }
				if (argc >= 1) then
					ard.seqToken = args[1].value
				end
				if (argc >= 2) then
					ard.scale = tonumber(args[2].value)
				end
				if (argc >= 3) then
					ard.time = tonumber(args[3].value)
				end

				entity:sendMessage("ANIM_REQUEST", ard)
			else
				BFLOG(SYSERROR, "***** No animation was specified! *****")
			end
		else
			BFLOG(SYSERROR, "***** No selected entity *****")
		end
	else
		BFLOG(SYSERROR, "***** Can't locate ZTMainMode! *****")
	end
end
