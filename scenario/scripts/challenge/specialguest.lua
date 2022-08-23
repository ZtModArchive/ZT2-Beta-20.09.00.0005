-- specialguest.lua
-- special guest
include "scenario/scripts/ui.lua";




-- string replacement needed for guest name, animal and dollar amount

function evalspecialguest(comp)

-- random
-- get the name of a guest and a random favorite animal 
-- randomly decide when he comes from 30 - 60 days later
-- spawn a guest with that name
-- repeatable


	BFLOG(SYSTRACE, "evalspecialguest");
	
	challenge = getglobalvar("challenge");
	
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!");
		
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("animalrelease");
		end
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		comp.accept = 1;	
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		
		declinenotfail = 1;
		
		-- Return failure
		return -1;
	end
	
	if (comp.accept == nil) then
		if (challenge == nil) then
		
			comp.whatanimal = getRandomAnimalType();
			comp.cashreward = 4000;
			
			BFLOG(SYSTRACE, "YOU NEED TO GET A..."..comp.whatanimal..".");
	
			local stringdat = getLocID("Challengetext:CHSpecialGuest");
			local showme = string.format(stringdat, "Hank", comp.whatanimal);
			
			showchallengepaneltext(showme);
	
			showchallengepanel("Challengetext:CHSpecialGuest");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting");
		end
	end
	
	
	if (comp.accept ~= nil) then
	
		if (comp.specialguesttimer == nil) then
			comp.specialguesttimer = getCurrentMonth();
		end
		
		BFLOG(SYSTRACE, "Guest coming will be looking for a: "..comp.whatanimal..".");
		
		local monthnow = getCurrentMonth();
		
		-- If the month has passed then check to see if they have the animal
		if (monthnow >= comp.specialguesttimer) and (getCurrentTimeOfDay() >= 0.4) then
		
			-- First give them their guest
			-- Fix it later to add attributes
			giveGuest(1);
		
			if (countType(comp.whatanimal) >= 1) then
				giveCash(comp.cashreward);
				return 1;
			else
				return -1;
			end
		end
	end


end




function completespecialguest(comp)
-- if favorite animal in zoo, when special guest spawned, then give the player 
-- cash reward
-- cash reward should be varied based on animal... can randomize it completely
	-- by having it be 3 - 5 x animal price 
-- or set price based on tier
	-- $5K if animal in tier 1
	-- 10K if in tier 2
	-- 15K if in tier 3
	-- 20K if in tier 4
-- (I tend to prefer random but don't feel super strongly).

	showchallengewin("Challengetext:CHSpecialGuestSuccess");

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("specialguest_over", "true");
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));
	
	BFLOG(SYSTRACE, "Complete specialguest");

end


function failspecialguest(comp)
--  if chosen animal not there when special guest arrives... too bad you missed the cash

	if (declinenotfail == nil) then
		showchallengefail("Challengetext:CHSpecialGuestFailure");
	end

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("specialguest_over", "true");
	
	BFLOG(SYSTRACE, "Fail specialguest");

end




