-- entity.lua


-- HEADERS

-- Returns a table of all the entities of the given type
-- function findType(entityType)

-- Pass in a type and will return the number of children of that type
-- function howManyChildren(type)

-- Pass in a type and will return true if there are any sick animals of that type, false otherwise
-- function areAnyTypeSick(type)

-- Returns true if there are any sick animals, false otherwise
-- function areAnySick()

-- Pass in an entity, will detach it from the grid and make it invisible
-- function putInStasis(entity)

-- Pass in an entity, will attach it to the grid and make it visible
-- Intended to be called on entities which are already in stasis
-- function removeFromStasis(entity)

-- placeObject takes 4 parameters and places that object in the game world.
-- <entity type> <x coord> <y coord> <rotation>
-- entity-type must be a concrete type such as "TigerBengal_Adult_M"
-- function placeObject(type, px, py, pr)

-- Pass in an entity, will add the entity to the list of abductees, and remove from the map
-- function abductEntity(entity)

-- Frees all of the abducted animals.   Returns them to the grid and sets them visible.
-- function freeAbductees()

-- Frees a single (numbered) entity from the abductee list
-- function freeSingleAbductee(who)

-- Pass in a type and will return true if there exists a male of that type, false otherwise
-- function existMale(type)

-- Pass in a type and will return true if there exists a female of that type, false otherwise
-- function existFemale(type)

-- Pass in a type and will return true if there exists at least count adults of the type
-- So existNumAdults("TigerBengal", 2) will return true if there are at least 2 adult tigers, false otherwise
-- function existNumAdults(type, count)

-- Pass in a type and will return true if there exists at least count children of the type
-- So existNumChildren("TigerBengal", 2) will return true if there are at least 2 baby tigers, false otherwise
-- function existNumChildren(type, count)

-- Pass in a type and a number, and will return true if there are at least count of the specified type
-- in the zoo, false otherwise.
-- thisManyExist("TigerBengal", 4) will return true if there are 4 or more tigers, false otherwise
-- function thisManyExist(type, count)

-- Counts the number of the passed in entity
-- function countType(entityType)

-- Pass in an entity, puts it in a crate
-- function crateEntity(entity)

-- Gets an entity's f_needPointsBadCum
-- function getNeedPointsBadCum(entity)

-- Gets an entity's f_needPointsGoodCum
-- function getNeedPointsGoodCum(entity)

-- Deletes the passed entity
-- function deleteEntity(entity)

-- Returns a table of the animals they have in their zoo
-- functions animalsInZoo()

-- Returns a table of the animals they DON'T have in their zoo
-- function animalsNotInZoo()

-- Pass in a table of strings indexed by number.  Returns how many of them exist in the zoo
-- function howManyInTableExist(thelist)

-- Returns true if the passed in entity has a grandmother, false otherwise
-- function entityHasGrandmother(entity)

-- Returns the selected entity
-- function getSelectedEntity()

-- Returns true if the entity is a kind of type
-- function isEntityKindOf(entity, binderType)

-- Takes in a table of entity name and returns a table of the entities which exist in the xoo
-- function getTableFromTableEntityExist(entitytable)

-- Returns (as a string) 
-- function getRandomAnimalType()

-- Returns the total number of good cum points of all animals
-- function getTotalGoodCumPoints()

-- Returns the total number of bad cum points of all animals
-- function getTotalBadCumPoints()

-- Will return true if there exist a male and female of the same species in your zoo
-- function existMaleFemaleSameSpecies()

-- FUNCTIONS


