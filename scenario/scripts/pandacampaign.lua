-- lua file for panda campaign 

----------------------------------------------------------------------------------


-- Include statements
include "scenario/scripts/misc.lua";
include "scenario/scripts/ui.lua";
include "scenario/scripts/entity.lua";
include "scenario/scripts/needs.lua";
include "scenario/scripts/economy.lua";


function setinitialzoostate(comp)
	BFLOG(SYSTRACE, "*********I'm here so show overview panel!********");
	completeshowoverview()
	showUI("goal panel", true);

	return 1;
end


--------------------
-- SCENARIO 1
-------------------


function evalpandasadopt()
	-- starting from scratch, player needs to build a 5 star zoo and obtain one MALE panda
	
	-- If their fame is >= 91 then they have a 5 star zoo
	local zoofame = getZooFame();
	if (zoofame >= 91) then
		-- Now check to make sure they have one male panda
		if (thisManyExist("PandaGiant_Adult_M", 1) == true) then
			return 1;
		end
	end
	
	return 0;
end

function completepandasadopt()
	BFLOG(SYSTRACE, "completepandasadopt");
	
	-- Give them the new panda in a crate
	placeObject("PandaGiant_Adult_F", 85, 35, 0);
	local entitytocrate = findType("PandaGiant_Adult_F");
	local single = resolveTable(entitytocrate[1].value);
	crateEntity(single);

	-- Show the next rule and the goal panel
	showRule("Pandasbreed");
	showprimarygoals();
end

function evalpandasbreed()

-- now that they have one MALE panda, we give them the female
-- female panda needs to be named... "Aki"
-- meet the advanced needs of both pandas such that they breed

-- alternatively, if they placed a female first, then put down a male, we can still give them aki
-- but we don't care who the baby panda's mother is.

	BFLOG(SYSTRACE, "evalpandasbreed");
	
	-- If there is at least one little baby panda, then it's satisfied
	if (thisManyExist("PandaGiant_Young", 1) == true) then
		return 1;
	end

	return 0;
end


function completepandasbreed()
	BFLOG(SYSTRACE, "completepandasbreed");

	showprimarygoals();
end


function completepandas()
-- the end... give out panda statue as reward
-- item locked with s_ProfileLock="pandalock"

	setuservar("pandalock", "true");

	BFLOG(SYSTRACE, "completepandas");

end