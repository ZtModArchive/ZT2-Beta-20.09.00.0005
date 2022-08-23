-- lua file for species survival campaign 

----------------------------------------------------------------------------------


-- Include statements
include "scenario/scripts/misc.lua";
include "scenario/scripts/ui.lua";
include "scenario/scripts/entity.lua";
include "scenario/scripts/needs.lua";
include "scenario/scripts/economy.lua";
include "scenario/scripts/photoutil.lua";


function setinitialzoostate(comp)
	BFLOG(SYSTRACE, "*********I'm here so show overview panel!********");
	completeshowoverview()
	showUI("goal panel", true);

	return 1;
end


--------------------
-- SCENARIO 1
-------------------

-- 3 animals placed in crates, three already made exhibits... all they have to do is uncrate it and place it in the 
-- appropriate biome

function evalbiomeplacement()
-- pretty simple.. just check environment need for hippo, lion and polar bear
	
	-- Make sure that the three animals are in the zoo
	if (howManyAnimalsInZoo() == 3) then
		-- And that they meet their environment need
		if (allNeedSatisfied("animal", "environment") == true) then
			return 1;
		end
	end

	return 0;
end


function completebiomeplacement()
-- unlock scenario 2
-- show overview panel

	local alreadydone = getuservar("ZookeeperTrainingscenario2");
	
	if (alreadydone ~= "completed") then
		setuservar("ZookeeperTrainingscenario2", "unlocked");
	end
	
	setuservar("ZookeeperTrainingscenario1", "completed");
	
	showscenariowin("ZookeeperTraining:ZookeeperTrainingSuccessoverview", "ZookeeperTrainingscenario2");
end

function failvulnerableanimalsbreeding()
-- scenario is failed if they actually manage to kill an animal
end



--------------------
-- SCENARIO 2
-------------------

-- lots of parts but all easy ones

function evalzebrabiome()
-- meet environment need of 2 common zebras

	if (thisManyExist("ZebraCommon", 2) == true) then
		-- And that they meet their environment need
		if (allNeedSatisfied("ZebraCommon", "environment") == true) then
			return 1;
		end
	end

	return 0;

end

function completezebrabiome()
-- met need

	showprimarygoals();
end

function evalzebrafoodwater()
-- meet food and thrist needs for zebras
	
	if (thisManyExist("ZebraCommon", 2) == true) then
		-- And that they meet their environment need
		if (allNeedSatisfied("ZebraCommon", "thirst") == true) and (allNeedSatisfied("ZebraCommon", "hunger") == true) then
			return 1;
		end
	end
end

function completezebrafoodwater()
-- met needs
end

function completezebragoals()
-- first zebra group goals done, showrule(goaltwo)

	BFLOG(SYSTRACE, "completezebragoals");
	showRule("goaltwo");
	showprimarygoals();
end


function evalresearchstands()
-- research hamburger and sparkling water stands and place in world, function can just
-- check for the stands in the world

	BFLOG(SYSTRACE, "evalresearchstands");

	if (thisManyExist("foodstand_burger", 1) == true) and (thisManyExist("foodstand_water", 1) == true) then
		return 1;
	end

	return 0;
end

function completeresearchstands()
	showRule("goalthree");
	
	showprimarygoals();
end


function evalzebrapictures(comp)
-- start photochallenge to take 2 pics of zebras

-- define the photochallege
	if (comp.initphoto == nil) then
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("ZookeeperCampaignPhotos");
		end
		
		comp.initphoto = 1;
	end
	
	local pm = queryObject("ZTPhotoChallengesComponent");
	local flag = pm:ZT_PHOTOEVENT_GET_CHALLENGES_COMPLETED();
	if (flag) then
		return 1;
	end
	
	return 0;
end

function completezebrapictures()
-- took the pics so showrule(goalfour)

	showRule("goalfour");
	showprimarygoals();

	letjaguarsloose = 1;
end


function scoreZebraScratchingPost(comp)
	if (scoreAnyEntityTypeDoingTarget(comp, "ZebraCommon", "enrichment") >= 1.0) then
		return 1;
	end
	
	return 0;
end