-- Returns a table of all the entities of the given type
function findType(entityType)
	local gameMgr = queryObject("BFGManager");
	if (gameMgr ~= nil) then
		local entityList = gameMgr:BFG_GET_ENTITIES(entityType);
		if (entityList ~= nil and type(entityList) == "table") then
			-- Get the selected entity, and add it to the list if it's not already there
			local selectedent = getSelectedEntity();
			if (selectedent) then
				BFLOG(SYSTRACE, "FOUND selected entity!");
				
				local insidecontainer = selectedent:BFG_FIND_CONTAINED_ENTITY(entityType);
				
				if (insidecontainer == nil) then
					BFLOG(SYSTRACE, "insidecontainer == nil");
				end
				
				if (insidecontainer ~= nil) then
					BFLOG(SYSTRACE, "selected entity is inside of a container.");
					local num = table.getn(entityList);
					
					local found = false;
					for i = 1, num do	
						local single = resolveTable(entityList[i].value);
						if (areCompsEqual(single, insidecontainer) == true) then
							--BFLOG(SYSTRACE, "FOUND a match already in the list");
							found = true;
						end
					end
			
					if (found == false) then
						--BFLOG(SYSTRACE, "did NOT find a match already in the list");
						entityList[num+1] = insidecontainer;
					end
					
					
				elseif (isKindOf(selectedent:BFG_GET_BINDER_TYPE(), entityType) == true) then
					local num = table.getn(entityList);
					local found = false;
					for i = 1, num do
						local single = resolveTable(entityList[i].value);
	
						if (areCompsEqual(single, selectedent) == true) then
							--BFLOG(SYSTRACE, "FOUND a match already in the list");
							found = true;
						end
					end
			
					if (found == false) then
						--BFLOG(SYSTRACE, "did NOT find a match already in the list");
						entityList[num+1] = selectedent;
					end
				end
			end
			
			return entityList;
		end
	end
	BFLOG(SYSERROR, "Failed to query BFGManager.");
	return nil;
end


-- Pass in a type and will return the number of children of that type
function howManyChildren(type)
	local realcount = 0;

	-- Grab all of the objects of type type
	local objects = findType(type);

	if (objects == nil) then
		return 0;
	end

	local num = 0;

-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1,num do
		local single = resolveTable(objects[i].value);
		local isadult = single:BFG_GET_ATTR_BOOLEAN("b_Adult");
		if (isadult == nil) then
			BFLOG(SYSERROR, "Error trying to find adults.");
			return 0;
		else
			-- If it's a child, then increment the count
			if (isadult == false) then
				realcount = realcount + 1;
			end
		end
	end

	return realcount;
end


-- Pass in a type and will return true if there are any sick animals of that type, false otherwise
function areAnyTypeSick(type)

	-- Grab all of the objects of type type
	local objects = findType(type);

	if (objects == nil) then
		return false;
	end

	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1,num do
		local single = resolveTable(objects[i].value);
		local issick = single:BFG_GET_ATTR_BOOLEAN("b_Sick");
		if (issick == nil) then
			BFLOG(SYSERROR, "Error checking for sickness.");
			return nil;
		else
			-- If it's sick then return true
			if (issick == true) then
				BFLOG(SYSTRACE, "Sick!");
				return true;
			end
		end
	end

	-- Otherwise return false
	return false;
end


-- Returns true if there are any sick animals, false otherwise
function areAnySick()
	-- Grab all of the animals
	local objects = findType("animal");

	if (objects == nil) then
		return false;
	end

	local num = 0;

	-- Loop through all of the objects in the table
	num = table.getn(objects);
	for i = 1,num do
		local single = resolveTable(objects[i].value);
		local issick = single:BFG_GET_ATTR_BOOLEAN("b_Sick");
		if (issick == nil) then
			BFLOG(SYSERROR, "Error checking for sickness.");
			return nil;
		else
			-- If it's sick then return true
			if (issick == true) then
				BFLOG(SYSTRACE, "Sick!");
				return true;
			end
		end
	end

	-- Otherwise return false
	return false;
end

-- Pass in an entity, will detach it from the grid and make it invisible
function putInStasis(entity)
	local gameMgr = queryObject("BFGManager");
	if entity ~= nil then
		if gameMgr ~= nil then
			gameMgr:BFG_DETACH_GRID(entity);
			entity:BFG_SET_INVISIBLE();
			return true;
		else
			BFLOG(SYSERROR, "Error loading BFGManager.");
		end
	end
	return false;
end


