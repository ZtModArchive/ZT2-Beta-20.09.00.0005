-- garbagestrike.lua
-- garbage strike challenge

include "scenario/scripts/ui.lua";
include "scenario/scripts/entity.lua";
include "scenario/scripts/misc.lua";


-- This challenge is different because declining the challenge doesn't really
-- decline the challenge, it just changes it.



function evalgarbagestrike(comp)
-- starting condition: 150 guests and 5(?) workers on staff


-- disable the players ability to hire maintenance workers
-- remove the players existing workers and save them cause the come back 
-- set timer for 1 month
-- there are 2 paths the player can take... 
-- pay $8000 and have temporary "replacement" workers added to map.
-- should replace 1/2 the number the player previously had
-- or pay nothing and that's it... just has to wait it out

-- there are 2 locid strings.. one for if they pay, and one if they don't
-- neither case is considered a failure
-- if they don't pay use <CHAnimalStressShort> and <CHAnimalStressSuccessShort>
-- if they do pay use <CHAnimalStressPayShort> and <CHAnimalStressPaySuccessShort>


	BFLOG(SYSTRACE, "evalgarbagestrike");
	
	challenge = getglobalvar("challenge")
	
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("garbagestrike");
		end
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		-- Take away the $8000
		takeCash(8000);
	
	
		-- Give them 1/2 of their workers back
		local num = table.getn(comp.workersabducted);
		num = num / 2;
		
		for j = 1, num do
			-- Get the first worker
			local single = comp.workersabducted[1];
			
			-- Remove it from stasis
			removeFromStasis(single);
			
			BFLOG(SYSTRACE, "Removing a worker from stasis");
			
			-- Clear it out of the abductee list
			table.remove(comp.workersabducted, 1);
		end		
		
		comp.accept = 1;
		showprimarygoals();
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You 'declined'!");
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("garbagestrike");
		end
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		comp.decline = 1;
		showprimarygoals();
	end
	
	if ((comp.accept == nil) and (comp.decline == nil)) then
		if (challenge == nil) then
		
			comp.workersabducted = { };
		
			-- Get rid of all the players workers.  Just put them in stasis
			-- Grab all of the objects of type type
			local objects = findType("Worker");
			
			if (objects == 0) then
				BFLOG(SYSERROR, "Worker table is nil");
				return -1;
			end

			local num = 0;

			-- Loop through all of the objects in the table
			num = table.getn(objects);
			
			if (num ~= 5) then
				BFLOG(SYSTRACE, "Strange number of workers: "..num..".");
			end
			
			for i = 1, num do
				local single = resolveTable(objects[i].value);
				
				BFLOG(SYSTRACE, "Placing a worker into stasis");
				
				-- Put this worker into the abducted array
				comp.workersabducted[i] = single;
				
				-- And then put him in stasis
				putInStasis(single);
			end
			
			showchallengepanel("Challengetext:CHGarbageStrike");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting");
		end
	end
	
	-- when the challenge is going
	if ((comp.accept ~= nil) or (comp.decline ~= nil)) then
		if (comp.garbagetimer == nil) then
			comp.garbagetimer = getCurrentMonth();
		end
		
		-- If a month has passed, then return true
		local monthnow = getCurrentMonth();
		
		BFLOG(SYSTRACE, "old month: "..comp.garbagetimer.."  now: "..monthnow..".");
		
		if (monthnow > comp.garbagetimer) then
			-- whatever the player chose, after 1 month the previous workers are returned
			BFLOG(SYSTRACE, "completegarbagestrike");
	
			if (comp.workersabducted ~= nil) then
				-- Give them 1/2 of their workers back
				local num = table.getn(comp.workersabducted);
		
				for j = 1, num do
					-- Get the first worker
					local single = comp.workersabducted[j];
					
					BFLOG(SYSTRACE, "freeing a worker");
			
					-- Remove it from stasis
					removeFromStasis(single);
				end	

				-- Clear out the abducted workers array	
				comp.workersabducted = nil;
			else
				BFLOG(SYSTRACE, "workersabducted table is empty and shouldn't be!");
			end
		
			-- And now return 1
			return 1;
		end
	end	

end




function completegarbagestrike(comp)

	-- Show a different message depending on which option they chose
	if (comp.accept ~= nil) then
		showchallengewin("Challengetext:CHGarbageStrikePaySuccessShort");
	else
		showchallengewin("Challengetext:CHGarbageStrikeSuccessShort");
	end
	
	-- Set the standard variables
	BFLOG(SYSTRACE, "Completed garbage collect challenge");
	setglobalvar("challengeactive", "false");
	setglobalvar("garbagestrike_over", "true");
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));

end



