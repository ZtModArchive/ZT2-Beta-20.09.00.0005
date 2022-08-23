-- lua file for world campaign 

----------------------------------------------------------------------------------


-- Include statements
include "scenario/scripts/misc.lua";
include "scenario/scripts/ui.lua";
include "scenario/scripts/entity.lua";
include "scenario/scripts/needs.lua";
include "scenario/scripts/economy.lua";




--------------------
-- SCENARIO 1
-------------------


function evalamericananimals()
-- player needs to place 3 animals from North America
	-- possible animals are:
		-- BeaverAmerican
		-- BearGrizzly
		-- BearPolar
		-- Moose
-- And have enough others so that the NA ones are <= 30% of the total

	BFLOG(SYSTRACE, "evalamericananimals");

	local northamericanlist = { };
	northamericanlist[1] = "BeaverAmerican";
	northamericanlist[2] = "BearGrizzly";
	northamericanlist[3] = "BearPolar";
	northamericanlist[4] = "Moose";
	
	local howmanyna = howManyInTableExist(northamericanlist);
	
	-- If they have at least 3 NA animals
	if (howmanyna >= 3) then
		local totalanimals = howManyAnimalsInZoo();
		BFLOG(SYSTRACE, "howmanyna: "..howmanyna.."   totalanimals: "..totalanimals..".");
		
		BFLOG(SYSTRACE, "diff: "..howmanyna/totalanimals..".");
		
		-- Make sure they have less than 30% of their animals from NA
		if (howmanyna / totalanimals < .3) then
			return 1;
		end
	end
	
	return 0;
end


function completeamericananimals()
end


-- not sure if we want to display progress goals (see scenario 3)? if so additional rules needed
-- if we do, I still need to write locids


function completeworldcampaignscen1()
	BFLOG(SYSTRACE, "completeworldcampaignscen1");

	-- unlock world campaign scenario 2
	local alreadydone = getuservar("worldcampaignscenario2");
	
	if (alreadydone ~= "completed") then
		setuservar("worldcampaignscenario2", "unlocked");
	end
	
	setuservar("worldcampaignscenario1", "completed");
	
	showscenariowin("TheWorld:AmericanAnimalsSuccessoverview", "worldcampaignscenario2");
end



--------------------
-- SCENARIO 2
-------------------


function evalasiananimals()
-- player has 1 year to get three animals from Asia
-- possible animals are
	-- Red Panda
	-- Giant Panda
	-- Ibex
	-- Bengal Tiger
	-- Snow Leopard
	
	
	local asialist = { };
	asialist[1] = "PandaRed";
	asialist[2] = "PandaGiant";
	asialist[3] = "Ibex";
	asialist[4] = "TigerBengal";
	asialist[5] = "LeopardSnow";
	
	-- Check to see if they have three Asia animals
	local howmanyasia = howManyInTableExist(asialist);
	
	BFLOG(SYSTRACE, "Asia animals: "..howmanyasia..".");
	
	-- If they have at least 3 NA animals
	if (howmanyasia >= 3) then
		return 1;
	end
	
	
	-- If a year has gone by then they fail
	local monthnow = getCurrentMonth();
	if (monthnow >= 12) then
		return -1;
	end
	
	return 0;
end


function completeasiananimals()
end


-- not sure if we want to display progress goals (see scenario 3)? if so additional rules needed
-- if we do, I still need to write locids


function completeworldcampaignscen2()
	-- unlock scenario 3
	BFLOG(SYSTRACE, "completeworldcampaignscen2");

	-- unlock world campaign scenario 2
	local alreadydone = getuservar("worldcampaignscenario3");
	
	if (alreadydone ~= "completed") then
		setuservar("worldcampaignscenario3", "unlocked");
	end
	
	setuservar("worldcampaignscenario2", "completed");
	
	showscenariowin("TheWorld:AsianAnimalsSuccessoverview", "worldcampaignscenario3");
end

function failworldcampaignscen2()
-- time frame expires... 

	showscenariofail("TheWorld:AsianAnimalsFailureoverview", "worldcampaignscenario2");
end


--------------------
-- SCENARIO 3
-------------------

-- in zoo setup for this scenario:
-- need to disable the put up for adoption button. The only way people can get rid of an
-- animals is to release it to the wild!

function setinitialzoostatescen3(comp)
	BFLOG(SYSTRACE, "setinitialzoostatescen3");
	
	return 1;
end


