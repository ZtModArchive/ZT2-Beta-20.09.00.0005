-- animalawarenessday.lua
-- animal awareness day
include "scenario/scripts/ui.lua";



-- there is string replacement needed for animal name and cash amount


function evalanimalawarenessday(comp)

-- completely random. can occur anytime
-- Chosen animal is selected randomly from all animals and is an animal that 
-- the player does not have.  The cash reward is tailored to the tier that the 
-- chosen animal is in.  Repeatable

	BFLOG(SYSTRACE, "evalanimalawarenessday");
	
	challenge = getglobalvar("challenge")
	
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("animalawarenessday");
		end
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		giveCash(comp.cashreward / 5);
		comp.accept = 1;	
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		
		return -1;
	end
	
	if (comp.accept == nil) then
		if (challenge == nil) then
			-- Choose an animal that they don't currently have
			local animalchoicetable = animalsNotInZoo();
			
			local num = table.getn(animalchoicetable);
			comp.whatanimal = animalchoicetable[math.random(num)];
			comp.cashreward = 4000;
			
			BFLOG(SYSTRACE, "YOU NEED A..."..comp.whatanimal..".");
	
			local stringdat = getLocID("Challengetext:CHAnimalAwarenessDay");
			local showme = string.format(stringdat, comp.whatanimal, comp.cashreward);
			
			showchallengepaneltext(showme);
	
			--showchallengepanel("Challengetext:CHAnimalAwarenessDay");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting");
		end
	end

	if (comp.accept ~= nil) then
		if (comp.awarenesstimer == nil) then
			comp.awarenesstimer = getCurrentMonth();
		end
		
		local monthnow = getCurrentMonth();
		
		-- If three months has passed, check to see if they have the animal
		if (monthnow >= comp.awarenesstimer + 3) then
			if (countType(comp.whatanimal) >= 1) then
				giveCash(comp.cashreward - (comp.cashreward / 5));
				return 1;
			else
				return -1;
			end
		end
		
	end
	
	return 0;

end




function completeanimalawarenessday(comp)
-- get cash grant -- amount determined by price of animal
-- get 10 - 20 bonus guests.. # based on current capacity

	showchallengewin("Challengetext:CHAnimalAwarenessDaySuccess");

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("animalawarenessday_over", "true");
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));
	
	BFLOG(SYSTRACE, "Complete animalawarenessday");

end


function failanimalawarenessday(comp)
--  still get a tiny boost to attendance but no cash reward
-- get 1 - 5 bonus guests .. # based on current capacity

	showchallengefail("Challengetext:CHAnimalAwarenessDayFailure");

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("animalawarenessday_over", "true");
	
	BFLOG(SYSTRACE, "Fail animalawarenessday");
end




