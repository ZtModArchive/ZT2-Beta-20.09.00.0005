-- needs.lua

include "scenario/scripts/misc.lua";
include "scenario/scripts/entity.lua";


-- HEADER

-- Returns true if the specified need is met on the specified entity
-- false otherwise
-- function needMet(entity,need)

-- Returns true if the basic needs are all met on the specified entity, false otherwise
-- Basic needs: "hunger", "thirst", "rest", "exercise"
-- function basicNeedsMet(entity)

-- Returns true if the advanced needs are all met on the specified entity, false otherwise
-- Advanced needs: "shelter", "privacy", "reproduction", "hygiene", "social", "stimulation"
-- function advancedNeedsMet(entity)

-- Returns true if all the needs are met on the specified entity, false otherwise
-- function allNeedsMet(entity)

-- Goes through all animals of the type specified and returns true if their basic needs
-- are all met, false otherwise.
-- Will returns false if none of the specified type exists
-- function allTypeBasicNeedsMet(type)

-- Goes through all animals of the type specified and returns true if their advanced needs
-- are all met, false otherwise.
-- Will returns false if none of the specified type exists
-- function allTypeAdvancedNeedsMet(type)

-- Goes through all animals of the type specified and returns true if all of their needs
-- are all met, false otherwise.
-- Will returns false if none of the specified type exists
-- function allTypeAllNeedsMet(type)

-- Goes through all animals of the type specified and returns true if the specified need
-- is met, false otherwise.
-- Will returns false if none of the specified type exists
-- function allTypeNeedMet(type, need)

-- Pass in a type, and will return true if the basic needs of all children in that group
-- are met
-- Will returns false if there are no children of the specified type
-- function allTypeChildBasicNeedsMet(type)

-- Pass in a type, and will return true if the basic needs of all adults in that group
-- are met
-- Will returns false if there are no adults of the specified type
-- function allTypeAdultBasicNeedsMet(type)

-- Returns true if the passed in entity's specified need level is less than or equal to
-- the passed threshold
-- function needMeetsThreshold(entity, need, threshold)

-- Checks each of the specified entities in the zoo and returns true if they all meet
-- their need threshold, false if one or more fails
-- function allNeedMeetsThreshold(entityname, need, threshold)

-- Returns true if the basic needs of the specified entity are not critical
-- function basicNeedsNotCritical(entity)

-- Returns true if the basic needs all meet a specified threshold
-- function basicNeedsMeetThreshold(entity, threshold)

-- Returns true if the advanced needs all meet a specified threshold
-- function advancedNeedsMeetThreshold(entity, threshold)

-- Checks to see if all of the specified entity's needs meet the threshold
-- function allNeedsMeetThreshold(entity, threshold)

-- Takes in:
-- A table of animal types
-- A need
-- A threshold
-- Returns true if there exist at least one animal of the specified type that meets the need threshold
-- function animalTableMeetsThreshold(animaltable, need, threshold)

-- FUNCTIONS



-- Returns true if the specified need is met on the specified entity
-- false otherwise
function needMet(entity, need)
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

-- Returns true if the basic needs are all met on the specified entity, false otherwise
-- Basic needs: "hunger", "thirst", "rest", "exercise", "environment"
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
	elseif (not needMet(entity, "environment")) then
		return false;
	else
		return true;
	end
end

-- Returns true if the advanced needs are all met on the specified entity, false otherwise
-- Advanced needs: "privacy", "reproduction" (not included), "hygiene", "social", "stimulation"
function advancedNeedsMet(entity)
	if (entity == nil) then
		BFLOG(SYSERROR, "advancedNeedsMet - entity is nil.");
		return false;
	elseif (not needMet(entity, "hygiene")) then
		return false;
	elseif (not needMet(entity, "social")) then
		return false;
	elseif (not needMet(entity, "stimulation")) then
		return false;
	elseif (not needMet(entity, "privacy")) then
		return false;		
	else
		return true;
	end
end


-- Returns true if all the needs are met on the specified entity, false otherwise
function allNeedsMet(entity)
	if (entity == nil) then
		BFLOG(SYSERROR, "allNeedsMet - entity is nil.");
		return false;
	elseif (not basicNeedsMet(entity)) then
		return false;
	elseif (not advancedNeedsMet(entity)) then
		return false;
	else
		return true;
	end
