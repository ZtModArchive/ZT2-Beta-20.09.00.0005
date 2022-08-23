-- lua file for species survival campaign 

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

-- disable animal adoption button... player only has animals placed in scenario and those that they breed


function evalvulnerableanimalsbreeding(comp)
-- player needs to put 6 animals up for adoption (e.g. not release to wild but up for adoption button)
-- but CANNOT go below the number of animals placed originally. They must maintain a mixed gender group
-- of animals. If for any reason they go below the original animals placed, or end up with only males or 
-- females, then the scenario is failed.

-- Starting animal male and female "pairs" in map -- these will be the only animals in map
	-- Cheetah, hippo beaver, ibex

-- for every animal they put up for adoption, they receive a cash grant of $3000

-- once they've done 6 adoptions, yet still have the original animals, they win!

-- there are a number of hidden empty rules that are just for locids for keeping track of how many
-- animals have been released (e.g. animaloneadopted through animalfiveadopted).. these should be shown in their
-- success state whenever a new animal is put up for adoption so player knows how many more to go 
-- animal six wins the scenario


	-- First we need to make sure that they still have a male and female of each species
	-- Otherwise they fail
	if (existMale("Cheetah") == false) or (existFemale("Cheetah") == false) then
		BFLOG(SYSTRACE, "No cheetahs!  Fail");
		return -1;
	end
	
	if (existMale("Ibex") == false) or (existFemale("Ibex") == false) then
		BFLOG(SYSTRACE, "No ibex!  Fail");
		return -1;
	end

	if (existMale("BeaverAmerican") == false) or (existFemale("BeaverAmerican") == false) then
		BFLOG(SYSTRACE, "No beavers!  Fail");
		return -1;
	end

	if (existMale("Hippopotamus") == false) or (existFemale("Hippopotamus") == false) then
		BFLOG(SYSTRACE, "No hippos!  Fail");
		return -1;
	end

	local numadoptions = getAnimalsPutUpForAdoption();
	
	if (comp.countadoptions == nil) then
		comp.countadoptions = 0;
	end
	
	BFLOG(SYSTRACE, "Num adoptions: "..comp.countadoptions..".");

	-- If they have a new adoption, give them $3000 and show the rules
	if (numadoptions > comp.countadoptions) then
		comp.countadoptions = numadoptions;
		giveCash(3000);
		
		if (comp.countadoptions == 1) then
			showRule("animaloneadopted");
		elseif (comp.countadoptions == 2) then
			showRule("animaltwoadopted");
		elseif (comp.countadoptions == 3) then
			showRule("animalthreeadopted");
		elseif (comp.countadoptions == 4) then
			showRule("animalfouradopted");
		elseif (comp.countadoptions == 5) then
			showRule("animalfiveadopted");
		elseif (comp.countadoptions == 6) then
			showRule("animalsixadopted");
		end
		
	end

	if (comp.countadoptions == 6) then
		return 1;
	end

end


function completevulnerableanimalsbreeding()
-- unlock scenario 2
-- show overview panel

	BFLOG(SYSTRACE, "completevulnerableanimalsbreeding");

	-- unlock world campaign scenario 2
	local alreadydone = getuservar("SpeciesSurvivalscenario2");
	
	if (alreadydone ~= "completed") then
		setuservar("SpeciesSurvivalscenario2", "unlocked");
	end
	
	setuservar("SpeciesSurvivalscenario1", "completed");
	
	showscenariowin("SpeciesSurvival:VulnerableAnimalsSuccessoverview", "SpeciesSurvivalscenario2");

end

