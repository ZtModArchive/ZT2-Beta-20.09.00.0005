-- lua file for campaign 1 scenarios

----------------------------------------------------------------------------------


-- Include statement
include "scenario/scripts/misc.lua";
-- include "scenario/scripts/test.lua";

include "scenario/scripts/entity.lua";
include "scenario/scripts/needs.lua";
include "scenario/scripts/ui.lua";


function evalNeutral(comp)
	return 0;
end

function evalSuccess(comp)
	return 1;
end

function evalFailure(comp)
	return -1;
end

----------------------------------------------------------------------------------

function executeSuccess(arg)
	BFLOG(SYSTRACE, "Success.");
end

function executeFailure(arg)
	BFLOG(SYSTRACE, "Failure.");
end

----------------------------------------------------------------------------------

function sickneedmet()
	if areAnySick() == true then
		BFLOG(SYSTRACE, "Animals still sick.");
		return 0;
	else
		return 1;
	end
end

function foodneedmet(comp)
	local count = 0;
	local animals = findType("animal");
	local numEntities = 0;

	if (animals ~= nil) then
			
		numEntities = table.getn(animals);
		for i = 1,numEntities do
			local animal = resolveTable(animals[i].value);
			
			if (not needSatisfied(animal, "hunger")) then
				count = count + 1;
			end
		end
	end
	
	
	
	if (count < 1) then
		return 1;
	else
		BFLOG(SYSTRACE, "Animals still critically hungry.");
		return 0;
	end
end

function gainzoofame()
	local mgr = queryObject("ZTStatus");
	if (mgr) then
		local zoofame = mgr:ZT_GET_ZOO_FAME();
		BFLOG(SYSTRACE, "Zoo fame is..." ..zoofame);
		if zoofame >= 40 then
			return 1;
		else
			return 0;
		end
	end
end


function finishcampaign(comp)

	local alreadydone = getuservar("campaign1scenario3");
	
	if (alreadydone ~= "completed") then
		setuservar("campaign1scenario3", "unlocked");
	end
	
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
		if (gotooverview) then
			gotooverview:UI_ACTIVATE_OFF();
			gotooverview:UI_ACTIVATE_ON();
		end
	end	
	
	BFLOG(SYSTRACE, "Winner.");
	--showUI("goals layout", true);
	
	-- Set the next scenario global var
	setglobalvar("nextScenario", "campaign1scenario3");
	
	-- award the flowered path arch
	-- locked with s_ProfileLock="flowerarchlock"
	setuservar("flowerarchlock", "true");
	
	-- Give them the completed scenario window
	showscenariowinhidenext("C1scenariogoals:S4success");
	
end


function C1finalwin(comp)
	giveaward("awards/BronzeSealParkRedevelopment.xml")
	FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 5
	
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
		if (gotooverview) then
			gotooverview:UI_ACTIVATE_OFF();
			gotooverview:UI_ACTIVATE_ON();
		end
	end	
	
	BFLOG(SYSTRACE, "Winner.");
	--showUI("goals layout", true);
	
	-- Give them the completed scenario window
	showscenariowin("C1scenariogoals:C1youwin", "campaign1scenario2");
	
	-- award the flowered path arch
	-- locked with s_ProfileLock="flowerarchlock"
end


------------- *******************----------------------
-- need to add these functions to handle an animal death event
-- if an animal dies at any time, scenario should be failed

function failC1part1()
end

function failC1()
end

----------------------------------

