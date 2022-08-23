-- lua file for testing scenarios
-- Also has a elephant herd-ish scenario
----------------------------------------------------------------------------------


-- Include statements
include "scenario/scripts/misc.lua";
include "scenario/scripts/ui.lua";
include "scenario/scripts/entity.lua";
include "scenario/scripts/needs.lua";
include "scenario/scripts/economy.lua";




function setinitialzoostate(comp)
	BFLOG(SYSTRACE, "*********I'm here so show overview panel!********");
	completeshowoverview()
	showUI("goal panel", true);

	return 1;
end


function evalcratedelephant(arg)
	include "scenario/scripts/entity.lua";
	include "scenario/scripts/needs.lua";

	if thisManyExist("ElephantAfrican", 1) == true then
		 if allNeedSatisfied("ElephantAfrican", "environment") == true then
		 	return 1;
		 else
		 	BFLOG(SYSTRACE, "elephant is here but environment need not met");
			return 0;
		 end
	else
		BFLOG(SYSTRACE, "elephant not out yet");	
	end
end

function completecratedelephant(comp)
	BFLOG(SYSTRACE, "Adopted an elephant!");
	showRule("meetelephantneeds");
	showprimarygoals();
end


--function for 1 elephant to meet threshold of all basic needs
function evalmeetbasicneeds(comp)

	BFLOG(SYSTRACE, "Checking the elephant needs");
	
	if thisManyExist("ElephantAfrican", 1) == true then	
		if typeBasicNeedsSatisfied("ElephantAfrican") == true then
			return 1;
		else
			BFLOG(SYSTRACE, "all needs don't meet threshold");
			return 0;
		end
	end
		
	return 0;
end


function completemeetbasicneeds(comp)
	BFLOG(SYSTRACE, "met basic needs, getting more elephants!");
	showRule("fourelephants");
	showRule("getthreemoreelephants");
	showRule("meetenvironment");
	showRule("happyelephants");	
	
	completeshowoverview();
	
	-- First keep a reference around to the existing elephant
	-- so we don't crate him up
	-- Grab all of the objects of type type
	local keeptable = findType("ElephantAfrican");
	local num = 0;
	-- Loop through all of the objects in the table
	num = table.getn(keeptable);
	if (num ~= 1) then
		BFLOG(SYSTRACE, "Problem with completemeetbasicneeds");
	end
	-- This is the guy to not crate
	local keepme = resolveTable(keeptable[1].value);
	
	-- Now place the three new Elephants
	
	placeObject("ElephantAfrican_Adult_M", 85, 35, 0);
	placeObject("ElephantAfrican_Adult_F", 85, 35, 0);
	placeObject("ElephantAfrican_Adult_F", 85, 35, 0);
	
	
	-- Now crate these three guys
	local cratetable = findType("ElephantAfrican");
	local num = 0;
	num = table.getn(cratetable);
	
	BFLOG(SYSTRACE, "num: "..num..".");
	
	for i = 1,num do
		local single = resolveTable(cratetable[i].value);
		if (single ~= keepme) then
			crateEntity(single);
		end
	end
end


function evalthreemoreelephants(comp)
	if thisManyExist("ElephantAfrican", 4) == true then
		 return 1;
	else
		BFLOG(SYSTRACE, "new elephants not out yet");	
	end
end

function evalmeetenvironmentfourelephants(comp)
	if thisManyExist("ElephantAfrican", 4) == true then
		 if allNeedSatisfied("ElephantAfrican", "environment") == true then
			return 1;
		 else
			BFLOG(SYSTRACE, "four elephants here but environment need not met");
			return 0;
		 end
	end
end