-- Pass in an entity, will attach it to the grid and make it visible
-- Intended to be called on entities which are already in stasis
function removeFromStasis(entity)
	local gameMgr = queryObject("BFGManager");
	if entity ~= nil then
		if gameMgr ~= nil then
			gameMgr:BFG_ATTACH_GRID(entity);
			entity:BFG_SET_VISIBLE(entity);
			return true;
		else
			BFLOG(SYSERROR, "Error loading BFGManager.");
		end
	end
	return false;
end


-- placeObject takes 4 parameters and places that object in the game world.
-- <entity type> <x coord> <y coord> <rotation>
-- entity-type must be a concrete type such as "TigerBengal_Adult_M"
function placeObject(type, px, py, pr)
	local mode = queryObject("ZTMode");
	if mode ~= nil then
		BFLOG(SYSTRACE, "Placing an entity");
		mode:sendMessage("ZT_SETMODE", "mode_placement");
		mode:sendMessage("ZT_SETPLACEMENTOBJECT", tostring(type));
		mode:sendMessage("ZT_OBJECT_ROTATE", tostring(pr));
		mode:sendMessage("ZT_PLACEOBJECTSPIRAL", { x=tonumber(px), y=tonumber(py), z=0 });
		mode:sendMessage("ZT_SETPLACEMENTOBJECT", tostring("-"));
	else
		BFLOG(SYSERROR, "***** Can't locate UIRoot! *****");
	end
end


-- Pass in an entity, will add the entity to the list of abductees, and remove from the map
function abductEntity(entity)
	-- First add the entity to the list of abductees
	if abductees == nil then
		abductees = { };
	end

	local num = table.getn(abductees);

	abductees[num+1] = entity;

	-- And now put it into stasis
	putInStasis(entity);
end

-- Frees all of the abducted animals.   Returns them to the grid and sets them visible.
function freeAbductees()
	if abductees == nil then
		BFLOG(SYSTRACE, "There are no abductees to free");
		return false;
	else
		BFLOG(SYSTRACE, "Freeing abductees.");

		-- And set these guys free
		local num = table.getn(abductees);
		for i = 1,num do
			local single = abductees[i];
			removeFromStasis(single);
		end

		-- Clear out the abductees list
		abductees = nil;
		return true;
	end
end

-- Frees a single (numbered) entity from the abductee list
function freeSingleAbductee(who)
	if abductees == nil then
		BFLOG(SYSTRACE, "freeSingleAbductee - There are no abductees to free");
		return false;
	else
		local testnum = table.getn(abductees);
		if who > 0 then
			if who <= testnum then
				local single = abductees[who];
				removeFromStasis(single);

				table.remove(abductees, who);

				local num = table.getn(abductees);

				if num == 0 then
					abductees = nil;
				end

				return true;
			end		
		end
		return false;
	end
end


-- Pass in a type and a number, and will return true if there are at least count of the specified type
-- in the zoo, false otherwise.
-- thisManyExist("TigerBengal", 4) will return true if there are 4 or more tigers, false otherwise
function thisManyExist(type, count)
	local realcount = 0;
	local objects = findType(type);
	if (objects == nil) then
		if (count == 0) then
			return true;
		else
			return false;
		end
	end
	
	local realcount = table.getn(objects);

	if (realcount >= count) then
		return true;
	else
		BFLOG(SYSTRACE, "thisMany is "..realcount.." out of "..count..".");
		return false;
	end
end


-- Pass in a type and will return true if there exists at least count children of the type
-- So existNumChildren("TigerBengal", 2) will return true if there are at least 2 baby tigers, false otherwise
function existNumChildren(type, count)
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
			BFLOG(SYSERROR, "Error trying to find children.");
			return nil;
		else
			-- If it's a child, then increment the count
			if (isadult == false) then
				BFLOG(SYSTRACE, "Found a baby");
				realcount = realcount + 1;
			end
		end
	end

	-- At the end, if the count is high enough, return true
	if realcount >= count then
		return true;
	end	

	-- Otherwise return false
	return false;
