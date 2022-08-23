function canreproduce(args)
	local retval = "complete"
	if args ~= nil then
		LUALOG("args is "..table.getn(args).." elements")
		local firstarg = args[1]
		if firstarg ~= nil then
		    local motherhandle = firstarg.value
		    if motherhandle ~= nil then
				local mother = resolveTable(motherhandle)
				if mother ~= nil then
				
					local childList = mother:sendMessage("BFAI_GET_RELATED_ENTITIES", "child")
					if childList ~= nil and type(childList) == "table" then
						LUALOG("Found "..table.getn(childList).." children")
						table.foreachi(
							childList,
							function (i, v)
								local child = resolveTable(v.value)
								if child ~= nil then
								    local isAdult = child:BFG_GET_ATTR_BOOLEAN("b_Adult")
								    if isAdult == false then
										retval = "failure"
								    end
								end
							end
						)
						return retval
					else
						LUALOG("No children found")
					end
				else
					LUALOG("couldn't resolve subject entity pointer")
				end
			else
				LUALOG("couldn't resolve subject handle")
			end
		else
			LUALOG("couldn't parse second argument")
		end
	end
	
	return retval
end
