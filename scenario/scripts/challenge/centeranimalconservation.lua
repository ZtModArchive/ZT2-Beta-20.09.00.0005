-- centeranimalconservation.lua
-- center for animal conservation photo challenge
 
include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalcenteranimalconservation(comp)
	BFLOG(SYSTRACE, "evalcenteranimalconservation");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("centeranimalconservationphoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("CenterAnimalConservation");
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
			local showchallengepanel = showchallengepanel("CenterAnimalConservationtext:PHCenterAnimalConservation");
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



function scoreBengalTiger(comp)
	return scoreT1(comp, "TigerBengal")
end


function scoreSnowLeopard(comp)
	return scoreT1(comp, "LeopardSnow")
end

function scoreMountainGorilla(comp)
	return scoreT1(comp, "GorillaMountain")
end

function scoreGrizzlyBear(comp)
	return scoreT1(comp, "BearGrizzly")
end








function completecenteranimalconservation(comp)
	BFLOG(SYSTRACE, "complete centeranimalconservation");
	
	
	-- Give rewards here
	giveCash(15000);
	
	showchallengewin("CenterAnimalConservationtext:PHCenterAnimalConservationSuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("centeranimalconservation_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));

end


function failcenteranimalconservation(comp)
	BFLOG(SYSTRACE, "fail centeranimalconservation");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("centeranimalconservation_over", "true");
end