function setinitialzoostate(comp)

	if (disableUIelements == nil) then
		local zoogate = countType("frontgate_df");
		if (zoogate > 0) then
		BFLOG(SYSTRACE, "Disabling UI Elements");
		local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				mgr:UI_DISABLE("Buy Animal Tab");
				mgr:UI_DISABLE("Adopt Animal Tab");
				mgr:UI_DISABLE("open zoo toggle button");
				disableUIelements = 1;
					local uimgr = queryObject("UIRoot");
					if (uimgr) then
						local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
						if (gotooverview) then
							gotooverview:UI_ACTIVATE_OFF();
							gotooverview:UI_ACTIVATE_ON();
						end
						local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
						if (goalpanel) then
							goalpanel:ZT_AUTOPOPULATE_LIST();
						end
						local panel = uimgr:UI_GET_CHILD("MainGUI");
						if (panel) then
							local pressanimalbutton = panel:UI_GET_CHILD("animals")
							if (pressanimalbutton) then
								pressanimalbutton:UI_ACTIVATE_ON();
							end
							local pressanimalenrich = panel:UI_GET_CHILD("Animal Enrichment Tab");
							if (pressanimalenrich) then
								pressanimalenrich:UI_ACTIVATE_ON();
							end
							
							if (pressanimalbutton) then
								pressanimalbutton:UI_ACTIVATE_OFF();
							end							
						end
					end
					BFLOG(SYSTRACE, "show goal panel overview");
					showUI("goals layout", true);
				return 1;
			end
		end	
	end
	return 0;
end

function setinitialzoostatescenario2(comp)

	if (disableUIelements2 == nil) then
		local zoogate = countType("frontgate_df");
		if (zoogate > 0) then
		BFLOG(SYSTRACE, "Disabling UI Elements");
		local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				mgr:UI_DISABLE("Buy Animal Tab");
				mgr:UI_DISABLE("Adopt Animal Tab");
				disableUIelements2 = 1;
					local uimgr = queryObject("UIRoot");
					if (uimgr) then
						local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
						if (gotooverview) then
							gotooverview:UI_ACTIVATE_OFF();
							gotooverview:UI_ACTIVATE_ON();
						end
						local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
						if (goalpanel) then
							goalpanel:ZT_AUTOPOPULATE_LIST();
						end
						local panel = uimgr:UI_GET_CHILD("MainGUI");
						if (panel) then
							local pressanimalbutton = panel:UI_GET_CHILD("animals")
							if (pressanimalbutton) then
								pressanimalbutton:UI_ACTIVATE_ON();
							end
							local pressanimalenrich = panel:UI_GET_CHILD("Animal Enrichment Tab");
							if (pressanimalenrich) then
								pressanimalenrich:UI_ACTIVATE_ON();
							end
							
							if (pressanimalbutton) then
								pressanimalbutton:UI_ACTIVATE_OFF();
							end							
						end
					end
					BFLOG(SYSTRACE, "show goal panel overview");
					showUI("goals layout", true);
				return 1;
			end
		end	
	end
	return 0;
end

function setinitialzoostatescenario3(comp)

	if (showUIelements3 == nil) then
		local zoogate = countType("frontgate_df");
		if (zoogate > 0) then
			BFLOG(SYSTRACE, "Show UI Elements");
			showUIelements3 = 1;
			local uimgr = queryObject("UIRoot");
			if (uimgr) then
				local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
				if (gotooverview) then
					gotooverview:UI_ACTIVATE_OFF();
					gotooverview:UI_ACTIVATE_ON();
				end
				local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
				if (goalpanel) then
					goalpanel:ZT_AUTOPOPULATE_LIST();
				end
			end
			BFLOG(SYSTRACE, "show goal panel overview");
			showUI("goals layout", true);
		end
		return 1;
	end
	return 0;
end
	


function completeprivacygoal(comp)
	BFLOG(SYSTRACE, "Completed privacy goal");
	if (comp.privacygoalpanel == nil) then
		local uimgr = queryObject("UIRoot");
		if (uimgr) then
			local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
			if (goalpanel) then
				goalpanel:ZT_AUTOPOPULATE_LIST();
			end
			local gotoprimarygoals = uimgr:UI_GET_CHILD("primary goals tab");
			if (gotoprimarygoals) then
				gotoprimarygoals:UI_REPRESS();			
				gotoprimarygoals:UI_ACTIVATE_ON();
			end
		end	
		showUI("goals layout", true);
		comp.privacygoalpanel = 1
	end
	
end