end


-- Pass in a type and will return true if there exists at least count adults of the type
-- So existNumAdults("TigerBengal", 2) will return true if there are at least 2 adult tigers, false otherwise
function existNumAdults(type, count)
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
			-- If it's a child, then increment the count
			if (isadult == true) then
				realcount = realcount + 1;
			end
		end
	end

	-- At the end, if the count is high enough, return true
	if realcount >= count then
		return true;
	end	

	-- Otherwise return false
	return false;
end




-- Pass in a type and will return true if there exists a female of that type, false otherwise
function existFemale(type)
	local objects = findType(type);
	if (objects == nil) then
		BFLOG(SYSTRACE, "existFemale - no objects found.");
		return false;
	end

	local num = 0;

	num = table.getn(objects);
	for i = 1,num do
		local single = resolveTable(objects[i].value);
		local ismale = single:BFG_GET_ATTR_BOOLEAN("b_Male");
		if (ismale == nil) then
			BFLOG(SYSERROR, "Error trying to find a lady.");
			return nil;
		else 
			if (ismale == false) then
				return true;
			end
		end
	end

	return false;
end


-- Pass in a type and will return true if there exists a male of that type, false otherwise
function existMale(type)
	local objects = findType(type);
	if (objects == nil) then
		BFLOG(SYSTRACE, "existMale - no objects found.");
		return false;
	end

	local num = table.getn(objects);
	for i = 1,num do
		local single = resolveTable(objects[i].value);
		local ismale = single:BFG_GET_ATTR_BOOLEAN("b_Male");
		if (ismale == nil) then
			BFLOG(SYSERROR, "Error trying to find a male.");
			return nil;
		else 
			if (ismale == true) then
				return true;
			end
		end
	end

	return false;
end

-- Returns true if entity is male
function isMale(entity)
	if (entity == nil) then
		return false;
	end
	
	local ismale = entity:BFG_GET_ATTR_BOOLEAN("b_Male");
	if (ismale == nil) then
		BFLOG(SYSERROR, "Error trying to find a male.");
		return nil;
	else 
		if (ismale == true) then
			return true;
		end
	end
	
	return false;
end

-- Returns true if entity is female
function isFemale(entity)
	if (entity == nil) then
		return false;
	end
	
	local ismale = entity:BFG_GET_ATTR_BOOLEAN("b_Male");
	if (ismale == nil) then
		BFLOG(SYSERROR, "Error trying to find a male.");
		return nil;
	else 
		if (ismale == true) then
			return true;
		end
	end
	
	return false;
end

-- Counts the number of the passed in entity
function countType(entityType)
	local count = 0;
	local gameMgr = queryObject("BFGManager");
	if (gameMgr ~= nil) then
		count = gameMgr:BFG_COUNT_ENTITIES(entityType);
		if (count == nil) then
			BFLOG(SYSTRACE, "nil returned from BFG_COUNT_ENTITIES");
			count = 0;
		end
	end

	if (entityType ~= nil) then
		--BFLOG(SYSTRACE, "Found "..count.." entities of type "..entityType..".");
	end
	return count;
end

-- Pass in an entity, puts it in a crate
function crateEntity(entity)
	entity:BFG_SEND_SIGNAL_SHARED("ZT_CRATE_ENTITY");
end


-- Gets an entity's f_needPointsBadCum
function getNeedPointsBadCum(entity)
	if (entity) then
		local val = entity:BFG_GET_ATTR_FLOAT("f_needPointsBadCum");
		
		return val;
	end
	
	return nil;
end

-- Gets an entity's f_needPointsGoodCum
function getNeedPointsGoodCum(entity)
	if (entity) then
		local val = entity:BFG_GET_ATTR_FLOAT("f_needPointsGoodCum");
		
		return val;
	end
	
	return nil;
end


-- Deletes the passed entity
function deleteEntity(entity)
	local gameMgr = queryObject("BFGManager");
	if (gameMgr ~= nil) then
		gameMgr:BFG_REMOVE_ENTITY(entity);
	end