function failvulnerableanimalsbreeding()
-- scenario is failed when the player can no longer successfully "breed" new animals (e.g. they no longer have a 
-- male and a female either through putting too many up for adoption or animal deaths

	showscenariofail("TheWorld:AsianAnimalsFailureoverview", "SpeciesSurvivalscenario1");
end



--------------------
-- SCENARIO 2
-------------------

--- preplaced animals



function evalbreedgorilla()
	-- If they have a baby then return 1
	if (existNumChildren("GorillaMountain", 1) == true) then
		return 1;
	end
	
	-- If they don't have a male and a female, return -1
	if (existMale("GorillaMountain") == false) or (existFemale("GorillaMountain") == false) then
		return -1;
	end
	
	return 0;
end

function completebreedgorilla()
	showprimarygoals();
end

function evalbreedredpanda()
	-- If they have a baby then return 1
	if (existNumChildren("PandaRed", 1) == true) then
		return 1;
	end
	
	-- If they don't have a male and a female, return -1
	if (existMale("PandaRed") == false) or (existFemale("PandaRed") == false) then
		return -1;
	end
	
	return 0;
end

function completebreedredpanda()
	showprimarygoals();
end

function evalbreedsnowleopard()
	-- If they have a baby then return 1
	if (existNumChildren("LeopardSnow", 1) == true) then
		return 1;
	end
	
	-- If they don't have a male and a female, return -1
	if (existMale("LeopardSnow") == false) or (existFemale("LeopardSnow") == false) then
		return -1;
	end
	
	return 0;
end

function completebreedsnowleopard()
	showprimarygoals();
end


function completebreedendangeredanimals()
-- breeding done, show rule group endangeredanimalsdonations which has the following rules in it:
	-- gorilladonations
	-- redpandadonations
	-- snowleoparddonations
	
	showprimarygoals();
end



function evaldonationsgorilla()
	-- Check to see if they have $2000 in donations for this animal species
	local amount = getDonations("GorillaMountain");
	
	if (amount >= 2000) then
		return 1;
	end

	return 0;
end

function completedonationsgorilla()
	showprimarygoals();
end

function evaldonationsredpanda()
	-- Check to see if they have $2000 in donations for this animal species
	local amount = getDonations("PandaRed");
	
	if (amount >= 2000) then
		return 1;
	end

	return 0;
end

function completedonationsredpanda()
	showprimarygoals();
end

function evaldonationssnowleopard()
	-- Check to see if they have $2000 in donations for this animal species
	local amount = getDonations("LeopardSnow");
	
	if (amount >= 2000) then
		return 1;
	end

	return 0;
end

function completedonationssnowleopard()
	showprimarygoals();
end



function completeendangeredanimals()
-- all donations met so scenario done
-- unlock scenario 3
-- show overview panel

	-- unlock scenario 3
	BFLOG(SYSTRACE, "completeendangeredanimals");

	-- unlock world campaign scenario 2
	local alreadydone = getuservar("SpeciesSurvivalscenario3");
	
	if (alreadydone ~= "completed") then
		setuservar("SpeciesSurvivalscenario3", "unlocked");
	end
	
	setuservar("SpeciesSurvivalscenario2", "completed");
	
	showscenariowin("SpeciesSurvival:EndangeredAnimalsSuccessPart2overview", "SpeciesSurvivalscenario3");

end

function failendangeredanimals()
-- scenario is failed when the player can no longer successfully "breed" new animals (e.g. they no longer have a 
-- male and a female either through putting too many up for adoption or animal deaths

	showscenariofail("SpeciesSurvival:EndangeredAnimalsFailureoverview:SpeciesSurvivalscenario2");

end


--------------------
-- SCENARIO 3
-------------------


-- animal adoption disabled

function evalsecondgenerationbreeding()
-- preplaced pairs of animals
	-- zebras
	-- lemurs
	-- chimps
	
	
--- NEED TO HAVE ANY ONE SPECIES BREED TO PRODUCE OFFSPRING FROM THEIR OFFSPRING -- success rules just accomodate the variations	
	
-- when first zebra baby born show rule (zebrasfirstbreeding) in success state	
-- when new zebra baby is born to one of those babies, show rule (zebrassecondbreeding) in success state

-- when first lemur baby born show rule (lemursfirstbreeding) in success state	
-- when new lemur baby is born to one of those babies, show rule (lemurssecondbreeding) in success state

-- when first chimp baby born show rule (chimpsfirstbreeding) in success state	
-- when new chimp baby is born to one of those babies, show rule (chimpssecondbreeding) in success state

	BFLOG(SYSTRACE, "evalsecondgenerationbreeding");


	-- If they don't have at least one male/female pair of one of zebra/lemur/chimps
	if (((existMale("ZebraCommon") == false) and (existFemale("ZebraCommon") == false)) or ((existMale("LemurRingtailed") == false) and (existFemale("LemurRingtailed") == false)) or ((existMale("Chimpanzee") == false) and (existFemale("Chimpanzee") == false))) then
		return -1;
	end


	-- If they have a baby, then the first generation goal is satisfied
	if (existNumChildren("ZebraCommon", 1) == true) then
		showRule("zebrasfirstbreeding");
		
		-- Now go through all Zebras to see if any of them have grandmothers
		local zebratable = findType("ZebraCommon");
		if (zebratable) then
			local num = table.getn(zebratable);
			for i = 1,num do
				local single = resolveTable(zebratable[i].value);
				
				if (entityHasGrandmother(single) == true) then
					showRule("zebrassecondbreeding");
					return 1;
				end	
			end
		else
			BFLOG(SYSTRACE, "no zebratable");
		end
		
	end

	if (existNumChildren("LemurRingtailed", 1) == true) then
		showRule("lemursfirstbreeding");
		
		-- Now go through all Lemurs to see if any of them have grandmothers
		local lemurtable = findType("LemurRingtailed");
		if (lemurtable) then
			local num = table.getn(lemurtable);
			for i = 1,num do
				local single = resolveTable(lemurtable[i].value);
				
				if (entityHasGrandmother(single) == true) then
					showRule("lemurssecondbreeding");
					return 1;
				end	
			end
		else
			BFLOG(SYSTRACE, "no zebratable");
		end
	end
	
	if (existNumChildren("Chimpanzee", 1) == true) then
		showRule("chimpsfirstbreeding");
		
		-- Now go through all Zebras to see if any of them have grandmothers
		local chimptable = findType("Chimpanzee");
		if (chimptable) then
			local num = table.getn(chimptable);
			for i = 1,num do
				local single = resolveTable(chimptable[i].value);
				
				if (entityHasGrandmother(single) == true) then
					showRule("chimpssecondbreeding");
					return 1;
				end	
			end
		else
			BFLOG(SYSTRACE, "no zebratable");
		end
	end
	
	
	return 0;
end


function completesecondgenerationbreeding()
-- scenario done... that means campaign is done... 
-- unlock mysterious panda scenario/campaign

	
	setuservar("SpeciesSurvivalscenario3", "completed");
	
	setuservar("Pandascampaign", "unlocked");
	
	showscenariowinhidenext("SpeciesSurvival:SecondGenerationSuccessoverview");

end


function failsecondgenerationbreeding()
-- if somehow you find yourselves without any animal mixed gender pairs 
	showscenariofail("SpeciesSurvival:SecondGenerationFailureoverview", "SpeciesSurvivalscenario3");
end