function completeC1part1(comp)

	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		mgr:BFS_SHOWRULE("C1Scenariopart2");
		mgr:UI_ENABLE("open zoo toggle button");
		mgr:UI_ENABLE("Buy Animal Tab");
		mgr:UI_ENABLE("Adopt Animal Tab");
		
	end
	local mgr = queryObject("ZTEconomyMgr");
	if (mgr) then
		local now = mgr:ZT_GET_ZOO_CASH();
		now = now + 5000;
		mgr:ZT_SET_ZOO_CASH(now);
	end
	
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
		if (gotooverview) then
			gotooverview:UI_REPRESS();
			gotooverview:UI_ACTIVATE_OFF();
			gotooverview:UI_ACTIVATE_ON();
		end
	end	
	
	BFLOG(SYSTRACE, "Completed PART 1");
	showUI("goals layout", true);
	
end

function completeC1scen2(comp)

	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		mgr:UI_ENABLE("Buy Animal Tab");
		mgr:UI_ENABLE("Adopt Animal Tab");
		
	end
	local mgr = queryObject("ZTEconomyMgr");
	if (mgr) then
		local now = mgr:ZT_GET_ZOO_CASH();
		now = now + 5000;
		mgr:ZT_SET_ZOO_CASH(now);
	end
	
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
		if (gotooverview) then
			gotooverview:UI_ACTIVATE_OFF();
			gotooverview:UI_ACTIVATE_ON();
		end
	end	
	
	BFLOG(SYSTRACE, "Completed PART 1");
	--showUI("goals layout", true);
	
	-- Unlock scenario #3
	setuservar("campaign1scenario2", "completed");
	
	local alreadydone = getuservar("campaign1scenario3");
	if (alreadydone ~= "completed") then
		setuservar("campaign1scenario3", "unlocked");
	end
	
	-- Give them the completed scenario window
	showscenariowin("C1scenariogoals:S3success", "campaign1scenario3");
	
end

function completeC1scen3part1(comp)

	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		mgr:BFS_SHOWRULE("gainzoofameof3");
		
	end

	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
		if (gotooverview) then
			gotooverview:UI_ACTIVATE_OFF();
			gotooverview:UI_ACTIVATE_ON();
		end
	end	
	
	BFLOG(SYSTRACE, "Completed PART 1");
	showUI("goals layout", true);
	
end

function animalbasicneeds(comp)
	local count = 0;
	local animals = findType("animal");
	local numEntities = 0;

	if (animals ~= nil) then
			
		numEntities = table.getn(animals);
		for i = 1,numEntities do
			local animal = resolveTable(animals[i].value);
			if (basicNeedsSatisfied(animal)) then
				count = count + 1;
			end
		end
	end
	
	BFLOG(SYSTRACE, "Count is " ..count);
	if (count == 0) or (count < 5) then
	BFLOG(SYSTRACE, "basic needs not met");
		return 0;
	else
		BFLOG(SYSTRACE, "Count is "..count.."out of"..numEntities.." animals.");
		return 1;
	end
end



function adoptnewanimal(comp)
	local checkanimals = findType("animal");
	
	if (checkanimals ~= nil) then
		local numEntities = table.getn(checkanimals);
		if numEntities > 5 then
			return 1;
		else
			return 0;
		end
		
	end
	
end


function needdonationboxes(comp)
	local boxes = countType("donationbox");
	BFLOG(SYSTRACE, "Donation boxes in zoo is "..boxes);
	if (boxes >= 3) then
		return 1;
	else
		return 0;
	end
end



