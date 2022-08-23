-- ungulatespart2.lua
-- ungulates part 2 more pics photo challenge
 
include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalungulatespart2(comp)
	BFLOG(SYSTRACE, "evalungulatespart2");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("ungulatespart2photo");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("UngulatesPart2");
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
			local showchallengepanel = showchallengepanel("UngulatesPart2text:PHUngulatesPart2");
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



function scoreCamelsGrooming(comp)
	if (scoreAnyEntityTypeDoingAnimX(comp, "CamelDromedary", "Stand_Lean") >= 1.0) then
		return 1
	end
	return 0
end


function scoreGemsbokSleepingShade(comp)
	if (scoreAnyEntityTypeDoingTaskAndAnim(comp, "Gemsbok", "SleepShade", "Sleep_Idle") >= 1.0) then
		return 1
	end
	return 0
end

function scoreGazelleGreeting(comp)
	if (scoreAnyDoingTaskInList(comp, "GazelleThomsons", {"InviteGreet"}) >= 1.0) then
		return 1
	end
	return 0
end






function completeungulatespart2(comp)
	BFLOG(SYSTRACE, "complete ungulatespart2");
	
	
	-- Give rewards here
	giveCash(4500);
	
	showchallengewin("UngulatesPart2text:PHUngulatesPart2Success");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("ungulatespart2_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));

end



function failungulatespart2(comp)
	BFLOG(SYSTRACE, "fail ungulatespart2");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("ungulatespart2_over", "true");
end