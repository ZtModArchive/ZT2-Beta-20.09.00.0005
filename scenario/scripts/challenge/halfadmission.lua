-- halfadmission.lua
-- functions for the grantmoney scenario

include "scenario/scripts/ui.lua";

-- gives you half price admission promotion challenge
function evalhalfadmission(comp)
	
	BFLOG(SYSTRACE, "evalhalfadmission");

	-- Return true for now
	return 1;
	
end

	--[[

	-- if the 1/2 admission has be started, keep running the function until it's finished
	
	if comp.startmoney1challenge == 1 then
		reduceadmissionrefundsick();
	end
	if comp.startmoney1challenge == 2 then
		return 1;
	end
	
	challenge = getglobalvar("challenge")
	if (challenge == "accept") and (comp.assigningmoney1 == 1) then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:BFS_SHOWRULE("grantmoney");
		end
		comp.firsttimebroke = 1
		if (comp.startmoney1challenge == nil) then
			local showoverview = completeshowoverview();
			comp.startmoney1challenge = 1
		end
		setglobalvar("challenge", nil)
			
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!")
		setglobalvar("challenge", nil)
		comp.startmoneychallenge = -1
		comp.firsttimebroke = 1
	end	
	if comp.firsttimebroke == nil then
		if(challenge == nil) then
			local showchallengepanel = showchallengepanel("Challengetext:CHgrantmoney");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting")
		end
	end
end

--]]


function completehalfadmission(comp)

	BFLOG(SYSTRACE, "WE DID IT");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("halfadmission_over", "true");
	
	completeshowoverview();

	return 1;
end