end


-- Goes through all animals of the type specified and returns true if their basic needs
-- are all met, false otherwise.
function allTypeBasicNeedsMet(type)
	animals = findType(type);
	local numEntities = 0;

	if (animals ~= nil) then			
		numEntities = table.getn(animals);
		for i = 1,numEntities do
			BFLOG(SYSTRACE, "Checking entity");
			local animal = resolveTable(animals[i].value);
			if (basicNeedsMet(animal) == false) then
				return false;
			end
		end
	end

	return true;
end


-- Goes through all animals of the type specified and returns true if their advanced needs
-- are all met, false otherwise.
function allTypeAdvancedNeedsMet(type)
	animals = findType(type);
	local numEntities = 0;

	if (animals ~= nil) then			
		numEntities = table.getn(animals);
		for i = 1,numEntities do
			local animal = resolveTable(animals[i].value);
			if (advancedNeedsMet(animal) == false) then
				return false;
			end
		end
	end

	return true;
end


-- Goes through all animals of the type specified and returns true if all of their needs
-- are all met, false otherwise.
function allTypeAllNeedsMet(type)
	animals = findType(type);
	local numEntities = 0;

	if (animals ~= nil) then			
		numEntities = table.getn(animals);
		for i = 1,numEntities do
			local animal = resolveTable(animals[i].value);
			if (allNeedsMet(animal) == false) then
				return false;
			end
		end
	end

	return true;
end



-- Goes through all animals of the type specified and returns true if the specified need
-- is met, false otherwise.
function allTypeNeedMet(type, need)
	animals = findType(type);
	local numEntities = 0;

	if (animals ~= nil) then			
		numEntities = table.getn(animals);
		for i = 1,numEntities do
			local animal = resolveTable(animals[i].value);
			if (needMet(animal, need) == false) then
				return false;
			end
		end
	end

	return true;
end


-- Pass in a type, and will return true if the basic needs of all children in that group
-- are met
function allTypeChildBasicNeedsMet(type)
	local realcount = 0;

	-- Grab all of the objects of type type
	local objects = findType(type);

	if (objects == nil) then
		if (count == 0) then
			return true;
		else
			return false;
		end
	end

	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1,num do
		local single = resolveTable(objects[i].value);
		local isadult = single:BFG_GET_ATTR_BOOLEAN("b_Adult");
		if (isadult == nil) then
			BFLOG(SYSERROR, "Error trying to find adults.");
			return nil;
		else
			-- If it's a child, then check basic needs and return
			-- false if they are not met.
			if (isadult == false) then
				if basicNeedsMet(single) == false then
					return false;
				end				
			end
		end
	end

	return true;
end


-- Pass in a type, and will return true if the basic needs of all adults in that group
-- are met
function allTypeAdultBasicNeedsMet(type)
	local realcount = 0;

	-- Grab all of the objects of type type
	local objects = findType(type);

	if (objects == nil) then
		if (count == 0) then
			return true;
		else
			return false;
		end
	end

	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1,num do
		local single = resolveTable(objects[i].value);
		local isadult = single:BFG_GET_ATTR_BOOLEAN("b_Adult");
		if (isadult == nil) then
			BFLOG(SYSERROR, "Error trying to find adults.");
			return nil;
		else
			-- If it's a child, then check basic needs and return
			-- false if they are not met.
			if (isadult == true) then
				if basicNeedsMet(single) == false then
					return false;
				end				
			end
		end
	end

	return true;
end


-- Returns true if the passed in entity's specified need level is less than or equal to
-- the passed threshold
function needMeetsThreshold(entity, need, threshold)
	if (entity == nil) then
		BFLOG(SYSERROR, "needMeetsThreshold - entity is nil.");
		return false;
	end;
	
	local theneed = entity:BFG_GET_ATTR_FLOAT(need);
	
	BFLOG(SYSTRACE, need.." is ["..theneed.. "]");
	if theneed <= threshold then
		return true;
	end
	
	return false;
end

function needSatisfied(entity, need)
	if (entity == nil) then
		BFLOG(SYSERROR, "needSatisfied - entity is nil.");
		return false;
	end;
	
	local theneed = entity:BFG_GET_ATTR_FLOAT(need);
	local limit = entity:BFAI_GET_PRESSING_THRESHOLD(need);
	
	if theneed <= limit then
		return true;
	end
	
	return false;