function evaljaguarbasicneeds(comp)
-- place one male and one female jaguar in crates
-- meet all basic needs 
-- start 2 month timer because the animals are on loan

	if (letjaguarsloose ~= nil) then
		placeObject("Jaguar_Adult_M", 85, 35, 0);
		placeObject("Jaguar_Adult_F", 85, 35, 0);
	
		-- Now crate these three guys
		local cratetable = findType("Jaguar");
		local num = 0;
		num = table.getn(cratetable);
	
		for i = 1,num do
			local single = resolveTable(cratetable[i].value);
			crateEntity(single);
		end
		
		comp.jaguartimer = getCurrentMonth();
		
		letjaguarsloose = nil;
	end

	-- If the timer is up then fail
	local timenow = getCurrentMonth();
	if (timenow >= comp.jaguartimer + 2) then
		return -1;
	end

	-- Check their jaguars for basic needs
	
	local jagtable = findType("Jaguar");
	local num = 0;
	num = table.getn(jagtable);
	
	-- If they have both jaguars out
	if (num == 2) then
		for i = 1,num do
			local single = resolveTable(jagtable[i].value);
		
			if (basicNeedsSatisfied(single)	== false) then
				return 0;
			end
		end
		
		-- If they make it to here, then they passed
		return 1;
	end
	
	return 0;
end


function completejaguarbasicneeds()
	showrule(goalfive);
	showprimarygoals();
end

function failjaguarbasicneeds()
	-- whoops times up, remove animals
	showscenariofail("ZookeeperTraining:StartUpGoalFourFailed", "ZookeeperTrainingscenario2");
end

function evaljaguaradvancedneeds(comp)
-- meet jaguar's advanced needs

	if (comp.initjaguar == nil) then
		comp.jaguartimer = getCurrentMonth();
		comp.initjaguar = 1;
	end

	-- If the timer is up then fail
	local timenow = getCurrentMonth();
	if (timenow >= comp.jaguartimer + 2) then
		return -1;
	end

	-- Check their jaguars for basic needs
	
	local jagtable = findType("Jaguar");
	local num = 0;
	num = table.getn(jagtable);
	
	-- If they have both jaguars out
	if (num == 2) then
		for i = 1,num do
			local single = resolveTable(jagtable[i].value);
		
			if (advancedNeedsSatisfied(single) == false) then
				return 0;
			end
		end
		
		-- If they make it to here, then they passed
		return 1;
	end
	
	return 0;
end

function completejaguaradvancedneeds()
-- great, all done, unlock scenario 3
-- show overview panel

	local alreadydone = getuservar("ZookeeperTrainingscenario3");
	
	if (alreadydone ~= "completed") then
		setuservar("ZookeeperTrainingscenario3", "unlocked");
	end
	
	setuservar("ZookeeperTrainingscenario2", "completed");
	
	showscenariowin("ZookeeperTraining:StartUpSuccessoverview", "ZookeeperTrainingscenario3");

end

function failjaguaradvancedneeds()
-- -- whoops times up, remove animals

	showscenariofail("ZookeeperTraining:StartUpGoalFiveFailed", "ZookeeperTrainingscenario2");

end



function completestartup()
-- great, finished everything.. do we need this function... too tired to worry about so it's here anyway... 
-- great, all done, unlock scenario 3
-- show overview panel
end

function failedstartup()
-- messed it up somehow... 2 ways... run out of jaguar time, or kill an animal...
end


--------------------
-- SCENARIO 3
-------------------



function evaldonations()
-- player just needs to get $5000 in donations

	-- Make this better later
	-- For now, call getDonations on every animal they have in the zoo
	-- Plus education
	
	
	local animaltable = animalsInZoo();

	local total = 0;

	if (animaltable ~= nil) then
		local num = table.getn(animaltable);
		
		for i = 1, num do
			total = total + getDonations(animaltable[i]);
		end
	
	end
	
	-- And at the end, add on education
	
	total = total + getDonations("Education");
	
	BFLOG(SYSTRACE, "current donation total: "..total..".");
	
	if (total >= 5000) then
		return 1;
	end
	
	return 0;
end


function completedonations()
-- all done
-- give gardenstake as a reward
-- locked with s_ProfileLock="flowerpostlock"

	setuservar("flowerpostlock", "true");

	showscenariowinhidenext("ZookeeperTraining:BeyondStartUpSuccessoverview");

end






