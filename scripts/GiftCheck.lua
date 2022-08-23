function GiftCheck (args)
	--make random roll to see if guest wants to buy a gift

	local randomNum=math.random(1,100)
	--LUALOG(SYSERROR, "RANDOM ROLL IS: "..randomNum)

	
	if (randomNum <= 50) then
		--LUALOG(SYSERROR, "GUEST DIDN'T WANT TO BUY A GIFT")
		return "complete"
	end
	
	--LUALOG(SYSERROR, "GOT PAST RANDOM FAILED")

	--make sure arguments are valid
	if (args~=nil and table.getn(args)>=2) then
		--get handle to subject
		local subject=resolveTable(args[1].value)		
		--validate subject
		if (subject~=nil) then
			--get handle to target
			local target=resolveTable(args[2].value)
			--validate target
			if (target~=nil) then
				--get the target's s_Species name so we can concatenate a token name with it
				local speciesName=target:BFG_GET_ATTR_STRING("s_Species")
				--make sure s_Species returned something valid
				if (speciesName~=nil and string.len(speciesName)>0 ) then
					--create token
					local tokenName="t_"..speciesName.."Gift"
					--create a genuine token
					local tokenInit = { _xml = "BFAIToken", Name = tokenName }
					--assign token to local variable
					local token = loadComponent(tokenInit)
					--check token's validity
					if (token~=nil) then		
						--give the token to the subject
						subject:BFG_SEND_TOKEN(token)
						--LUALOG(SYSERROR, "GUEST GOT "..tokenName.." SO THEY WANT TO BUY GIFT")						
						return "complete"
					end
				end
			end
		end
	end	
	return "error"
end