end


-- Checks each of the specified entities in the zoo and returns true if they all meet
-- Returns false if none of the entities are found
-- their need threshold, false if one or more fails
function allNeedMeetsThreshold(entityname, need, threshold)
	-- Grab all of the objects of type type
	local objects = findType(entityname);

	if (objects == nil) then
			return false;
	end
	
	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1, num do
		local single = resolveTable(objects[i].value);
		
		if (needMeetsThreshold(single, need, threshold) == false) then
			return false;
		end
	end

	return true;	
end

function allNeedSatisfied(entityname, need)
	-- Grab all of the objects of type type
	local objects = findType(entityname);

	if (objects == nil) then
			return false;
	end
	
	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1, num do
		local single = resolveTable(objects[i].value);
		
		if (needSatisfied(single, need) == false) then
			return false;
		end
	end

	return true;	
end


-- Returns true if the basic needs of the specified entity are not critical
function basicNeedsNotCritical(entity)
	if (entity == nil) then
		BFLOG(SYSERROR, "basicNeedsNotCritical - entity is nil.");
		return false;
	elseif (not needMeetsThreshold(entity, "hunger", 90)) then
		return false;
	elseif (not needMeetsThreshold(entity, "thirst", 90)) then
		return false;
	elseif (not needMeetsThreshold(entity, "rest", 90)) then
		return false;
	elseif (not needMeetsThreshold(entity, "exercise", 90)) then
		return false;
	elseif (not needMeetsThreshold(entity, "environment", 70)) then
		return false;
	else
		BFLOG(SYSTRACE, "basicNeedsNotCritical - passed!");
		return true;
	end
end


-- Returns true if the basic needs all meet a specified threshold
function basicNeedsMeetThreshold(entity, threshold)
	if (entity == nil) then
		BFLOG(SYSERROR, "basicNeedsMeetThreshold - entity is nil.");
		return false;
	elseif (not needMeetsThreshold(entity, "hunger", threshold)) then
		return false
	elseif (not needMeetsThreshold(entity, "thirst", threshold)) then
		return false;
	elseif (not needMeetsThreshold(entity, "rest", threshold)) then
		return false;
	elseif (not needMeetsThreshold(entity, "exercise", threshold)) then
		return false;
	elseif (not needMeetsThreshold(entity, "environment", threshold)) then
		return false;

	else
		BFLOG(SYSTRACE, "basicNeedsMeetThreshold - passed!");
		return true;
	end
end


-- Returns true if the basic needs are satisfied
function basicNeedsSatisfied(entity)
	if (entity == nil) then
		BFLOG(SYSERROR, "basicNeedsSatisfied - entity is nil.");
		return false;
	elseif (not needSatisfied(entity, "hunger")) then
		return false
	elseif (not needSatisfied(entity, "thirst")) then
		return false;
	elseif (not needSatisfied(entity, "rest")) then
		return false;
	elseif (not needSatisfied(entity, "exercise")) then
		return false;
	elseif (not needSatisfied(entity, "environment")) then
		return false;
	else
		BFLOG(SYSTRACE, "needSatisfied - passed!");
		return true;
	end
end


-- Returns true if the advanced needs all meet a specified threshold
function advancedNeedsMeetThreshold(entity, threshold)
	if (entity == nil) then
		BFLOG(SYSERROR, "advancedNeedsMeetThreshold - entity is nil.");
		return false;
	elseif (not needMeetsThreshold(entity, "hygiene", threshold)) then
		return false;
	elseif (not needMeetsThreshold(entity, "social", threshold)) then
		return false;
	elseif (not needMeetsThreshold(entity, "stimulation", threshold)) then
		return false;
	elseif (not needMeetsThreshold(entity, "privacy", threshold)) then
		return false;		
	else
		BFLOG(SYSTRACE, "advancedNeedsMeetThreshold - passed!");
		return true;
	end
end

-- Returns true if the advanced needs are satisfied
function advancedNeedsSatisfied(entity)
	if (entity == nil) then
		BFLOG(SYSERROR, "advancedNeedsSatisfied - entity is nil.");
		return false;
	elseif (not needSatisfied(entity, "hygiene")) then
		return false;
	elseif (not needSatisfied(entity, "social")) then
		return false;
	elseif (not needSatisfied(entity, "stimulation")) then
		return false;
	elseif (not needSatisfied(entity, "privacy")) then
		return false;		
	else
		BFLOG(SYSTRACE, "advancedNeedsSatisfied - passed!");
		return true;
	end
