-- animalrelease.lua
-- animal release
include "scenario/scripts/ui.lua";



-- string replacement needed for animal type and $ amount


function evalanimalrelease(comp)

-- must have an endangered or critically endangered animal
-- The animal is chosen randomly from among those endangered or critical animals 
-- in the player’s zoo, but cannot already be "releaseable"
-- Repeatable.
-- $ amount determined based on 3 x the price of the animal, 20% paid upfront.

	BFLOG(SYSTRACE, "evalanimalrelease");
	
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
		
			-- Choose an animal that they currently have
			local animalchoicetable = { };
			animalchoicetable[1] = "Kangaroo";
			animalchoicetable[2] = "RhinocerosBlack";
			animalchoicetable[3] = "TigerBengal";
			animalchoicetable[4] = "ElephantAfrican";
			animalchoicetable[5] = "Chimpanzee";
			animalchoicetable[6] = "GorillaMountain";
			animalchoicetable[7] = "LeopardSnow";
			animalchoicetable[8] = "PandaGiant";
			animalchoicetable[9] = "PandaRed";
			
			local newtable = getTableFromTableEntityExist(animalchoicetable)
		
			local num = table.getn(newtable);
			comp.whatanimal = newtable[math.random(num)];
			comp.cashreward = 5000;
			comp.prevreleases = getAnimalsReleased();
			comp.numanimal = countType(comp.whatanimal);
			
			BFLOG(SYSTRACE, "YOU NEED TO RELEASE A..."..comp.whatanimal..".");
			
			local stringdat = getLocID("Challengetext:CHAnimalRelease");
			local showme = string.format(stringdat, comp.whatanimal, comp.cashreward, comp.whatanimal);
			
			showchallengepaneltext(showme);
	
			--showchallengepanel("Challengetext:CHAnimalRelease");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting");
		end
	end
	
	
	if (comp.accept ~= nil) then
	
		-- If they are down an animal, and up a release then they win!
		-- These two numbers have to move at the same time for it to be an actual win
		local nownumanimal = countType(comp.whatanimal);
		local nowprevreleases = getAnimalsReleased();
		
		if ((nownumanimal < comp.numanimal) and (nowprevreleases > comp.prevreleases)) then
			giveCash(comp.cashreward);
			return 1;
		end

		-- If nownumaniaml == 0 and it didn't coincide with a release, then we fail
		if (nownumanimal == 0) then
			return -1;
		end
	
		-- Otherwise update the previous animal count and released animal count
		comp.numanimal = nownumanimal;
		comp.prevreleases = nowprevreleases;
	end
end




function completeanimalrelease(comp)
	
	showchallengewin("Challengetext:CHAnimalAwarenessDaySuccess");

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("animalrelease_over", "true");
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));
	
	BFLOG(SYSTRACE, "Complete animalrelease");
end


function failanimalrelease(comp)
--  if any of the chosen animal type die
	-- is there any other way for the player to get rid of animals? yes, adoption
	-- so also check if there are none left

	if (declinenotfail == nil) then
		showchallengefail("Challengetext:CHAnimalReleaseFailure");
	end

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("animalrelease_over", "true");
	
	BFLOG(SYSTRACE, "Fail animalrelease");

end