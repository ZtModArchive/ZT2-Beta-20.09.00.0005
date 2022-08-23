-- bearbiologist.lua
-- Functions for the bear biologist challenge

-- this function called by bearbiologistschallenge.xml
function bearbiologistschallenge(comp)

	BFLOG(SYSTRACE, "evalbearbiologist");
	
	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("bearbiologist");
		end
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		comp.accept = 1;
		showprimarygoals();
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		
		declinenotfail = 1;
		
		-- Return failure
		return -1;
	end
	
	if (comp.accept == nil) then
		if (challenge == nil) then
			local showchallengepanel = showchallengepanel("Challengetext:CHBearConference");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting")
		end
	end
	-- if the challenge is going find out what type of bear this is
	if (comp.accept == 1) then
		local whichbear = countType("BearGrizzly");
		if (whichbear == 1) then
			BFLOG(SYSTRACE, "You have a Grizzly");
			comp.grizzly = 1
		else
			BFLOG(SYSTRACE, "You have a Polar Bear");
			comp.polar = 1
		end
		
		-- start a time counter... 
       	if comp.beartimer == nil then
	        comp.beartimer = getCurrentMonth();
			BFLOG(SYSTRACE, "Bear Challenge timer started");
       	end
        	
       	if comp.bearover == nil then
       		local tmpmonth = getCurrentMonth();
    		local time = comp.beartimer + 4;
            if tmpmonth >= time then
				BFLOG(SYSTRACE, "FAILED Bear Challenge");
        	    comp.bearover = 1;
        	    return -1;
        	end
        	
        	-- if you've got a polar bear, then check for a grizzly
			if (comp.polar == 1) then
				needgrizzly = countType("BearGrizzly");
				if (needgrizzly == 1) then	
					bearover = 1;
					return 1;
				end
			end
			
			-- if you've got a grizzly bear, then check for a polar
			if (comp.grizzly == 1) then
				needpolar = countType("BearPolar");
				if (needpolar == 1) then
					comp.bearover = 1;
					return 1;	
        		end
			end		
		end
	end	
	
end



-- this function called by bearbiologistschallenge.xml when bearbiologistschallenge rule is successful
function completebearchallenge(comp)
	
	-- Give the player their cash
	giveCash(2000);
	
	showchallengewin("Challengetext:CHBearSuccess");
	
	BFLOG(SYSTRACE, "Completed bear challenge");
	
	setglobalvar("challengeactive", "false");
	
	-- If we never want to see this challenge again, set a global variable
	setglobalvar("bearchallenge_over", "true");
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));
end

-- this function called by bearbiologistschallenge.xml when bearbiologistschallenge rule is failed
function failbearchallenge(comp)
	
	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	-- If we never want to see this challenge again, set a global variable
	setglobalvar("bearchallenge_over", "true");
	
	takecash = takeCash(3000);
	
	if (declinenotfail == nil) then
		showchallengefail("Challengetext:CHBearFailure");
	end
	
	declinenotfail = nil;

	BFLOG(SYSTRACE, "Failed bear challenge");
end