function shelterneedmet(comp)
	
	local count = 0;
	local animals = findType("animal");
	local numEntities = 0;

	if (animals ~= nil) then
			
		numEntities = table.getn(animals);
		for i = 1,numEntities do
			local animal = resolveTable(animals[i].value);
			
			if (needSatisfied(animal, "privacy")) then
			
					--local privacy = animal:BFG_GET_ATTR_FLOAT("privacy");
					--BFLOG(SYSTRACE, "Privacy is ["..privacy.. "]");
					--if privacy < 50 then
				count = count + 1;
			end
		end
	end
	
	BFLOG(SYSTRACE, "Count is " ..count);
	if (count == 0) or (count ~= numEntities) then
	BFLOG(SYSTRACE, "shelter needs not met");
		return 0;
	else
		BFLOG(SYSTRACE, "Count is "..count.."out of"..numEntities.." animals.");
		return 1;
	end
end

function environmentneedmet(comp)
	
	local count = 0;
	local animals = findType("animal");
	local numEntities = 0;

	if (animals ~= nil) then
			
		numEntities = table.getn(animals);
		
		BFLOG(SYSTRACE, "numEntities - "..numEntities..".");
		
		for i = 1,numEntities do
			local animal = resolveTable(animals[i].value);
			local environment = animal:BFG_GET_ATTR_FLOAT("environment");
					BFLOG(SYSTRACE, "Environment is ["..environment.. "]");
			if environment < 35 then
				count = count + 1;
			end
		end
	end
	
	BFLOG(SYSTRACE, "Count is " ..count);
	if (count == 0) or (count ~= numEntities) then
	BFLOG(SYSTRACE, "environment needs not met");
		return 0;
	else
		BFLOG(SYSTRACE, "Count is "..count.."out of"..numEntities.." animals.");
		return 1;
	end
end





function cleanexhibits(comp)
	local poop = countType("Poop");
	local keepers = countType("Keeper");
	BFLOG(SYSTRACE, "Keepers in zoo is "..keepers);
	BFLOG(SYSTRACE, "Poo in zoo is "..poop);
	if (poop <= 0) and (keepers >= 2) then
		return 1;
	else
		return 0;
	end
end

function evaltrashcan(arg)
	local gameMgr=queryObject("BFGManager");
	local workers = countType("Worker");
	BFLOG(SYSTRACE, "Workers in zoo is "..workers);
	local trash = countType("TrashGround");
	BFLOG(SYSTRACE, "Trash in zoo is "..trash);
	local recycle = countType("RecyclableGround");
	BFLOG(SYSTRACE, "Recycle trash in zoo is "..recycle);
	local numEntities = 0;
	if (gameMgr ~= nil) then
		local entityList = gameMgr:BFG_GET_ENTITIES("trashcan_df");
		if (entityList ~= nil and type(entityList) == "table") then
			numEntities = table.getn(entityList);
			for i = 1, numEntities do
				local trashcan = resolveTable(entityList[i].value);
				if (trashcan ~= nil) then
					local trashlevel = trashcan:BFG_GET_ATTR_FLOAT("f_TrashLevel")
					BFLOG(SYSTRACE, "Trash level is ["..trashlevel.."]");
					if (trashlevel > 20) then
						return 0;
					end	
				end
			end
		end
	end
	
	if numEntities > 0 and (workers >= 2) and (trash < 1) and (recycle < 1)then
		return 1;
	else
		return 0;
	end
end



function querytrashcan(arg)
	local gameMgr=queryObject("BFGManager");
	if (gameMgr ~= nil) then
		local entityList = gameMgr:BFG_GET_ENTITIES("trashcan_df");
		if (entityList ~= nil and type(entityList) == "table") then
			local numEntities = table.getn(entityList);
			for i = 1, numEntities do
				local trashcan = resolveTable(entityList[i].value);
				if (trashcan ~= nil) then
					local trashlevel = trashcan:BFG_GET_ATTR_FLOAT("f_TrashLevel")
					BFLOG(SYSTRACE, "Trash level is ["..trashlevel.."]");
				end
			end
		end
	end
	return 0;
end	


function trashcanstate(comp)
	local count = countNeed("trashcan_df", "f_TrashLevel");
	if (count <= 1) then
		return 1;
	else
		BFLOG(SYSTRACE, "Trashcans still full.");
		return 0;
	end
end