end

-- Checks to see if all of the specified entity's needs meet the threshold
function allNeedsMeetThreshold(entity, threshold)
	if (entity == nil) then
		return false;
	end
	
	if (not advancedNeedsMeetThreshold(entity, threshold)) then
		return false;
	elseif (not basicNeedsMeetThreshold(entity, threshold)) then
		return false;
	else
		return true;
	end		
end

-- Checks to see if all of the specified entity's needs are satisfied
function allNeedsSatisfied(entity)
	if (entity == nil) then
		return false;
	end
	
	if (not advancedNeedsSatisfied(entity)) then
		return false;
	elseif (not basicNeedsSatisfied(entity)) then
		return false;
	else
		return true;
	end		
end


function typeBasicNeedsMeetThreshold(entityname, threshold)
	-- Grab all of the objects of type type
	local objects = findType(entityname);

	if (objects == nil) then
			return false;
	end
	
	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1, num do
		local single = resolveTable(objects[i].value);
		
		if (basicNeedsMeetThreshold(single, threshold) == false) then
			return false;
		end
	end

	return true;
end

function typeBasicNeedsSatisfied(entityname)
	-- Grab all of the objects of type type
	local objects = findType(entityname);

	if (objects == nil) then
			return false;
	end
	
	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1, num do
		local single = resolveTable(objects[i].value);
		
		if (basicNeedsSatisfied(single) == false) then
			return false;
		end
	end

	return true;
end

function typeAdvancedNeedsMeetThreshold(entityname)
	-- Grab all of the objects of type type
	local objects = findType(entityname);

	if (objects == nil) then
			return false;
	end
	
	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1, num do
		local single = resolveTable(objects[i].value);
		
		if (advancedNeedsMeetThreshold(single, threshold) == false) then
			return false;
		end
	end

	return true;
end

function typeAdvancedNeedsSatisfied(entityname)
	-- Grab all of the objects of type type
	local objects = findType(entityname);

	if (objects == nil) then
			return false;
	end
	
	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1, num do
		local single = resolveTable(objects[i].value);
		
		if (advancedNeedsSatisfied(single) == false) then
			return false;
		end
	end

	return true;
end

function typeAllNeedsMeetThreshold(entityname, threshold)
	-- Grab all of the objects of type type
	local objects = findType(entityname);

	if (objects == nil) then
			return false;
	end
	
	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1, num do
		local single = resolveTable(objects[i].value);
		
		if (allNeedsMeetThreshold(single, threshold) == false) then
			return false;
		end
	end

	return true;
end

function typeAllNeedsSatisfied(entityname)
	-- Grab all of the objects of type type
	local objects = findType(entityname);

	if (objects == nil) then
			return false;
	end
	
	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1, num do
		local single = resolveTable(objects[i].value);
		
		if (allNeedsSatisfied(single) == false) then
			return false;
		end
	end

	return true;
end


-- Takes in:
-- A table of animal types
-- A need
-- A threshold
-- Returns true if there exist at least one animal of the specified types that meets the need threshold
function animalTableMeetsThreshold(animaltable, need, threshold)
	if (animaltable == nil) then
		return nil;
	end
	
	local num = table.getn(animaltable);
	for i = 1, num do
		-- Now go through all of the animals of the type in the table
		local objects = findType(animaltable[i]);
		
		local numobj = table.getn(objects);
		
		for j = 1, numobj do
			local single = resolveTable(objects[j].value);
			if (needMeetsThreshold(single, need, threshold) == true) then
				return true;
			end
		end
	end	
	
	return false;
end


function animalTableSatisfied(animaltable, need)
	if (animaltable == nil) then
		return nil;
	end
	
	local num = table.getn(animaltable);
	for i = 1, num do
		-- Now go through all of the animals of the type in the table
		local objects = findType(animaltable[i]);
		
		local numobj = table.getn(objects);
		
		for j = 1, numobj do
			local single = resolveTable(objects[j].value);
			if (needSatisfied(single, need) == true) then
				return true;
			end
		end
	end	
	
	return false;
end