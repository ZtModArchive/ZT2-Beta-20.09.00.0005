-- enrichinganimals.lua
-- enriching animals

include "scenario/scripts/ui.lua";
include "scenario/scripts/misc.lua";




function evalenrichinganimals(comp)

-- minimum of 15 animals in the zoo
-- need to check that there are 6 enrichment objects still left to research
	-- if too many objects already researched/not enough left, skip this challenge
-- food objects don't count
-- possible items are only: car tire, easel, heated rock, large ice floe
	-- monkey bars, lookout post, peanut feeder, plastic barrel
	-- scratching post, wooden ramp, rubber toy

	BFLOG(SYSTRACE, "evalenrichinganimals");
	
	challenge = getglobalvar("challenge")
	
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("enrichinganimals");
		end
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		-- Save the number of researched objects prior to accepting
		comp.alreadyresearched = howManyEnrichResearched();
		comp.howmanyexist = howManyEnrichExist();
		
		BFLOG(SYSTRACE, "alreadyresearched: "..comp.alreadyresearched);
		BFLOG(SYSTRACE, "alreadyexist: "..comp.howmanyexist);
	
		comp.accept = 1;
		showprimarygoals();
		
	elseif (challenge == "decline") then
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		declinenotfail = 1;
	
		return -1;	
	end
	
	if (comp.accept == nil) then
		if (challenge == nil) then
			showchallengepanel("Challengetext:CHEnrichingAnimals");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting");
		end
	end
	
	-- when the challenge is going
	if (comp.accept ~= nil) then
		if (comp.enrichtimer == nil) then
			comp.enrichtimer = getCurrentMonth();
		end
		
		-- Check to see if they have researched three new things
		local researchnow = howManyEnrichResearched();
		local existnow = howManyEnrichExist();
		
		BFLOG(SYSTRACE, "researchnow: "..researchnow.."   existnow: "..existnow..".");
		
		if ((researchnow > comp.alreadyresearched + 5) and (existnow > comp.howmanyexist + 5)) then
			return 1;
		end
		
		-- If a month has passed, then return true
		local monthnow = getCurrentMonth();
		
		BFLOG(SYSTRACE, "old month: "..comp.enrichtimer.."  now: "..monthnow..".");
		
		-- This means they ran out of time
		if (monthnow > comp.enrichtimer) then
			return -1;
		end
	end	

	return 0;

end




function completeenrichinganimals(comp)
-- get 20 bonus guests (very happy ones)

	giveGuest(20);

	showchallengewin("Challengetext:CHEnrichingAnimalsSuccess");

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("enrichinganimals_over", "true");
	
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));
	
	BFLOG(SYSTRACE, "Complete enrichinganimals");

end


function failenrichinganimals(comp)
--  20 guests decide to leave!
	
	if (declinenotfail == nil) then
		showchallengefail("Challengetext:CHEnrichingAnimalsFailure");
	end

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("enrichinganimals_over", "true");
	
	BFLOG(SYSTRACE, "Fail enrichinganimals");

end