function incCounter(comp)
	if (comp.counter == nil) then
		comp.counter = 1;
	else
		comp.counter = comp.counter + 1;
	end
end

function decCounter(comp)
	if (comp.counter == nil) then
		comp.counter = -1;
	else
		comp.counter = comp.counter - 1;
	end
end

function getCounter(comp)
	if (comp.counter == nil) then
		comp.counter = 0;
	end
	return comp.counter;
end

function logCounter(comp)
	if (comp.counter == nil) then
		BFLOG(SYSTRACE, "Counter is not set.");
	else
		BFLOG(SYSTRACE, "Counter is %d"..comp.counter);
	end
end

----------------------------------------------------------------------------------

function findType(entityType)
	local gameMgr = queryObject("BFGManager");
	if (gameMgr ~= nil) then
		local entityList = gameMgr:BFG_GET_ENTITIES(entityType);
		if (entityList ~= nil and type(entityList) == "table") then
			return entityList;
		end
	end
	BFLOG(SYSERROR, "Failed to query BFGManager.");
	return nil;
end

function randomType(entityType)
	local entityList = findType(entityType);
	if (entityList ~= nil) then
		local numEntities = table.getn(entityList);
		if (numEntities > 0) then
			local idx = math.random(numEntities);
			BFLOG(SYSTRACE, "Picked entity "..idx.." out of "..numEntities..".");
			return resolveTable(entityList[idx].value);
		end
	end
	return nil;
end

function pickType(entityType, component)
	local entityList = findType(entityType);
	while (entityList ~= nil) do
		local numEntities = table.getn(entityList);
		if (numEntities > 0) then
			local idx = math.random(numEntities);
			local entity = resolveTable(entityList[idx].value);
			if (entity.picked == nil) then
				component.picked = entity;
				return true;
			else
				table.remove(entityList, idx);
			end
		else
			entityList = nil;
		end
	end
	return false;
end

function countType(entityType)
	local count = 0;
	local entityList = findType(entityType);
	if (entityList ~= nil) then
		count = table.getn(entityList);
	end
	--BFLOG(SYSTRACE, "Found "..count.." entities of type "..entityType..".");
	return count;
end

----------------------------------------------------------------------------------

function needMet(entity,need)
	if (entity == nil) then
		BFLOG(SYSERROR, "needMet - Entity is nil.");
		return nil;
	elseif (need == nil) then
		BFLOG(SYSERROR, "needMet - Need is nil.");
		return nil;
	else
		local value = entity:sendMessage("BFAI_GET_TRIGGERED",need);
		if (value == nil) then
			-- Bad need perhaps.
			BFLOG(SYSERROR, "Couldn't get "..need.." from entity.");
			return nil;
		elseif (value == true) then
			-- The need is not met.
			return false;
		else
			-- The need is valid and not triggered.
			return true;
		end
	end
end

-- Basic needs: "hunger", "thirst", "rest", "exercise"
function basicNeedsMet(entity)
	if (entity == nil) then
		BFLOG(SYSERROR, "basicNeedsMet - entity is nil.");
		return false;
	elseif (not needMet(entity, "hunger")) then
		return false;
	elseif (not needMet(entity, "thirst")) then
		return false;
	elseif (not needMet(entity, "rest")) then
		return false;
	elseif (not needMet(entity, "exercise")) then
		return false;
	else
		return true;
	end
end

-- Advanced needs: "shelter", "privacy", "reproduction", "hygiene", "social", "stimulation"
function advancedNeedsMet(entity)
	if (entity == nil) then
		BFLOG(SYSERROR, "advancedNeedsMet - entity is nil.");
		return false;
	elseif (not needMet(entity, "shelter")) then
		return false;
	elseif (not needMet(entity, "privacy")) then
		return false;
	elseif (not needMet(entity, "reproduction")) then
		return false;
	elseif (not needMet(entity, "hygiene")) then
		return false;
	elseif (not needMet(entity, "social")) then
		return false;
	elseif (not needMet(entity, "stimulation")) then
		return false;
	else
		return true;
	end