function evalhappyelephants(comp)
	BFLOG(SYSTRACE, "evalhappyelephants");
	
	-- Only do this once
	if (comp.startevalhappyelephants == nil) then
		comp.startevalhappyelephants = 1;
		
		comp.startbad = { };
		comp.startgood = { };
		comp.happyelephanttimer = getCurrentMonth();
		
		-- Make a table of each elephant and it's good/bad need points
		-- Table points from safe handle pointer -> value
		
		-- Grab all of the objects of type type
		local objects = findType("ElephantAfrican");
	
		local num = 0;

		-- Loop through all of the objects in the table
		num = table.getn(objects);

		if (num ~= 4) then
			BFLOG(SYSTRACE, "You have a strange number of elephants!!!!!");
		end

		for i = 1, num do
			-- Grab the needpointsbad and good for each Elephant
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
	
	-- Check to see if the three months are over
	local curmonth = getCurrentMonth();
	
	BFLOG(SYSTRACE, "start month: "..comp.happyelephanttimer.."   current month: "..curmonth);
	
	if (curmonth >= comp.happyelephanttimer + 3) then
	
		BFLOG(SYSTRACE, "Finishing evalhappyelephants goal");
	
		-- If so, we'll end the goal here one way or another
		
		comp.endbad = { };
		comp.endgood = { }; 
		
		-- Grab all of the objects of type type
		local objects = findType("ElephantAfrican");
	
		local num = 0;

		-- Loop through all of the objects in the table
		num = table.getn(objects);

		-- If there are less than 4 elephants, they should fail
		if (num ~= 4) then
			BFLOG(SYSTRACE, "You have a strange number of elephants!!!!!");
			
			if (num < 4) then
				BFLOG("You have < 4 elephants.  Most likely one of them died.");
				return -1;
			end
		end

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

	
		-- Now that we have all tables, check each elephant one at a time
		-- To see if he's ok
		for i = 1, num do
			local single = resolveTable(objects[i].value);
			
			local goodval = comp.endgood[single._this] - comp.startgood[single._this];
			local badval = comp.endbad[single._this] - comp.startbad[single._this];
			
			BFLOG(SYSTRACE, "!!!!!!!!  goodval = "..goodval.."    badval = "..badval..".");
			
			if (goodval - badval < 0) then
				return -1;
			end
		end

		-- If we make it here then we passed
		return 1;

	end
	
	
	return 0;
	
end


function completethreemoreelephants()	
	BFLOG(SYSTRACE, "WIN");
	
	local alreadydone = getuservar("campaign2scenario2");
	
	if (alreadydone ~= "completed") then
		setuservar("campaign2scenario2", "unlocked");
	end
	
	showscenariowin("ElephantHerdScenarioGoals:finishmeetneedsoverview", "campaign2scenario2");
end


function failthreemoreelephants()
	
	-- TODO: remove all the elephants from the map

	showscenariofail("ElephantHerdScenarioGoals:failedmeetneeds", "campaign2scenario1");

end




----------------- SCENARIO 2 FUNCTIONS--------------

function evalcratedzebras()
	if thisManyExist("ZebraCommon", 6) == true then
		 if allNeedSatisfied("ZebraCommon","environment") == true then
		 	return 1;
		 else
		 	BFLOG(SYSTRACE, "zebras here but environment need not met");
			return 0;
		 end
	else
		BFLOG(SYSTRACE, "zebras not out yet");	
	end
end



function evalcratedlions()
	if thisManyExist("Lion", 8) == true then
		 if allNeedSatisfied("Lion","environment") == true then
		 	return 1;
		 else
		 	BFLOG(SYSTRACE, "lions here but environment need not met");
			return 0;
		 end
	else
		BFLOG(SYSTRACE, "lions not out yet");	
	end
end





function evalmeetgroupsbasicneeds()
	if typeBasicNeedsSatisfied("ZebraCommon") == true  and typeBasicNeedsSatisfied("Lion") == true then
		return 1;
	else
		BFLOG(SYSTRACE, "zebra and lion needs don't meet threshold");
	end

end