end


-- Takes in a table of entity name and returns a table of the entities which exist in the xoo
function getTableFromTableEntityExist(entitytable)
	
	if (entitytable == nil) then
		BFLOG(SYSTRACE, "getTableFromTableEntityExist - nil table passed in");
		return nil;
	end
	
	-- Now loop through all of these animals and build a NEW table
	-- of the ones in the zoo
	local newtable = { };
	local num = table.getn(entitytable);
	local newindex = 1;
	
	for i = 1, num do
		-- If we find the animal from the master list, add it to the zooanimals array
		if (countType(entitytable[i]) >= 1) then
			newtable[newindex] = entitytable[i];
			newindex = newindex + 1;
		end
	end

	return newtable;	
end


-- Returns a table of the animals they have in their zoo
function animalsInZoo()
	-- Create a master list of all animals
	local masteranimallist = { };
	
	masteranimallist[1] = "GazelleThomsons";
	masteranimallist[2] = "ZebraCommon"; 
	masteranimallist[3] = "Kangaroo";
	masteranimallist[4] = "CamelDromedary";
	masteranimallist[5] = "Moose";
	masteranimallist[6] = "Gemsbok";
	masteranimallist[7] = "PeafowlCommon";
	masteranimallist[8] = "FlamingoGreater";
	masteranimallist[9] = "CrocodileNile";
	masteranimallist[10] = "Ostrich";
	masteranimallist[11] = "TigerBengal";
	masteranimallist[12] = "Jaguar";
	masteranimallist[13] = "LemurRingtailed";
	masteranimallist[14] = "Giraffe";
	masteranimallist[15] = "Cheetah";
	masteranimallist[16] = "Hippopotamus";
	masteranimallist[17] = "Ibex";
	masteranimallist[18] = "PenguinEmperor";
	masteranimallist[19] = "Lion";
	masteranimallist[20] = "RhinocerosBlack";
	masteranimallist[21] = "Chimpanzee";
	masteranimallist[22] = "GorillaMountain";
	masteranimallist[23] = "BearPolar";
	masteranimallist[24] = "ElephantAfrican";
	masteranimallist[25] = "BearGrizzly";
	masteranimallist[26] = "BeaverAmerican";
	masteranimallist[27] = "Okapi";
	masteranimallist[28] = "PandaGiant";
	masteranimallist[29] = "PandaRed";
	masteranimallist[30] = "LeopardSnow";
	
	--[[
						 1 = "GazelleThomsons", 
						 2 = "ZebraCommon", 
						 3 = "KangarooRed",
						 4 = "CamelDromedary",
						 5 = "Moose",
						 6 = "Gemsbok",
						 7 = "PeafowlCommon",
						 8 = "FlamingoGreater",
						 9 = "CrocodileNile",
						 10 = "Ostrich",
						 11 = "TigerBengal",
						 12 = "Jaguar",
						 13 = "LemurRingtailed",
						 14 = "Giraffe",
						 15 = "Cheetah",
						 16 = "Hippopotamus",
						 17 = "Ibex",
						 18 = "PenguinEmperor",
						 19 = "Lion",
						 20 = "Rhinoceros",
						 21 = "Chimpanzee",
						 22 = "GorillaMountain",
						 23 = "BearPolar",
						 24 = "ElephantAfrican",
						 25 = "BearGrizzly",
						 26 = "Beaver",
						 27 = "Okapi",
						 28 = "PandaGiant",
						 29 = "PandaRed",
						 30 = "LeopardSnow" };
	--]]
	
	-- Now loop through all of these animals and build a NEW table
	-- of the ones in the zoo
	local zooanimals = { };
	local num = table.getn(masteranimallist);
	local newindex = 1;
	
	for i = 1, num do
		-- If we find the animal from the master list, add it to the zooanimals array
		if (countType(masteranimallist[i]) >= 1) then
			zooanimals[newindex] = masteranimallist[i];
			newindex = newindex + 1;
		end
	end

	return zooanimals;	