function evalafricananimalsoverall(comp)
-- we need 12 different animals from Africa
	-- possible animals are:
		-- CamelDromedary
		-- Chimpanzee
		-- Okapi
		-- GorillaMountain
		-- Lion
		-- Cheetah
		-- Giraffe
		-- ElephantAfrican
		-- GazelleThomsons
		-- ZebraCommon
		-- RhinocerosBlack
		-- Ostrich
		-- Gemsbok
		-- FlamingoGreater
		-- Hippopotamus
		
-- each time a new species is added, player should get a $1500 cash grant and a
	-- new goal line is added. this line functions as a "counter"
		-- a whack of additonal "rules" are in the goal xml... need to determine best way to incorporate them
	-- e.g. <AfricanAnimalhave2>You have two animals from Africa in your park!</AfricanAnimalhave2>
	-- they can only receive the grant 12 times
-- additional animals of the same type do not add cash
-- if they lose one of the animals, no cash is deducted, and if an new species gets added
	-- they can get the cash (even if its for the same animal) but they can only 
	-- get the cash 12 times max so no big deal
	-- the "counter" goal needs to decrement if they lose an animal
-- once they get the 12 african animals, if they still have animals from other regions, then they need to be
	-- shown another goal as a reminder.. 
		-- <AfricanAnimalgetridofothers>You have enough animals from Africa but you need to release to the wild animals from any other world region.</AfricanAnimalgetridofothers>

	BFLOG(SYSTRACE, "evalafricananimalsoverall");


	if (comp.grantsgiven == nil) then
		comp.grantsgiven = 0;
	end
	
	if (comp.animalcount == nil) then
		comp.animalcount = 0;
	end

	local africalist = { };
	africalist[1] = "CamelDromedary";
	africalist[2] = "Chimpanzee";
	africalist[3] = "Okapi";
	africalist[4] = "GorillaMountain";
	africalist[5] = "Lion";
	africalist[6] = "Cheetah";
	africalist[7] = "Giraffe";
	africalist[8] = "ElephantAfrican";
	africalist[9] = "GazelleThomsons";
	africalist[10] = "ZebraCommon";
	africalist[11] = "RhinocerosBlack";
	africalist[12] = "Ostrich";
	africalist[13] = "Gemsbok";
	africalist[14] = "FlamingoGreater";
	africalist[15] = "Hippopotamus";
	
	-- How many africa animals do they have
	local howmanyafrica = howManyInTableExist(africalist);
	BFLOG(SYSTRACE, "Africa animals: "..howmanyafrica..".");
	
	-- If they have a new animal
	if (howmanyafrica > comp.animalcount) then
		comp.animalcount = comp.animalcount + 1;
		
		if (comp.grantsgiven < 12) then
			giveCash(1500);
		end
	end
	
	if (howmanyafrica >= 12) then
		return 1;
	end
	
	return 0;
end


function completeafricananimalsoverall()
end


function completeworldcampaignscen3()
-- end of african animals empire... unlock scenario 4
	-- unlock scenario 3
	BFLOG(SYSTRACE, "completeworldcampaignscen3");

	-- unlock world campaign scenario 2
	local alreadydone = getuservar("worldcampaignscenario5");
	
	if (alreadydone ~= "completed") then
		setuservar("worldcampaignscenario5", "unlocked");
	end
	
	setuservar("worldcampaignscenario4", "completed");
	
	showscenariowin("TheWorld:AfricanAnimalsSuccessoverview", "worldcampaignscenario5");

end


--------------------
-- SCENARIO 4
-------------------


