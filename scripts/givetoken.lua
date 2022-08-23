function usage()
	LUALOG("***** Incorrect number of parameters passed to giveToken *****")
	LUALOG("***** USAGE (Self Targeted): gt <token name> [timeout] *****")
	LUALOG("***** USAGE (Targeted)     : gt <subject name> <token name> [timeout] *****")
end

function isToken(tokenName)
	return string.len(tokenName) > 2 and string.find(tokenName, "t_") == 1	
end

function unpackArgs(args)
	-- Inspect and validate arguments
	if args == nil or type(args) ~= "table" then
		return nil 
	end

	local argc = table.getn(args)
	local td = { timeout = "3.0" }
	if argc < 1 then
		return nil
	elseif argc < 2 then
		td.tokenName = args[1].value
		if isToken(td.tokenName) then
			td.isSelfTask = true
			if argc > 1 then	
				td.timeout = args[2].value
			end
		else
			return nil
		end
	else
		td.tokenName = args[2].value
		if isToken(td.tokenName) then
			td.isSelfTask = false
			if argc > 2 then
				td.timeout = args[3].value
			end
		else
			return nil
		end
	end

	return td 
end

function giveToken(args, useTheForce)
	local td = unpackArgs(args)
	if td == nil then
		usage()
		return
	end
	local gameMgr = queryObject("BFGManager")
	if gameMgr ~= nil then
		local subject 
		if td.isSelfTask then
			subject = gameMgr:BFG_GET_SELECTED_ENTITY()
		else
			subject = gameMgr:BFG_GET_NAMED_ENTITY(args[1].value)
		end
		if subject ~= nil then
			--local tokenInit = { _xml = "BFAIToken", Name = td.tokenName, Force = useTheForce, Timeout = td.timeout, Reconsider = "1" }
			local tokenInit = string.format("[[<BFAIToken Name=\"%s\" Force=\"%d\" Timeout=\"%.1f\" Reconsider=\"%d\" />]]", td.tokenName, useTheForce, td.timeout, 1)
			local token = loadComponent(tokenInit)
			if token ~= nil then
				if not td.isSelfTask then
					local target = gameMgr:BFG_GET_SELECTED_ENTITY()
					if target ~= nil then
						token:BFAI_SET_TOKEN_TARGET(target)
						local mainMode = queryObject("ZTMainMode")
						if mainMode ~= nil then
							mainMode:sendMessage("ZT_SET_SELECTED_ENTITY", subject)
						end
					else
						LUALOG("***** Target not found! *****")
						return
					end
				end
				LUALOG("***** Sending token: "..td.tokenName.." *****")
				subject:BFG_SEND_TOKEN(token)
			else
				LUALOG("***** Failed to create token: "..td.tokenName.." *****")
			end
		else
			LUALOG("***** Subject not found! *****")
		end
	else
		LUALOG("***** Game manager not found! *****")
	end
end

function exec1(args)
	giveToken(args, "1")
end

function exec2(args)
	giveToken(args, "0")
end
