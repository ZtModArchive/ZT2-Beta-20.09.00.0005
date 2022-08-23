function print()
	LUALOG("***** Dumping Globals (_G) *****")
	local count = 0
	for i in pairs(_G) do
		count = count + 1
		LUALOG(tostring(count).." : "..i)
	end
	LUALOG("***** Dumping Globals (_BF) *****")
	local count = 0
	for i in pairs(_BF) do
		count = count + 1
		LUALOG(tostring(count).." : "..i)
	end
end