end


-- Returns a table of the animals they DON'T have in their zoo
function animalsNotInZoo()
	-- Create a master list of all animals
	local masteranimallist = { };
	
	masteranimallist[1] = "GazelleThomsons";
	masteranimallist[2] = "ZebraCommon"; 
	masteranimallist[3] = "Kangaroo";
	masteranimallist[4] = "CamelDromedary";
	masteranimallist[5] = "Moose";
	masteranimallist[6] = "Gemsbok";
	masteranimallist[7] = "PeafowlCommon";
	masteranimallist[8] = "FlamingoGreater";
	masteranimallist[9] = "CrocodileNile";
	masteranimallist[10] = "Ostrich";
	masteranimallist[11] = "TigerBengal";
	masteranimallist[12] = "Jaguar";
	masteranimallist[13] = "LemurRingtailed";
	masteranimallist[14] = "Giraffe";
	masteranimallist[15] = "Cheetah";
	masteranimallist[16] = "Hippopotamus";
	masteranimallist[17] = "Ibex";
	masteranimallist[18] = "PenguinEmperor";
	masteranimallist[19] = "Lion";
	masteranimallist[20] = "RhinocerosBlack";
	masteranimallist[21] = "Chimpanzee";
	masteranimallist[22] = "GorillaMountain";
	masteranimallist[23] = "BearPolar";
	masteranimallist[24] = "ElephantAfrican";
	masteranimallist[25] = "BearGrizzly";
	masteranimallist[26] = "BeaverAmerican";
	masteranimallist[27] = "Okapi";
	masteranimallist[28] = "PandaGiant";
	masteranimallist[29] = "PandaRed";
	masteranimallist[30] = "LeopardSnow";
	
	-- Now loop through all of these animals and build a NEW table
	-- of the ones in the zoo
	local zooanimals = { };
	local num = table.getn(masteranimallist);
	local newindex = 1;
	
	for i = 1, num do
		-- If we find the animal from the master list, add it to the zooanimals array
		if (countType(masteranimallist[i]) == 0) then
			zooanimals[newindex] = masteranimallist[i];
			newindex = newindex + 1;
		end
	end

	return zooanimals;	
end


-- Pass in a table of strings indexed by number.  Returns how many of them exist in the zoo
function howManyInTableExist(thelist)
	if thelist == nil then
		return 0;
	end
	
	local num = table.getn(thelist);
	if (num == 0) then
		return 0;
	end
	
	local count = 0;
	
	for i = 1, num do
		if (countType(thelist[i]) > 0) then	
			count = count + 1;
		end
	end
	
	return count;
end

-- Returns the number of enrichment objects in the world.
function howManyEnrichExist()
	local enrichtable = { };
	enrichtable[1] = "CarTire";
	enrichtable[2] = "Easel";
	enrichtable[3] = "HeatedRock";
	enrichtable[4] = "IceFloe_Large";
	enrichtable[5] = "MonkeyBars";
	enrichtable[6] = "LookoutPost";
	enrichtable[7] = "PeanutFeeder";
	enrichtable[8] = "PlasticBarrel";
	enrichtable[9] = "ScratchPost";
	enrichtable[10] = "WoodenRamp";
	enrichtable[11] = "RubberToy";
	
	return howManyInTableExist(enrichtable);
end

-- Returns the number of animals in the zoo
function howManyAnimalsInZoo()
	local animaltable = animalsInZoo();
	
	local num = table.getn(animaltable);
	
	return num;
end


-- Returns true if the passed in entity has a grandmother, false otherwise
function entityHasGrandmother(entity)
	if (entity) then
		local grandmother = mother:sendMessage("BFAI_GET_RELATED_ENTITIES", "grandmother");
		
		-- If we get a non nil table here then we can return true
		if grandmother ~= nil and type(grandmother) == "table" then
			return true;
		end
	else
		BFLOG(SYSTRACE, "entityHasGrandmother - Bad entity");
	end
	
	return false;
end

