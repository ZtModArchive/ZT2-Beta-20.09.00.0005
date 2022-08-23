-- lua file with functions related to challenges


-- Include statements
include "scenario/scripts/misc.lua";
-- include "scenario/scripts/test.lua";
include "photo/testscoring.lua";

include "scenario/scripts/entity.lua";
include "scenario/scripts/ui.lua";
include "scenario/scripts/economy.lua";


-- This means that the completely random challenges will only pop up one out of the ten times evaluated
randomskew = 30;


-- this function called by challengegoals.xml
function decidechallengeset(comp)

	include "scenario/scripts/entity.lua";
	include "scenario/scripts/economy.lua";

	comp.timenow = getRealTime()
	BFLOG(SYSTRACE, "TIME NOW ="..comp.timenow);
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	
	local pnum = getglobalvar("numphotocomplete");
	if (pnum == nil) then
		pnum = 0;
	end
	
	BFLOG(SYSTRACE, "Number of challenges completed: "..num..".");
	BFLOG(SYSTRACE, "Number of photo challenges completed: "..pnum..".");
	
	if (num >= 5) then
		local num = getuservar("safarilock");
		if (num == nil) then
			showchallengewin("itemunlock:newitemsafari");
			setuservar("safarilock", "true");
		end
	end
	
	if (pnum >= 5) then
		local num = getuservar("junglelock");
		if (num == nil) then
			showchallengewin("itemunlock:newitemjungle");
			setuservar("junglelock", "true");
		end
	end
	
	
	-- maybe this should move elsewhere but for now, monitor zoo for the 100th guest
	-- and give an award for this. Not current capacity but total traffic
	local hundredguests = getNumGuests(-1)
	BFLOG(SYSTRACE, "hundredguests value is"..hundredguests);
	if hundredguests >= 100 and comp.gotZooAttendance100 ~= 1 then
		comp.gotZooAttendance100 = 1
		giveaward("awards/ZooAttendance100.xml")
	end
	

	-- Bail out if there is a challenge active, or if we are waiting on a challenge

	local check = getglobalvar("challengeactive");
	if (check == "true") then
		return 0;
	end
	
	local nextcheck = getglobalvar("challenge");
	if (nextcheck ~= nil) then
		return 0;
	end
	
	
	local randnum = math.random(26);
	
	BFLOG(SYSTRACE, "randnum: "..randnum);
	
	if (randnum == 1) then
	
	-- Testing animal release challenge
	local endangered = { };
	endangered[1] = "Kangaroo";
	endangered[2] = "RhinocerosBlack";
	endangered[3] = "TigerBengal";
	endangered[4] = "ElephantAfrican";
	endangered[5] = "Chimpanzee";
	endangered[6] = "GorillaMountain";
	endangered[7] = "LeopardSnow";
	endangered[8] = "PandaGiant";
	endangered[9] = "PandaRed";
	if (howManyInTableExist(endangered) >= 1) then
		local donealready = getglobalvar("animalrelease_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving animalrelease");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/animalrelease.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 2) then
	
	-- Testing special guest challenge
	if (getNumGuests(-1) >= 300) then
		local donealready = getglobalvar("specialguest_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving specialguest");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/specialguest.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 3) then
	
	-- Testing animal trade challenge
	if (howManyAnimalsInZoo() >= 10) then
		local donealready = getglobalvar("animaltrade_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving animaltrade");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/animaltrade.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 4) then

	-- New photo challenges
	
	-- Animal Instinct
	if (thisManyExist("LemurRingtailed", 2) == true) or (thisManyExist("Lion", 2) == true) or (thisManyExist("Ostrich", 2) == true) or (thisManyExist("Giraffe", 2) == true) then
		local donealready = getglobalvar("animalinstincts_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving animalinstincts");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/animalinstincts.xml");	
				
				return 1;
			end
		end
	end
	
	
	elseif (randnum == 5) then
	
	-- Primate Pictures
	if (thisManyExist("GorillaMountain", 1) == true) then
		local donealready = getglobalvar("primatepictures_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving primatepictures");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/primatepictures.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 6) then
	
	-- Zoo News Monthly
	if (countType("Jaguar") >= 1 or countType("PenguinEmperor") >= 1 or countType("Moose") >= 1) then
		local donealready = getglobalvar("zoonewsmonthly_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving zoonewsmonthly");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/zoonewsmonthly.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 7) then
	
	-- Food chain
	if (thisManyExist("TigerBengal", 1) == true) then
		local donealready = getglobalvar("foodchain_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving foodchain");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/foodchain.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 8) then
	
	-- Zoo design
	if (countType("building") >= 3) then
		local donealready = getglobalvar("zoodesign_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving zoodesign");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/zoodesign.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 9) then

	-- Gardening society
	if (countCenterBiome("tropicalrainforest") >= 64) then
		local donealready = getglobalvar("gardeningsociety_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving gardeningsociety");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/gardeningsociety.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 10) then
	
	-- Zoo Association
	if (existMaleFemaleSameSpecies() == true) then
		local donealready = getglobalvar("nationalzooassociation_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving nationalzooassociation");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/nationalzooassociation.xml");	
				
				return 1;
			end
		end
	end

	elseif (randnum == 11) then

	-- CenterAnimalConservarion
	if (countType("BengalTiger") >= 1 or countType("LeopardSnow") >= 1 or countType("BearGrizzly") >= 1 or countType("GorillaMountain") >= 1) then
		local donealready = getglobalvar("centeranimalconservation_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving centeranimalconservation");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/centeranimalconservation.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 12) then
	
	-- Ungulates Part 2
	local donealready = getglobalvar("ungulates_over");
	if (donealready ~= nil and donealready == true) then
		local donealready = getglobalvar("ungulatespart2_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving ungulatespart2");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/ungulatespart2.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 13) then
	
	-- Bistro Magazine
	if (countType("BengalTiger") >= 1 or countType("Giraffe") >= 1 or countType("LemurRingtailed") >= 1) then
		local donealready = getglobalvar("bistromagazine_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving bistromagazine");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/bistromagazine.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 14) then
	
	-- Psychological Conference
	if (howManyEnrichResearched() >= 1 and thisManyExist("PandaGiant", 1) == true) then
		local donealready = getglobalvar("psychologicalconference_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving psychologicalconference");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/psychologicalconference.xml");	
				
				return 1;
			end
		end
	end

	elseif (randnum == 15) then

	-- Garbage strike
	if (countType("Worker") >= 6) then
		local donealready = getglobalvar("garbagestrike_over");
		
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving garbagestrike");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/garbagestrike.xml");	
					
				return 1;
			end
		end
	end
	
	elseif (randnum == 16) then
	
	-- Animal Sale
	if (countType("animal") >= 5) then
		local donealready = getglobalvar("animalsale_over");
		
		if (donealready == nil) or (donealready ~= "true") then		
			-- Set global challengeactive to true
			setglobalvar("challengeactive", "true");
		
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving animalsale");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/animalsale.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 17) then
	
	-- Raffle
	if (countType("Guest") >= 50) then
		local donealready = getglobalvar("raffle_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving raffle");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/raffle.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 18) then
	
	
	-- Animal awareness day
	local rancheck = math.random(randomskew);
	if (rancheck == 1) then
		local donealready = getglobalvar("animalawarenessday_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving animalawarenessday");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/animalawarenessday.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 19) then
	
	-- Enriching animals
	if (howManyAnimalsInZoo() >= 15) then
		local donealready = getglobalvar("enrichinganimals_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving enrichinganimals");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/enrichinganimals.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 20) then
	
	-- Random animal one-time scenario
	if (getNumGuests(-1) >= 200) then
		-- Give out the scenario
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			BFLOG(SYSTRACE, "giving randomanimal");
			mgr:BFS_ADDSCENARIO("scenario/goals/challenge/randomanimalchance.xml");	
				
			return 1;
		end
	end
	
	elseif (randnum == 21) then
	
	-- Random animal #2 one-time scenario
	if (getNumGuests(-1) >= 800) then
		-- Give out the scenario
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			BFLOG(SYSTRACE, "giving randomanimal2");
			mgr:BFS_ADDSCENARIO("scenario/goals/challenge/randomanimalchance2.xml");	
				
			return 1;
		end
	end
	
	elseif (randnum == 22) then
	
	-- Animal stress challenge
	if (howManyAnimalsInZoo() >= 10) and (getTotalBadCumPoints() / getTotalGoodCumPoints() >= 0.2) then
		local donealready = getglobalvar("animalstress_over");
		if (donealready == nil) or (donealready ~= "true") then	
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving animalstress");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/animalstress.xml");	
					
				return 1;
			end
		end
	end	
	
	elseif (randnum == 23) then
	
	-- Test the new photo challenge
	if (countType("CrocodileNile") >= 1) then
		local donealready = getglobalvar("wildlifemagazine_over");
		
		if (donealready == nil) or (donealready ~= "true") then		
			-- Set global challengeactive to true
			setglobalvar("challengeactive", "true");
		
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving wildlifemagazine");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/wildlifemagazinephotochallengegoals.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 24) then
	
	if (countType("Guest") >= 20) then
		local donealready = getglobalvar("marketingbrochure_over");
		
		if (donealready == nil) or (donealready ~= "true") then		
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving marketingbrochure");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/marketingbrochure.xml");	
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 25) then
	
	if (countType("GazelleThomsons") >= 1 or countType("CamelDromedary") >= 1 or countType("Gemsbok") >= 1) then
		local donealready = getglobalvar("ungulates_over");
		
		if (donealready == nil) or (donealready ~= "true") then		
			
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "giving ungulates");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/ungulates.xml");
			
				return 1;
			end
		end
	end
	
	elseif (randnum == 26) then
	
	-- If we make it to here then we are in need of a challenge
	if (countType("Ursidae") >= 1) then
		local donealready = getglobalvar("bearchallenge_over");
		if (donealready == nil) or (donealready ~= "true") then
			-- Give out the scenario
			local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				BFLOG(SYSTRACE, "Giving bearchallenge");
				mgr:BFS_ADDSCENARIO("scenario/goals/challenge/bearbiologistschallenge.xml");
				
				return 1;
			end
		end
	end
	
	elseif (randnum == 27) then
	
	if (howMuchCash() <= 200) then
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			local whichscen = math.random(2);
			whichscen = 2;
			if (whichscen == 1) then
				local donealready = getglobalvar("halfadmission_over");
				if (donealready == nil) or (donealready ~= "true") then
					BFLOG(SYSTRACE, "Giving halfadmission challenge");
					mgr:BFS_ADDSCENARIO("scenario/goals/challenge/halfadmission.xml");	
					
					return 1;
				end
			else
				local donealready = getglobalvar("ventureloan_over");
				if (donealready == nil) or (donealready ~= "true") then
					BFLOG(SYSTRACE, "Giving ventureloan challenge");
					mgr:BFS_ADDSCENARIO("scenario/goals/challenge/ventureloan.xml");
					
					return 1;
				end
			end
		end
	end
	
	end

	return 0;