end

function allNeedsMet(entity)
	if (entity == nil) then
		BFLOG(SYSERROR, "allNeedsMet - entity is nil.");
		return false;
	elseif (not basicmet(entity)) then
		return false;
	elseif (not advancedmet(entity)) then
		return false;
	else
		return true;
	end
end

----------------------------------------------------------------------------------

function showUI(name, showFlag)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD(name);
		if (name) then
			if (showFlag) then
				ui:UI_SHOW();
			else
				ui:UI_HIDE();
			end
		end
	end
end

----------------------------------------------------------------------------------

function printThing(thing)
	if (thing == nil) then
		return "nil";
	elseif (type(thing) == "boolean") then
		if (thing) then
			return "bool(true)";
		else
			return "bool(false)";
		end
	elseif (type(thing) == "number") then
		return "number("..thing..")";
	elseif (type(thing) == "string") then
		return "string("..thing..")";
	elseif (type(thing) == "function") then
		return "function()";
	elseif (type(thing) == "userdata") then
		return "userdata()";
	elseif (type(thing) == "thread") then
		return "thread()";
	elseif (type(thing) == "table") then
		local str = "table(";
		local idx, val = next(thing);
		while (idx ~= nil) do
			local k = printThing(idx);
			local v = printThing(val);
			str = str.."["..k.."="..v.."]";
			idx, val = next(thing, idx);
		end
		str = str..")";
		return str;
	else
		return nil;
	end
end

function log(comp)
	BFLOG(SYSTRACE, printThing(comp));
end

----------------------------------------------------------------------------------

function uitest(arg)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		BFLOG(SYSTRACE, "Found UIRoot");

		local splash = mgr:UI_GET_CHILD("splashbutton0");
		if (splash) then
			BFLOG(SYSTRACE, "Found splash...");
			splash:UI_ACTIVATE();
		else
			BFLOG(SYSTRACE, "Didn't find splash!");
		end

		local options = mgr:UI_GET_CHILD("Game Options Button");
		if (options) then
			BFLOG(SYSTRACE, "Found options...");
			options:UI_ACTIVATE();
		else
			BFLOG(SYSTRACE, "Didn't find options!");
		end

		local shadows = mgr:UI_GET_CHILD("shadows");
		if (shadows) then
			BFLOG(SYSTRACE, "Found shadow...");
			shadows:UI_ACTIVATE_OFF();
		else
			BFLOG(SYSTRACE, "Didn't find shadows!");
		end

		local apply = mgr:UI_GET_CHILD("Apply");
		if (apply) then
			BFLOG(SYSTRACE, "Found appy...");
			apply:UI_ACTIVATE();
		else
			BFLOG(SYSTRACE, "Didn't find apply!");
		end

		local back = mgr:UI_GET_CHILD("Back");
		if (back) then
			BFLOG(SYSTRACE, "Found back...");
			back:UI_ACTIVATE();
		else
			BFLOG(SYSTRACE, "Didn't find back!");
		end
	else
		BFLOG("UIRoot was not found!");
	end
end

----------------------------------------------------------------------------------

function hunger(arg)
	local gameMgr = queryObject("BFGManager");
	if (gameMgr ~= nil) then
		local entityList = gameMgr:BFG_GET_ENTITIES("animal");
		if (entityList ~= nil and type(entityList) == "table") then
			local numEntities = table.getn(entityList);
			for i = 1,numEntities do
				local animal = resolveTable(entityList[i].value);
				if (animal ~= nil) then
					local hunger = animal:BFG_GET_ATTR_FLOAT("hunger");
					BFLOG(SYSTRACE, "Hunger is ["..hunger.. "]");
				end
			end
		end
	end
	return 0;
end

----------------------------------------------------------------------------------

function evalTen(comp)
	if (comp.counter == nil) then
		return 0;
	elseif (comp.counter >= 10) then
		return 1;
	elseif (dist <= -10) then
		return -1;
	else
		return 0;
	end
end

