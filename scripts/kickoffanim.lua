function kickoffanim(args)
	if args ~= nil then
		LUALOG(SYSMSG, "args is "..table.getn(args).." elements")
		local secondarg = args[2]
		if secondarg ~= nil then
		    local targethandle = secondarg.value
		    if targethandle ~= nil then
				local target = resolveTable(targethandle)
				if target ~= nil then
					target:sendMessage("BFG_SETPHYSANIM","used")
				else
					LUALOG(SYSERROR, "couldn't resolve target entity pointer")
				end
			else
				LUALOG(SYSERROR, "couldn't resolve target handle")
			end
		else
			LUALOG(SYSERROR, "couldn't parse second argument")
		end
	end
	
	return "complete"
end
