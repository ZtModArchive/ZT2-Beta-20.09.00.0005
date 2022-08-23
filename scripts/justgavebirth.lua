function justgavebirth(args)
	if args ~= nil then
		LUALOG("args is "..table.getn(args).." elements")
		local firstarg = args[1]
		if firstarg ~= nil then
		    local motherhandle = firstarg.value
		    if motherhandle ~= nil then
				local mother = resolveTable(motherhandle)
				if mother ~= nil then
				
					-- Check to see if this mother has a mother
					local motherList = mother:sendMessage("BFAI_GET_RELATED_ENTITIES", "mother");
					if motherList ~= nil and type(motherList) == "table" then
						table.foreachi(
							motherList,
							function (i, v)
								local grandmother = resolveTable(v.value);
								if (grandmother ~= nil) then
								
									-- Give all of the children the grandmother relationship
									local childList = mother:sendMessage("BFAI_GET_RELATED_ENTITIES", "child")
									if childList ~= nil and type(childList) == "table" then
										LUALOG("Found "..table.getn(childList).." children")
										table.foreachi(
											childList,
											function (i, v)
												local child = resolveTable(v.value)
												if child ~= nil then
													local rd = { };
													rd.relation = "grandmother"
													rd.target = grandmother
													child:sendMessage("BFAI_ADD_RELATIONSHIP", rd)
												end
											end
										)
									else
										LUALOG("No children found")
									end
								end
							end
						)
					end
					
				
					local father = nil
				
					local mateList = mother:sendMessage("BFAI_GET_RELATED_ENTITIES", "mate")
					if mateList ~= nil and type(mateList) == "table" then
						LUALOG("Found "..table.getn(mateList).." mates")
						table.foreachi(
							mateList,
							function (i, v)
								local mate = resolveTable(v.value)
								if mate ~= nil then
									father = mate
								end
							end
						)
					else
						LUALOG("No mates found, so children are fatherless")
					end
				
					local childList = mother:sendMessage("BFAI_GET_RELATED_ENTITIES", "child")
					if childList ~= nil and type(childList) == "table" then
						LUALOG("Found "..table.getn(childList).." children")
						table.foreachi(
							childList,
							function (i, v)
								local child = resolveTable(v.value)
								if child ~= nil then
									local rd = {}
									rd.relation = "mother"
									rd.target = mother
									child:sendMessage("BFAI_ADD_RELATIONSHIP", rd)
									if father ~= nil then
										rd.relation = "father"
										rd.target = father
										child:sendMessage("BFAI_ADD_RELATIONSHIP", rd)
									end
								end
							end
						)
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
	
	return "complete"
end