function getSelectedEntity()
	local gameMgr = queryObject("BFGManager");
	if (gameMgr ~= nil) then
		return gameMgr:BFG_GET_SELECTED_ENTITY();
	end
	return nil;
end

function isEntityKindOf(entity, binderType)
	if (entity ~= nil) then
		local searchTable = findType(binderType);
		
		-- Loop through all of the objects in the table
		local num = table.getn(searchTable);
		
		for i = 1,num do
			local single = resolveTable(searchTable[i].value);
			if (single == entity) then
				return true;
			end
		end
	end
	return false;
end


function getRandomAnimalType()
	-- Create a master list of all animals
	local masteranimallist = { };
	
	masteranimallist[1] = "GazelleThomsons";
	masteranimallist[2] = "ZebraCommon"; 
	masteranimallist[3] = "Kangaroo";
	masteranimallist[4] = "CamelDromedary";
	masteranimallist[5] = "Moose";
	masteranimallist[6] = "Gemsbok";
	masteranimallist[7] = "PeafowlCommon";
	masteranimallist[8] = "FlamingoGreater";
	masteranimallist[9] = "CrocodileNile";
	masteranimallist[10] = "Ostrich";
	masteranimallist[11] = "TigerBengal";
	masteranimallist[12] = "Jaguar";
	masteranimallist[13] = "LemurRingtailed";
	masteranimallist[14] = "Giraffe";
	masteranimallist[15] = "Cheetah";
	masteranimallist[16] = "Hippopotamus";
	masteranimallist[17] = "Ibex";
	masteranimallist[18] = "PenguinEmperor";
	masteranimallist[19] = "Lion";
	masteranimallist[20] = "RhinocerosBlack";
	masteranimallist[21] = "Chimpanzee";
	masteranimallist[22] = "GorillaMountain";
	masteranimallist[23] = "BearPolar";
	masteranimallist[24] = "ElephantAfrican";
	masteranimallist[25] = "BearGrizzly";
	masteranimallist[26] = "BeaverAmerican";
	masteranimallist[27] = "Okapi";
	masteranimallist[28] = "PandaGiant";
	masteranimallist[29] = "PandaRed";
	masteranimallist[30] = "LeopardSnow";

	-- Now pick out one at random and return it
	local num = table.getn(masteranimallist);
	return masteranimallist[math.random(num)];
end


-- Returns the total number of good cum points of all animals
function getTotalGoodCumPoints()
	local objects = findType("animal");
		
	if (objects == nil) then
		return 0;
	end
		
	local num = table.getn(objects);
	local total = 0;

	for i = 1, num do
		-- Grab the needpointsbad and good for each Elephant
		local single = resolveTable(objects[i].value);
		total = total + getNeedPointsGoodCum(single);
	end
		
	return total;
end

-- Returns the total number of bad cum points of all animals
function getTotalBadCumPoints()
	local objects = findType("animal");
		
	if (objects == nil) then
		return 0;
	end
		
	local num = table.getn(objects);
	local total = 0;

	for i = 1, num do
		-- Grab the needpointsbad and good for each Elephant
		local single = resolveTable(objects[i].value);
		total = total + getNeedPointsGoodCum(single);
	end
		
	return total;
end


-- Will return true if there exist a male and female of the same species in your zoo
-- TODO:  Make this faster
function existMaleFemaleSameSpecies()
	local animals = findType("animal");
	
	if (animals == nil) then
		return false;
	end
	
	local num = table.getn(animals);
	for i = 1, num do
		local single = resolveTable(animals[i].value);
		if (isMale(single) == true) then
			local thetype = single:BFG_GET_BINDER_TYPE();
			
			BFLOG(SYSTRACE, "thetype = "..thetype..".");
			
			thetype = string.sub(thetype, string.find(thetype, "%a+"));
			
			BFLOG(SYSTRACE, "thetype = "..thetype..".");
		
			if (existFemale(thetype) == true) then
				return true;
			end
		else
			if (existMale(thetype) == true) then
				return true;
			end
		end
	end
	
	return false;
end