----------------------------------------------------------------------------------

function test(comp)
	BFLOG(SYSTRACE, printThing(comp));
	return 0;
end

function evaluate0(comp)
	local count = 0;
	local tigers = findType("TigerBengal");
	if (tigers == nil) then
		return 0;
	end
	
	local numEntities = table.getn(tigers);
	for i = 1,numEntities do
		local tiger = resolveTable(tigers[i].value);
		if (basicNeedsMet(tiger)) then
			count = count + 1;
		end
	end

	if (count >= 3) then
		return 1;
	else
		BFLOG(SYSTRACE, "Count is "..count.." out of "..numEntities.." tigers.");
		return 0;
	end
end

function complete0(comp)
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotoprimarygoals = uimgr:UI_GET_CHILD("primary goals tab");
		if (gotoprimarygoals) then
			gotoprimarygoals:UI_ACTIVATE_ON();
		end
	end
	BFLOG(SYSTRACE, "Completed0");
	showUI("goals layout", true);
end

function complete0unlock(comp)
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotoprimarygoals = uimgr:UI_GET_CHILD("primary goals tab");
		if (gotoprimarygoals) then
			gotoprimarygoals:UI_ACTIVATE_ON();
		end
	end
	
	BFLOG(SYSTRACE, "Completed0unlock");
	--showUI("goals layout", true);
	
	-- Unlock scenario #2
	setuservar("campaign1scenario1", "completed");
	
	local alreadydone = getuservar("campaign1scenario2");
	if (alreadydone ~= "completed") then
		setuservar("campaign1scenario2", "unlocked");
	end
	
	-- Give them the completed scenario window
	showscenariowin("C1scenariogoals:C1youwin", "campaign1scenario2");
end




function eval1a(comp)
	local giraffes = countType("Giraffe");
	BFLOG(SYSTRACE, "Giraffes in zoo is "..giraffes);
	if (giraffes >= 2) then
		return 1;
	else
		return 0;
	end
end



function countNeed(entityType, need)
	local count = 0;
	local entities = findType(entityType);
	local numEntities = table.getn(entities);

	for i = 1,numEntities do
		local e = resolveTable(entities[i].value);
		if (needMet(e, need)) then
			count = count + 1;
		end
	end

	return count;
end

function eval1b(comp)
	local count = countNeed("Giraffe", "hunger");
	if (count >= 2) then
		return 1;
	else
		BFLOG(SYSTRACE, "Giraffes still hungry.");
		return 0;
	end
end

function eval1c(comp)
	local count = countNeed("Giraffe", "thirst");
	if (count >= 2) then
		return 1;
	else
		BFLOG(SYSTRACE, "Giraffes still thirsty.");
		return 0;
	end
end

function complete1(comp)
	BFLOG(SYSTRACE, "Complete1");
	showUI("goals layout", true);
end

function executeWin(comp)
	BFLOG(SYSTRACE, "Winner.");
	showUI("goals layout", true);
end

function executeLose(comp)
	BFLOG(SYSTRACE, "Loser.");
	showUI("goals layout", true);
end

----------------------------------------------------------------------------------


function showRule()
	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		mgr:BFS_SHOWRULE("name of rule");
	end
end

function hideRule()
	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		mgr:BFS_HIDERULE("name of rule");
	end
end

-- To hide/show/enable/disable UI elements...
-- Just an example, not for real function.
-- UI element names are found in ui/layout/*.xml

function muckWithUI()
	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		mgr:UI_SHOW("name of ui element");
		mgr:UI_HIDE_HIDERULE("name of ui element");
		mgr:UI_ENABLE("name of ui element");
		mgr:UI_DISABLE("name of ui element");
	end
end

-- To get zoo fame, and the "is zoo open" flag..

function fameAndOpen()
	local mgr = queryObject("ZTStatus");
	if (mgr) then
		local isopen = mgr:ZT_GET_ZOO_OPEN();
		local zoofame = mgr:ZT_GET_ZOO_FAME();
	end
end