end




function checkhealth(comp)
	local gameMgr = queryObject("BFGManager");
	if (gameMgr ~= nil) then
		local entityList = gameMgr:BFG_GET_ENTITIES("animal");
		if (entityList ~= nil and type(entityList) == "table") then
			local numEntities = table.getn(entityList);
			for i = 1,numEntities do
				local animal = resolveTable(entityList[i].value);
				if (animal ~= nil) then
					local health = animal:BFG_GET_ATTR_FLOAT("health");
					BFLOG(SYSTRACE, "Health is ["..health.. "]");
				end
			end
		end
	end
	
	return 0;
end



function takepicofkeeper()
	local score = 0
	local t1 = pt:getType("bench")
	local e1 = findMatchingEntity(pt, t1)
	if (e1) then
		BFLOG(SYSTRACE, "found bench")
		pac = e1:getPAC()
		if (pac) then
			BFLOG(SYSTRACE, "found bench's PAC")
			-- iterate over entities on bench
			local be = pac:getFirstContainedEntity()
			while be do
				-- is any a keeper?
				BFLOG(SYSTRACE, "checking out"..be:getEDI():getVar("s_name"))
				if (be:isKindOf("Keeper")) then
					BFLOG(SYSTRACE, "found keeper")
					-- if so, score is 100
					score = 100
					break
				end
				be = pac:getNextContainedEntity()
			end
		else
		end
	else
	end
	return score
end


function scoreAnyAnimal(pt)
	return scoreT1(pt, "animal")
end