function evalhugebiome()
-- player has to create a savannah exhibt and have 4 carnivores and 6 herbivores within the same traversable
-- area for 4 months without the herbivore getting attacked or eaten
	-- possible animals are:
		-- carnivores: cheetah & lion
		-- herbivores: giraffe, zebra,(and gazelle probably)... 
	-- their environment needs also need to be met (that's to ensure that they are really Savannah animals : )


end


function completeworldcampaignscen4()
-- unlock scenario 5
end



function failworldcampaignscen4()
-- an animal was ...EATEN! (or just attacked : )
-- would be nice if we could differentiate the failure message depending on whether the eaten event was
	-- viewed by a guest or not... 
end



--------------------
-- SCENARIO 5
-------------------


function setinitialzoostate(comp)
	BFLOG(SYSTRACE, "*********I'm here so show overview panel!********");
	completeshowoverview()
	showUI("goal panel", true);

	return 1;
end


function evalalpine()
-- check for animal of alpine biome and ensure environment need is met
-- possible animals are snow leopard, ibex

	BFLOG(SYSTRACE, "evalalpine");

	local animaltable = { };
	animaltable[1] = "LeopardSnow";
	animaltable[2] = "Ibex";

	if (animalTableSatisfied(animaltable, "environment") == true) then
		return 1;
	end
	
	return 0;

end



function evalborealforest()
-- check for animal of boreal forest biome and ensure environment need is met
-- possible animals are grizzly bear, moose

	BFLOG(SYSTRACE, "evalborealforest");

	local animaltable = { };
	animaltable[1] = "BearGrizzly";
	animaltable[2] = "Moose";

	if (animalTableSatisfied(animaltable, "environment") == true) then
		return 1;
	end
	
	return 0;


end



function evaldesert()
-- check for animal of desert biome and ensure environment need is met
-- possible animals are camel

	BFLOG(SYSTRACE, "evaldesert");

	local animaltable = { };
	animaltable[1] = "CamelDromedary";

	if (animalTableSatisfied(animaltable, "environment") == true) then
		return 1;
	end
	
	return 0;
end


function evalsavannah()
-- check for animal of savannah biome and ensure environment need is met
-- possible animals are lion, cheetah, giraffe, elephant, gazelle, zebra, rhino, ostrich

	BFLOG(SYSTRACE, "evalsavannah");

	local animaltable = { };
	animaltable[1] = "Lion";
	animaltable[2] = "Cheetah";
	animaltable[3] = "Giraffe";
	animaltable[4] = "ElephantAfrican";
	animaltable[5] = "GazelleThomsons";
	animaltable[6] = "ZebraCommon";
	animaltable[7] = "RhinocerosBlack";
	animaltable[8] = "Ostrich";

	if (animalTableSatisfied(animaltable, "environment") == true) then
		return 1;
	end
	
	return 0;

end


function evalscrub()
-- check for animal of scrub biome and ensure environment need is met
-- possible animals are kangaroo, gemsbok

	BFLOG(SYSTRACE, "evalscrub");

	local animaltable = { };
	animaltable[1] = "KangarooRed";
	animaltable[2] = "Gemsbok";

	if (animalTableSatisfied(animaltable, "environment") == true) then
		return 1;
	end
	
	return 0;


end


function evaltemperateforest()
-- check for animal of temperate forest biome and ensure environment need is met
-- possible animals are peafowl, red panda, giant panda

	BFLOG(SYSTRACE, "evaltemperateforest");

	local animaltable = { };
	animaltable[1] = "PeafowlCommon";
	animaltable[2] = "PandaRed";
	animaltable[3] = "PandaGiant";

	if (animalTableSatisfied(animaltable, "environment") == true) then
		return 1;
	end
	
	return 0;


end


function evaltropicalrainforest()
-- check for animal of tropical rainforest biome and ensure environment need is met
-- possible animals are chimp, okapi, lemur, jaguar, tiger, gorilla

	BFLOG(SYSTRACE, "evaltropicalrainforest");

	local animaltable = { };
	animaltable[1] = "Chimpanzee";
	animaltable[2] = "Okapi";
	animaltable[3] = "LemurRingtailed";
	animaltable[4] = "Jaguar";
	animaltable[5] = "TigerBengal";
	animaltable[6] = "GorillaMountain";

	if (animalTableSatisfied(animaltable, "environment") == true) then
		return 1;
	end
	
	return 0;


end


function evaltundra()
-- check for animal of tundra biome and ensure environment need is met
-- possible animals are polar bear, penguin

	BFLOG(SYSTRACE, "evaltundra");

	local animaltable = { };
	animaltable[1] = "BearPolar";
	animaltable[2] = "PenguinEmperor";

	if (animalTableSatisfied(animaltable, "environment") == true) then
		return 1;
	end
	
	return 0;


end


function evalwetlands()
-- check for animal of wetlands biome and ensure environment need is met
-- possible animals are flamingo, hippo, croc, beaver

	BFLOG(SYSTRACE, "evalwetlands");

	local animaltable = { };
	animaltable[1] = "FlamingoGreater";
	animaltable[2] = "Hippopotamus";
	animaltable[3] = "CrocodileNile";
	animaltable[4] = "BeaverAmerican";

	if (animalTableSatisfied(animaltable, "environment") == true) then
		return 1;
	end
	
	return 0;

end



function completeworldcampaignscen5()
-- the end of the world... campaign
-- give out the globe monument reward item
-- locked with s_ProfileLock="globelock" 

	BFLOG(SYSTRACE, "completeworldcampaignscen5");

	setuservar("worldcampaignscenario5", "completed");
	
	-- Unlock the globe monument
	setuservar("globelock", "true");
	
	showscenariowinhidenext("TheWorld:TheWorldsBiomesSuccessoverview");
end