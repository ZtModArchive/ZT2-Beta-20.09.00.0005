-- animalstress.lua
-- animal stress challenge

include "scenario/scripts/ui.lua";
include "scenario/scripts/economy.lua";






function evalanimalstress(comp)
-- 20% unhappy animals (base on bad points?) - this may take some discussion


-- player can take 2 paths
-- they can do nothing in which case disable new animal adoptions for 1 month


-- if they "argue" the charge
-- close the zoo and disable the open button for 1 month

-- monitor the condition of the animals for one month
-- if they are all happy/not ill/more good points than bad, award the player $5000

-- if there are unhappy animals, disable the animal adoption button for 
-- 1 month and charge the player $2500

-- there are 2 locid strings.. one for if they argue, and one if they don't
-- neither case is considered a failure

-- there is a failure string if they argue AND still have unhappy animals


	BFLOG(SYSTRACE, "evalanimalstress");
	
	challenge = getglobalvar("challenge");
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("animalstress");
		end
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		-- This means that they decided to argue
		
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:UI_DISABLE("open zoo toggle button");

			-- Now press the close zoo toggle
			local uimgr = queryObject("UIRoot");
			if (uimgr) then
				local closezoobutton = uimgr:UI_GET_CHILD("close zoo toggle button");
				if (closezoobutton) then		
					closezoobutton:UI_ACTIVATE_ON();
				end
			end
		end
		
		comp.argue = 1;
		showprimarygoals();
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		
		setglobalvar("challenge", nil);
		setglobalvar("challengeactive", "true");
		
		comp.argue = 0;
		
		takeCash(2500);
		
		-- Disable their ability to get new animals
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:UI_DISABLE("Buy Animal Tab");
			mgr:UI_DISABLE("Adopt Animal Tab");
		end
	end
	
	if (comp.argue == nil) then
		if (challenge == nil) then
			showchallengepanel("Challengetext:CHAnimalStress");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting")
		end
	end
	
	if (comp.argue ~= nil) then
		-- If we don't have a timer, then start one
		if (comp.stresstimer == nil) then
			comp.stresstimer = getCurrentMonth();
		end
		
		-- Only need to do something if they argued the charge
		if (comp.argue == 1) then
			
			-- Only do this once
			if (comp.startevalanimals == nil) then
				comp.startevalanimals = 1;
		
				comp.startbad = { };
				comp.startgood = { };
				
				-- Grab all of the objects of type type
				local objects = findType("animal");
	
				local num = 0;

				-- Loop through all of the objects in the table
				num = table.getn(objects);

				for i = 1, num do
					-- Grab the needpointsbad and good for each animal
					local single = resolveTable(objects[i].value);
					comp.startbad[single._this] = getNeedPointsBadCum(single);
					comp.startgood[single._this] = getNeedPointsGoodCum(single);
			
					if (getNeedPointsBadCum(single) ~= nil) then
						BFLOG(SYSTRACE, "Bad: "..getNeedPointsBadCum(single)..".");
					end
			
					if (getNeedPointsGoodCum(single) ~= nil) then
						BFLOG(SYSTRACE, "Good: "..getNeedPointsGoodCum(single)..".");
					end
				end
			end
		end
		
		
		-- Check to see if the month is over
		local monthnow = getCurrentMonth();
		if (monthnow > comp.stresstimer) then
			-- Finish up the challenge
			BFLOG(SYSTRACE, "animalstress - over");
			
			-- If they didn't decide to argue and the month is over, then let them adopt again
			if (comp.argue == 0) then
				-- Disable their ability to get new animals
				local mgr = queryObject("BFScenarioMgr");
				if (mgr) then
					mgr:UI_ENABLE("Buy Animal Tab");
					mgr:UI_ENABLE("Adopt Animal Tab");
				end
				
				return 1;
			end
			
			
			-- If they DID decide to argue, then we have to see if they met their animal needs or not
			if (comp.argue == 1) then
				-- Reopen the zoo
				local mgr = queryObject("BFScenarioMgr");
				if (mgr) then
					mgr:UI_ENABLE("open zoo toggle button");

					-- Now press the close zoo toggle
					local uimgr = queryObject("UIRoot");
					if (uimgr) then
						local openzoobutton = uimgr:UI_GET_CHILD("open zoo toggle button");
						if (openzoobutton) then		
							openzoobutton:UI_ACTIVATE_ON();
						end
					end
				end
			
			
				comp.endbad = { };
				comp.endgood = { }; 
		
				-- Grab all of the objects of type type
				local objects = findType("animal");
	
				local num = 0;

				-- Loop through all of the objects in the table
				num = table.getn(objects);

				for i = 1, num do
					BFLOG(SYSTRACE, "i = "..i..".");
		
					-- Grab the needpointsbad and good for each Elephant
					local single = resolveTable(objects[i].value);
					comp.endbad[single._this] = getNeedPointsBadCum(single);
					comp.endgood[single._this] = getNeedPointsGoodCum(single);
			
					if (getNeedPointsBadCum(single) ~= nil) then
						BFLOG(SYSTRACE, "Bad: "..getNeedPointsBadCum(single)..".");
					end
					
					if (getNeedPointsGoodCum(single) ~= nil) then
						BFLOG(SYSTRACE, "Good: "..getNeedPointsGoodCum(single)..".");
					end
				end
				
				
				-- Now we have all tables, so compare
				-- To see if each animal is ok
				for i = 1, num do
					local single = resolveTable(objects[i].value);
			
					local goodval = comp.endgood[single._this] - comp.startgood[single._this];
					local badval = comp.endbad[single._this] - comp.startbad[single._this];
			
					BFLOG(SYSTRACE, "!!!!!!!!  goodval = "..goodval.."    badval = "..badval..".");
				
					if (goodval - badval < 0) then
						BFLOG(SYSTRACE, "About to fail animalstress challenge");
						return -1;
					end
				end
				
				-- If we make it to here, then they argued successfully
				giveCash(5000);
				bigwin = 1;
				return 1;
			end
		end
	end	
end




function completeanimalstress(comp)
-- at the end of the 1 month timer, enable animal adoption button

-- or at the end of the 1 month timer, (with successful result) allow the zoo to be
-- opened

	if (bigwin ~= nil) then
		showchallengewin("Challengetext:CHAnimalStressSuccess");
	else
		showchallengewin("Challengetext:CHAnimalStressEnd");
	end

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("animalstress_over", "true");
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));

end


function failanimalstress(comp)
	-- this means that one of their animals was sad during the month assessment
	takeCash(2500);
	
	showchallengefail("Challengetext:CHAnimalStressArgueFailure");

	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	setglobalvar("animalstress_over", "true");
end