-- zoonewsmonthly.lua
-- zoo news monthly photo challenge

include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalzoonewsmonthly(comp)
	BFLOG(SYSTRACE, "evalzoonewsmonthly");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("zoonewsmonthlyphoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("ZooNewsMonthly");
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
			local showchallengepanel = showchallengepanel("ZooNewstext:PHZooNews");
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


function scoreJaguarSwimming(comp)
	local swimlist = { "SwimObject_", "Swim_", "TreadWaterObject_", "TreadWater_" }
	if (scoreAnyEntityTypeDoingMatchingAnimInList(comp, "Jaguar", swimlist) >= 1.0) then
		return 1
	end
	return 0
end


function scorePenguinSpreadWings(comp)
	if (scoreAnyEntityTypeDoingAnimX(comp, "PenguinEmperor", "SpreadWings_Idle") >= 1.0) then
		return 1
	end
	return 0
end


function scoreMooseRubAntlers(comp)
	if (scoreAnyEntityTypeDoingAnimX(comp, "Moose", "Stand_RubAntlersOnTree") >= 1.0) then
		return 1
	end
	return 0
end






function completezoonewsmonthly(comp)
-- function needs to provide a 15 guest bonus each month for 3 months over and above guest cap


	BFLOG(SYSTRACE, "complete zoonewsmonthly");
	
	
	-- Give rewards here
	giveGuest(45);
	
	showchallengewin("ZooNewstext:PHZooNewsSuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("zoonewsmonthly_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));

end


function failzoonewsmonthly(comp)
	BFLOG(SYSTRACE, "fail zoonewsmonthly");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("zoonewsmonthly_over", "true");
end