-- ungulates.lua
-- Ungulates photo challenge

include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalungulates(comp)
	include "scenario/scripts/photoutil.lua";

	BFLOG(SYSTRACE, "evalungulates");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("ungulatesphoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("Ungulates");
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
			local showchallengepanel = showchallengepanel("PhotoChallengetext:PHUngulate");
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

end


-- Photochallenge scoring functions

function scoreCamel(pt)
	return scoreT1(pt, "CamelDromedary")
end

function scoreGemsbok(pt)
	return scoreT1(pt, "Gemsbok")
end

function scoreGazelle(pt)
	return scoreT1(pt, "GazelleThomsons")
end




function completeungulates(comp)

	BFLOG(SYSTRACE, "WE DID IT");
	
	FameGlobals.status.scenarioPoints = FameGlobals.status.scenarioPoints + 2;
	giveCash(2250);
	
	showchallengewin("PhotoChallengetext:PHUngulateSuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("ungulates_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));
end


function failungulates(comp)

	BFLOG(SYSTRACE, "FAILURE");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("ungulates_over", "true");
	
	BFLOG(SYSTRACE, "Failed ungulates challenge");
end