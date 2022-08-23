-- animaltrade.lua
-- animal trade challenge

include "scenario/scripts/ui.lua";


function evalanimaltrade(comp)
-- zoo with at least 10 species of animals


-- an existing animal is swapped with a new animal (that the player does not currently
-- have). Also, an even number should be swapped out in that if the player had 
-- 2 zebras, both should be swapped for 2 new animals. Also, new animals should 
-- be of a tier higher than the ones removed.

-- new animals can be placed in the position of the old animals.

-- Donations for the "new" animal are tracked for 3 months and $500 must be generated.
-- if over 3 months less than $500 is generated, challenge is "failed" and is over
-- if player succeeds, another of their animal(s) is swapped 

-- this can happen a total of 3 times

end


function evalanimaltradefirst(comp)

	BFLOG(SYSTRACE, "evalanimaltradefirst");
	
	challenge = getglobalvar("challenge");
	
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!");
		
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("animaltradefirst");
		end
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		comp.accept = 1;
		
		-- If they accept then:
		-- 1.  Delete the original entity type
		-- 2.  Deliver them X of the new type in crates
		local stasistable = findType(comp.animalToTrade);
		local num = table.getn(stasistable);
		for i = 1, num do
			local single = resolveTable(stasistable[i].value);
			deleteEntity(single);
		end
		
		-- Place X of the new animal
		for j = 1, num do
			local animalTypeName = comp.animalToGet.."_Adult_F";
			placeObject(animalTypeName, 10, 10, 0);
		end
		
		-- Crate up the new animal
		local cratetable = findType(comp.animalToGet);
		local cnum = table.getn(cratetable);
		for j = 1, num do
			local single = resolveTable(cratetable[j].value);
			crateEntity(single);
		end
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		
		declinenotfail = 1;
		
		-- Return failure
		return -1;
	end
	
	if (comp.accept == nil) then
		if (challenge == nil) then
		
			local animaltable = animalsInZoo();
			local nontable = animalsNotInZoo();
			
			-- Get a random animal they have and a random animal they don't
			comp.animalToTrade = animaltable[math.random(table.getn(animaltable))];
			comp.animalToGet = nontable[math.random(table.getn(nontable))];
			
			-- We're going to do this in multiples of the number of the animal you have
			comp.trademag = countType(comp.animalToTrade);
			
			BFLOG(SYSTRACE, "Trade: "..comp.animalToTrade.."     for: "..comp.animalToGet..".");
	
			showchallengepanel("Challengetext:CHAnimalTrade");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting");
		end
	end
	
	
	if (comp.accept ~= nil) then
	
		-- Setup the timer
		if (comp.tradetimer == nil) then
			comp.tradetimer = getCurrentMonth();
		end
		
		-- First check to see if they have gotten the $500 cash donation
		local total = getDonations(comp.animalToGet);
		
		BFLOG(SYSTRACE, "donations: "..total..".");
		
		if (total >= 500) then
			giveCash(8000);
			return 1;
		end
		
			
		local monthnow = getCurrentMonth();
		
		-- If the month has passed then check to see if they have the animal
		if (monthnow >= comp.tradetimer + 3) then
			return -1;
		end
	end



end

function evalanimaltradesecond(comp)
end

function evalanimaltradethird(comp)
end



-- if swapping has occured 3 times.
-- return the players previous animal back to their exhibits... if possible (e.g.
-- what if the player has really changed too much in the zoo? If this is the situation then 
-- just skip over returning the previous animals and player gets to keep the new ones

function completeanimaltradefirst(comp)
end

function completeanimaltradesecond(comp)
end

function completeanimaltradethird(comp)
-- give cashgrant of $7500

	showchallengewin("Challengetext:CHAnimalTradeThirdSuccess");

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("animaltrade_over", "true");
	
	BFLOG(SYSTRACE, "Complete animaltrade");
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));

end


function failanimaltrade(comp)
-- if player fails to generate $500 in 3 months
-- return the players previous animal back to their exhibits... if possible (e.g.
-- what if the player has really changed too much in the zoo? If this is the situation then 
-- just skip over returning the previous animals and player gets to keep the new ones


	if (declinenotfail == nil) then
		showchallengefail("Challengetext:CHAnimalTradeFailure");
	end

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("animaltrade_over", "true");
	
	BFLOG(SYSTRACE, "Fail animaltrade");


end



