-- lua file for testing scenarios
--------------


----------------------------------------------------------------------------------

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
	BFLOG(SYSTRACE, "Found "..count.." entities of type "..entityType..".");
	return count;
end

----------------------------------------------------------------------------------


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

	return numEntities-count;
end

---- check if a need is critical
function CriticalNeed(entity,need)
	if (entity == nil) then
		BFLOG(SYSERROR, "CriticalNeed - Entity is nil.");
		return nil;
	elseif (need == nil) then
		BFLOG(SYSERROR, "CriticalNeed - Need is nil.");
		return nil;
	else
		local value = entity:sendMessage("BFAI_GET_CRITICAL",need);
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

function countCriticalNeed(entityType, need)
	local count = 0;
	local entities = findType(entityType);
	local numEntities = table.getn(entities);

	for i = 1,numEntities do
		local e = resolveTable(entities[i].value);
		if (CriticalNeed(e, need)) then
			count = count + 1;
		end
	end

	return numEntities-count;
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




function eval1a(comp)
	local giraffes = countType("Giraffe");
	BFLOG(SYSTRACE, "Giraffes in zoo is "..giraffes);
	if (giraffes >= 2) then
		return 1;
	else
		return 0;
	end
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



