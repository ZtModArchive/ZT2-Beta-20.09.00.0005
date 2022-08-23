-- foodchain.lua
-- foodchain photo challenge

include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalfoodchain(comp)
	BFLOG(SYSTRACE, "evalfoodchain");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("foodchainphotos");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("FoodChain");
		end
		
		setglobalvar("challenge", nil);
		setglobalvar("challengeactive", "true");
		
		comp.accept = 1;
		showphotogoals();
		
	elseif (challenge == "decline") then

		BFLOG(SYSTRACE, "You declined!")

		return -1;
	end
	

	if (comp.accept == nil) then
		if (challenge == nil) then
			local showchallengepanel = showchallengepanel("FoodChaintext:PHFoodChain");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting")
		end
	end

	if (comp.accept == 1) then
	
		numPhotoRequirementsMet();
	
		local pm = queryObject("ZTPhotoChallengesComponent");
		local flag = pm:ZT_PHOTOEVENT_GET_CHALLENGES_COMPLETED();
		if (flag) then
			BFLOG(SYSTRACE, "!!!!!!!!!!!!!Done!!!!!!!!!!!!!");
			
			return 1;
		else
			return 0;
		end
	end
	
	return 0;
end


function scoreCarnivoreStalking(comp)
	local stalkinglist = { "ChasePrey" }
	if (scoreAnyDoingTaskInList(comp, stalkinglist) >= 1.0) then
		return 1
	end
	return 0
end


function scoreCarnivoreCatching(comp)
	local catchinglist = { "AttackPrey" }
	if (scoreAnyDoingTaskInList(comp, catchinglist) >= 1.0) then
		return 1
	end
	return 0
end



function completefoodchain(comp)
	BFLOG(SYSTRACE, "complete foodchain");
	
	-- Give rewards here
	giveGuest(20);
	
	showchallengewin("FoodChaintext:PHFoodChainSuccess");
	setglobalvar("challengeactive", "false");
	-- Don't hit this challenge again.
	setglobalvar("foodchain_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));
end



function failfoodchain(comp)
	BFLOG(SYSTRACE, "fail foodchain");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("foodchain_over", "true");
end