function completezebrasandlions()
	BFLOG(SYSTRACE, "Zebras and lions in good shape!");
	showRule("adoptchimps");
	completeshowoverview();	
	
	-- Place the chimps to be crated
	for i = 1, 7 do
		placeObject("Chimpanzee_Adult_F", 30, 10, 0);
	end
	
	-- Now crate these seven guys
	local cratetable = findType("Chimpanzee");
	local num = 0;
	num = table.getn(cratetable);
	
	for i = 1,num do
		local single = resolveTable(cratetable[i].value);
		if (single ~= keepme) then
			crateEntity(single);
		end
	end
	
	-- give cash grant $8K I do this below but this panel is a problem as it comes up
	-- over the goal panel. How do we handle this? Can we sequence it (e.g. show the cash panel
	-- after the overview panel has been closed?
	giveCash(8000);
	
end

function evalcratedchimps()
	-- need to place 7 chimps in crates somewhere near the gate... 
	
	if thisManyExist("Chimpanzee", 7) == true then
		 if typeBasicNeedsSatisfied("Chimpanzee") == true then
		 	return 1;
		 else
		 	BFLOG(SYSTRACE, "chimps here but basic needs not met");
			return 0;
		 end
	else
		BFLOG(SYSTRACE, "chimps not out yet");	
	end
end




function completecamp2scen2()
-- NEED TO ADD unlock next scenario

	BFLOG(SYSTRACE, "WIN");
	
	local alreadydone = getuservar("campaign2scenario3");
	
	if (alreadydone ~= "completed") then
		setuservar("campaign2scenario3", "unlocked");
	end
	
	showscenariowin("ElephantHerdScenarioGoals:finishCruelscenariooverview", "campaign2scenario3");
end

function failcamp2scen2()
-- NEED TO ADDremove any zebras, lions and chimps

	showscenariofail("ElephantHerdScenarioGoals:failedCruelscenariooverview");
end


----------------------------------------------------------------------------------------
					-- SCENARIO 3 FUNCTIONS
-----------------------------------------------------------------------------------------



-- the following crated animals are to be given out in this order
	-- Kangaroo_Adult_F
	-- TigerBengal_Adult_M
	-- BearGrizzly_Adult_M
	-- GorillaMountain_Adult_F
	-- RhinocerosBlack_Adult_M
	-- ElephantAfrican_Adult_F
	-- LeopardSnow_Adult_M
-- map starts with crated kangaroo placed
-- start timer
-- an animal needs to be delivered every 5 minutes real time or  every 1/3 a month 
	-- may need to tweak this of course
-- when the next animal is delivered, the next rule needs to be shown
	-- it can't be tied to the completion of previous rule as time may not
	-- have elapsed
	-- names of hidden rules are
		-- bengaltiger
		-- grizzlybear
		-- gorilla
		-- rhino
		-- elephant
		-- snowleopard
	
-- if the previous animal is still crated when new one delivered
	-- then scenario is failed
-- if animal was uncrated but their environment isn't suitable when the new animal is delivered
	-- then failed
-- if any previously uncrated animal accumulates too many bad points (set this at 50 and lets see)
	-- then failed


function evalkangaroo(comp)
-- check for kangaroo in world
-- check that environment need is met
-- rule for this is not sticky

	BFLOG(SYSTRACE, "evalkangaroo");
	
	if (comp.kangarootimer == nil) then
		comp.kangarootimer = getCurrentTimeOfDay();
	end
	
	local timenow = getCurrentTimeOfDay();
	
	local dif = 0;
	
	-- If the timer hasn't looped over, then subtract
	if (timenow >= comp.kangarootimer) then
		dif = timenow - comp.kangarootimer;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	else
		-- Otherwise we need a difference
		dif = (1 - comp.kangarootimer) + timenow;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	end

	BFLOG(SYSTRACE, "timer = "..comp.kangarootimer.."  timenow = "..timenow.."  dif = "..dif..".");

	if (dif > 0.1) then
		BFLOG(SYSTRACE, "TIME UP");
		if (thisManyExist("Kangaroo", 1) == true) then
			if (allNeedSatisfied("Kangaroo", "environment")) then
				return 1;
			end
		end
		
		BFLOG(SYSTRACE, "about to fail");
		return -1;
	end

	return 0;
end


function completekangaroo(comp)
	BFLOG(SYSTRACE, "completekangaroo");

	if (comp.gavetiger == nil) then
		-- Give out the next animal
		placeObject("TigerBengal_Adult_M", 135, 20, 0);
		local entitytocrate = findType("TigerBengal");
		local single = resolveTable(entitytocrate[1].value);
		crateEntity(single);
		showRule("bengaltiger");
		showprimarygoals();
					
		comp.gavetiger = 1;
	end
end


function evalbengaltiger(comp)
-- check for tiger in world
-- check that environment need is met
-- rule for this is not sticky
	BFLOG(SYSTRACE, "evalbengaltiger");
	
	if (comp.tigertimer == nil) then
		comp.tigertimer = getCurrentTimeOfDay();
	end
	
	local timenow = getCurrentTimeOfDay();
	
	local dif = 0;
	
	-- If the timer hasn't looped over, then subtract
	if (timenow >= comp.tigertimer) then
		dif = timenow - comp.tigertimer;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	else
		-- Otherwise we need a difference
		dif = (1 - comp.tigertimer) + timenow;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	end

	BFLOG(SYSTRACE, "timer = "..comp.tigertimer.."  timenow = "..timenow.."  dif = "..dif..".");

	if (dif > 0.1) then
		BFLOG(SYSTRACE, "TIME UP");
		if (thisManyExist("TigerBengal", 1) == true) then
			if (allNeedSatisfied("TigerBengal", "environment")) then
				return 1;
			end
		end
		
		BFLOG(SYSTRACE, "about to fail");
		return -1;
	end

	return 0;
end


function completebengaltiger(comp)
	BFLOG(SYSTRACE, "completebengaltiger");

	if (comp.gavegrizzly == nil) then
		-- Give out the next animal
		placeObject("BearGrizzly_Adult_M", 135, 20, 0);
		local entitytocrate = findType("BearGrizzly");
		local single = resolveTable(entitytocrate[1].value);
		crateEntity(single);
		showRule("grizzlybear");
		showprimarygoals();
					
		comp.gavegrizzly = 1;
	end
end



function evalgrizzlybear(comp)
-- check for grizzly in world
-- check that environment need is met
-- rule for this is not sticky

	BFLOG(SYSTRACE, "evalgrizzlybear");
	
	if (comp.grizzlytimer == nil) then
		comp.grizzlytimer = getCurrentTimeOfDay();
	end
	
	local timenow = getCurrentTimeOfDay();
	
	local dif = 0;
	
	-- If the timer hasn't looped over, then subtract
	if (timenow >= comp.grizzlytimer) then
		dif = timenow - comp.grizzlytimer;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	else
		-- Otherwise we need a difference
		dif = (1 - comp.grizzlytimer) + timenow;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	end

	BFLOG(SYSTRACE, "timer = "..comp.grizzlytimer.."  timenow = "..timenow.."  dif = "..dif..".");

	if (dif > 0.1) then
		BFLOG(SYSTRACE, "TIME UP");
		if (thisManyExist("BearGrizzly", 1) == true) then
			if (allNeedSatisfied("BearGrizzly", "environment")) then
				return 1;
			end
		end
		
		BFLOG(SYSTRACE, "about to fail");
		return -1;
	end

	return 0;


end


function completegrizzlybear(comp)
	BFLOG(SYSTRACE, "completegrizzlybear");

	if (comp.gavegorilla == nil) then
		-- Give out the next animal
		placeObject("GorillaMountain_Adult_F", 135, 20, 0);
		local entitytocrate = findType("GorillaMountain");
		local single = resolveTable(entitytocrate[1].value);
		crateEntity(single);
		showRule("gorilla");
		showprimarygoals();
					
		comp.gavegorilla = 1;
	end
end



function evalgorilla(comp)
-- check for gorilla in world
-- check that environment need is met
-- rule for this is not sticky


	BFLOG(SYSTRACE, "evalgorilla");
	
	if (comp.gorillatimer == nil) then
		comp.gorillatimer = getCurrentTimeOfDay();
	end
	
	local timenow = getCurrentTimeOfDay();
	
	local dif = 0;
	
	-- If the timer hasn't looped over, then subtract
	if (timenow >= comp.gorillatimer) then
		dif = timenow - comp.gorillatimer;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	else
		-- Otherwise we need a difference
		dif = (1 - comp.gorillatimer) + timenow;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	end

	BFLOG(SYSTRACE, "timer = "..comp.gorillatimer.."  timenow = "..timenow.."  dif = "..dif..".");

	if (dif > 0.1) then
		BFLOG(SYSTRACE, "TIME UP");
		if (thisManyExist("GorillaMountain", 1) == true) then
			if (allNeedSatisfied("GorillaMountain", "environment")) then
				return 1;
			end
		end
		
		BFLOG(SYSTRACE, "about to fail");
		return -1;
	end

	return 0;


end


function completegorilla(comp)
	BFLOG(SYSTRACE, "completegorilla");

	if (comp.gaverhino == nil) then
		-- Give out the next animal
		placeObject("RhinocerosBlack_Adult_M", 135, 20, 0);
		local entitytocrate = findType("RhinocerosBlack");
		local single = resolveTable(entitytocrate[1].value);
		crateEntity(single);
		showRule("rhino");
		showprimarygoals();
					
		comp.gaverhino = 1;
	end
end




function evalrhino(comp)
-- check for rhino in world
-- check that environment need is met
-- rule for this is not sticky


	BFLOG(SYSTRACE, "evalrhino");
	
	if (comp.rhinotimer == nil) then
		comp.rhinotimer = getCurrentTimeOfDay();
	end
	
	local timenow = getCurrentTimeOfDay();
	
	local dif = 0;
	
	-- If the timer hasn't looped over, then subtract
	if (timenow >= comp.rhinotimer) then
		dif = timenow - comp.rhinotimer;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	else
		-- Otherwise we need a difference
		dif = (1 - comp.rhinotimer) + timenow;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	end

	BFLOG(SYSTRACE, "timer = "..comp.rhinotimer.."  timenow = "..timenow.."  dif = "..dif..".");

	if (dif > 0.1) then
		BFLOG(SYSTRACE, "TIME UP");
		if (thisManyExist("RhinocerosBlack", 1) == true) then
			if (allNeedSatisfied("RhinocerosBlack", "environment")) then
				return 1;
			end
		end
		
		BFLOG(SYSTRACE, "about to fail");
		return -1;
	end

	return 0;


end


function completerhino(comp)
	BFLOG(SYSTRACE, "completerhino");

	if (comp.gaveelephant == nil) then
		-- Give out the next animal
		placeObject("ElephantAfrican_Adult_M", 135, 20, 0);
		local entitytocrate = findType("ElephantAfrican");
		local single = resolveTable(entitytocrate[1].value);
		crateEntity(single);
		showRule("elephant");
		showprimarygoals();
					
		comp.gaveelephant = 1;
	end
end



function evalelephant(comp)
-- check for elephant in world
-- check that environment need is met
-- rule for this is not sticky


	BFLOG(SYSTRACE, "evalelephant");
	
	if (comp.elephanttimer == nil) then
		comp.elephanttimer = getCurrentTimeOfDay();
	end
	
	local timenow = getCurrentTimeOfDay();
	
	local dif = 0;
	
	-- If the timer hasn't looped over, then subtract
	if (timenow >= comp.elephanttimer) then
		dif = timenow - comp.elephanttimer;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	else
		-- Otherwise we need a difference
		dif = (1 - comp.elephanttimer) + timenow;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	end

	BFLOG(SYSTRACE, "timer = "..comp.elephanttimer.."  timenow = "..timenow.."  dif = "..dif..".");

	if (dif > 0.1) then
		BFLOG(SYSTRACE, "TIME UP");
		if (thisManyExist("ElephantAfrican", 1) == true) then
			if (allNeedSatisfied("ElephantAfrican", "environment")) then
				return 1;
			end
		end
		
		BFLOG(SYSTRACE, "about to fail");
		return -1;
	end

	return 0;



end


function completeelephant(comp)
	BFLOG(SYSTRACE, "completeelephant");

	if (comp.gavesnow == nil) then
		-- Give out the next animal
		placeObject("LeopardSnow_Adult_M", 135, 20, 0);
		local entitytocrate = findType("LeopardSnow");
		local single = resolveTable(entitytocrate[1].value);
		crateEntity(single);
		showRule("snowleopard");
		showprimarygoals();
					
		comp.gavesnow = 1;
	end
end


function evalsnowleopard(comp)
-- check for snowleopard in world
-- check that environment need is met
-- rule for this is not sticky


	BFLOG(SYSTRACE, "evalsnowleopard");
	
	if (comp.snowtimer == nil) then
		comp.snowtimer = getCurrentTimeOfDay();
	end
	
	local timenow = getCurrentTimeOfDay();
	
	local dif = 0;
	
	-- If the timer hasn't looped over, then subtract
	if (timenow >= comp.snowtimer) then
		dif = timenow - comp.snowtimer;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	else
		-- Otherwise we need a difference
		dif = (1 - comp.snowtimer) + timenow;
		BFLOG(SYSTRACE, "setting dif = "..dif..".");
	end

	BFLOG(SYSTRACE, "timer = "..comp.snowtimer.."  timenow = "..timenow.."  dif = "..dif..".");

	if (dif > 0.1) then
		BFLOG(SYSTRACE, "TIME UP");
		if (thisManyExist("LeopardSnow", 1) == true) then
			if (allNeedSatisfied("LeopardSnow", "environment")) then
				return 1;
			end
		end
		
		BFLOG(SYSTRACE, "about to fail");
		return -1;
	end

	return 0;


end


function failmeetenvironment(comp)
	showscenariofail("SmugglingRing:SmugglingRingFailureoverview", "campaign2scenario3");
end


function completesnowleopard(comp)
	showRule("letemgo");
	
	showprimarygoals();
end


function evalreleasesmuggledanimals(comp)
-- the specific animals that were given to the player
	-- need to be released to the wild
-- once you get to here you really can't fail per se
-- need to make sure that those specific animals are tracked
	-- e.g. they could in theory be adding other animals of the same type to the zoo
-- once they are all released, you win!

-- Kangaroo_Adult_F
	-- TigerBengal_Adult_M
	-- BearGrizzly_Adult_M
	-- GorillaMountain_Adult_F
	-- RhinocerosBlack_Adult_M
	-- ElephantAfrican_Adult_F
	-- LeopardSnow_Adult_M

	if (comp.numrel == nil) then
		comp.numrel = getAnimalsReleased();
	end

	local howmanyrel = getAnimalsReleased();
	
	if (howmanyrel > comp.numrel) then
	
		-- FIrst init the animal counters and the bools if they haven't been set yet
		if (comp.numkang == nil) then
			comp.numkang = countType("Kangaroo_Adult_F");
			comp.numtiger = countType("TigerBengal_Adult_M");
			comp.numbear = countType("BearGrizzly_Adult_M");
			comp.numgorilla = countType("GorillaMountain_Adult_F");
			comp.numrhino = countType("RhinocerosBlack_Adult_M");
			comp.numelephant = countType("ElephantAfrican_Adult_F");
			comp.numleopard = countType("LeopardSnow_Adult_M");
		end
		
		if (comp.kangok == nil) then
			comp.donekang = false;
			comp.donetiger = false;
			comp.donebear = false;
			comp.donegorilla = false;
			comp.donerhino = false;
			comp.doneelephant = false;
			comp.doneleopard = false;
		end
		
		-- Count the number of each animal around now
		local kang = countType("Kangaroo_Adult_F");
		local tiger = countType("TigerBengal_Adult_M");
		local bear = countType("BearGrizzly_Adult_M");
		local gorilla = countType("GorillaMountain_Adult_F");
		local rhino = countType("RhinocerosBlack_Adult_M");
		local elephant = countType("ElephantAfrican_Adult_F");
		local leopard = countType("LeopardSnow_Adult_M");
		
		-- If they have less of any animal, then that is the one adopted
		if (kang < comp.numkang) then
			comp.donekang = true;
		elseif (tiger < comp.numtiger) then
			comp.donetiger = true;
		elseif (bear < comp.numtiger) then
			comp.donebear = true;
		elseif (gorilla < comp.numgorilla) then
			comp.donegorilla = true;
		elseif (rhino < comp.numrhino) then
			comp.donerhino = true;
		elseif (elephant < comp.numelephant) then
			comp.doneelephant = true;
		elseif (leopard < comp.numleopard) then
			comp.doneleopard = true;
		end
		
		-- Now update the old running totals
		comp.numkang = kang;
		comp.numtiger = tiger;
		comp.numbear = bear;
		comp.numgorilla = gorilla;
		comp.numrhino = rhino;
		comp.numelephant = elephant;
		comp.numleopard = leopard;
	end
	
	-- Check to see if everything is satisfied, if so return 1
	if (comp.donekang ~= nil) then
		if (comp.donekang == false) then
			return 0;
		elseif (comp.donetiger == false) then
			return 0;
		elseif (comp.donebear == false) then
			return 0;
		elseif (comp.donegorilla == false) then
			return 0;
		elseif (comp.donerhino == false) then
			return 0;
		elseif (comp.doneelephant == false) then
			return 0;
		elseif (comp.doneleopard == false) then
			return 0;
		else
			return 1;
		end
	end

	return 0;
end



function completecamp2scen3()
-- give a reward object!
-- player gets the sundial unlocked!
-- locked with s_ProfileLock="sundiallock"

	setuservar("campaign2scenario3", "completed");
	
	setuservar("sundiallock", "true");
	
	showscenariowinhidenext("SmugglingRing:SmugglingRingPart2Successoverview");
end

function failcamp2scen3()
-- if animal dies
-- if environment need not met when new animal arrives (or becomes not met after that)
-- if any animal accumulates too many bad points 
end



