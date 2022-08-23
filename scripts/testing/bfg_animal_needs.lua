-- sets all the "animal" "need" to "value" in a given map
function setAnimalNeed(animal, need, value)
	local gameMgr = queryObject("BFGManager")
	if gameMgr ~= nil then
		local entityList = findType(animal)
		if entityList ~= nil and type(entityList) == "table" then
			local numAnimals = table.getn(entityList)
			BFLOG(SYSNOTE, "***** Found " .. numAnimals .. " " .. animal .. "(s)!" .. " *****")
			for i = 1, numAnimals, 1 do
				local creature = resolveTable(entityList[i].value)
				if creature ~= nil and creature:BFG_SET_ATTR_FLOAT(need, value) then
					local eval_need = creature:BFG_GET_ATTR_FLOAT(need)
					if (eval_need == value) then
						BFLOG(SYSNOTE, "***** " .. animal .. i .. "'s " .. need .. " need was successfully set to " .. value .. "! *****")
					else
						BFLOG(SYSERROR, "***** Could not set " .. need .. " on " .. animal .. i)
					end
				else
					BFLOG(SYSERROR, "***** Could not get a valid entity! *****")
				end
					
			end
		else
			BFLOG(SYSERROR, "***** Could not get a valid entity list! *****")
		end
	else
		BFLOG(SYSERROR, "***** Can't find the BFGameManager! *****")
	end
end


-- This function will set Good need points for all "animal" in a map to "value"
function setNeedPointsGood(animal, value)

	setAnimalNeed(animal, "f_needPointsGood", value)
	--setSelectedNeed(animal, "f_needPointsGood", value)

end


-- This function sets Bad need points for all "animal" in a map to "value"
function setNeedPointsBad(animal, value)

	setAnimalNeed(animal, "f_needPointsBad", value)
	--setSelectedNeed(animal, "f_needPointsBad", value)

end


-- This function will zero all need points.  This will not change good/bad need points
function zeroNeeds(animal)

	setAnimalNeed(animal, "stimulation", 0.0)	
	setAnimalNeed(animal, "social", 0.0)	
	setAnimalNeed(animal, "privacy", 0.0)	
	setAnimalNeed(animal, "exercise", 0.0)	
	setAnimalNeed(animal, "hygiene", 0.0)	
	setAnimalNeed(animal, "bathroom", 0.0)	
	setAnimalNeed(animal, "reproduction", 0.0)	
	setAnimalNeed(animal, "rest", 0.0)	
	setAnimalNeed(animal, "thirst", 0.0)	
	setAnimalNeed(animal, "hunger", 0.0)

end

-- sets animals of specified-type needPoints good to 100 and their other needs are zeroed
--
--function prepAnimalGood(args)
	--local animal = args[1].value
--end