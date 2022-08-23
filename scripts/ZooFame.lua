FameGlobals = {
	halfStarsChanged = false,
	halfStarsLast = 0.0
}

function roundToNearest(v, n) 
	local roundoff = 0.1
	if n ~= nil and n > 0 then
		roundoff = math.pow(10, -(n+1))
	end
	return math.floor(v + roundoff * 0.5)
end

function round(v)
	return roundToNearest(v)
end

function getSpeciesPoints()
	local speciesPointsMax = 75.0
	local speciesPoints = 0.0
	local gameMgr = queryObject("BFGManager")
	if gameMgr ~= nil then
		local animals = gameMgr:BFG_GET_ENTITIES("animal")
		if animals ~= nil then
			--LUALOG("***** Found "..table.getn(animals).." animal(s) *****")
			local speciesTable = {}
			for i,v in ipairs(animals) do
				--LUALOG("***** Processing animal #"..i.." *****")
				local entity = resolveTable(v.value)
				if entity ~= nil then
					local speciesName = entity:BFG_GET_ATTR_STRING("s_Species")
					if speciesName ~= nil and string.len(speciesName) > 0 then
						local npg = entity:BFG_GET_ATTR_FLOAT("f_needPointsGood")
						local npb = entity:BFG_GET_ATTR_FLOAT("f_needPointsBad")
						local delta = npg - npb
						--LUALOG(string.format("***** Species: %s - Delta[%s] *****", speciesName, delta))
						if speciesTable[speciesName] == nil then
							speciesTable[speciesName] = { accumDelta = 0, count = 0 }
						end
						speciesTable[speciesName].accumDelta = speciesTable[speciesName].accumDelta + delta
						speciesTable[speciesName].count = speciesTable[speciesName].count + 1
						--LUALOG(string.format("***** Species: %s - AccumDelta[%d] *****", speciesName, speciesTable[speciesName].accumDelta))
					end
				end
			end
			for k,v in pairs(speciesTable) do
				local avg = v.accumDelta / v.count
				if avg > 0 then
					local pointsPerTierMax = 12
					local pointsPerTier = 2
					local tierSize = 10
					local points = math.min(pointsPerTierMax, round(avg / tierSize) * pointsPerTier)
					speciesPoints = speciesPoints + points
					--LUALOG(string.format("***** Species: %s - Avg[%.1f] Points[%.1f] *****", k, avg, points))
				else
					--LUALOG(string.format("***** Species: %s - Avg[%.1f] Adjust[0.0] *****", k, avg))
				end
			end
		end
	end
	return math.min(speciesPointsMax, speciesPoints)
end

function getSurveyPoints()
	local surveyPointsMax = 20.0
	local surveyPoints = 0.0
	local guestMgr = queryObject("ZTAIGuestMgr")
	if guestMgr ~= nil then
		local surveyWeights = {
			recommendzoo = 0.0,
			enjoyedzoo = 20.0,
			wasentertained = 0.0,
			waseducated = 0.0,
			foundfood = 0.0,
			founddrink = 0.0,
			founddessert = 0.0,
			foundfavfood = 0.0,
			founddonate = 0.0,
			foundgift = 0.0,
			foundbathroom = 0.0
		}
		for k,v in pairs(surveyWeights) do
			local ratingPerStar = 20
			local rating = guestMgr:ZTAI_GET_SURVEYDATA(k)
			local starsMax = 5
			local stars = math.min(starsMax, round(rating / ratingPerStar) + 1)
			local starsThreshold = 2
			local pointsPerStar = 1.0 / (starsMax - starsThreshold)
			local points = math.max(0, stars - starsThreshold) * pointsPerStar * v 
			BFLOG(string.format("***** Survey: %s - Rating[%d] Stars[%d] Points[%.1f] *****", k, rating, stars, points))
			surveyPoints = surveyPoints + points
		end
	end
	return math.min(surveyPointsMax, surveyPoints)
end

function getAwardPoints()
	if awardPoints ~= nil then
		local awardPointsMax = 15.0
		return math.min(awardPointsMax, awardPoints)
	else
		return 0.0
	end
end

function getScenarioPoints()
	if scenarioPoints ~= nil then
		local scenarioPointsMax = 15.0
		return math.min(scenarioPointsMax, scenarioPoints)
	else
		return 0.0
	end
end

function getReleaseToWildPoints(status)
	local releasedToWildPointsMax = 20.0
	local releasedToWildPoints = 0.0
	if FameGlobals.status ~= nil then
		local animalsReleased = FameGlobals.status:ZT_GET_ANIMALS_RELEASED()
		local pointsPerRelease = 3.0
		releasedToWildPoints = animalsReleased * pointsPerRelease
		--LUALOG("***** "..animalsReleased.." animal(s) released into the wild *****")
	end
	return math.min(releasedToWildPointsMax, releasedToWildPoints)
end

function updateZooGateTest(args)
	updateZooGate(tonumber(args[1].value))
end

function updateZooGate(famePoints)
	local binderType
	if famePoints == nil or (famePoints >= 0 and famePoints < 30) then
		binderType = "frontgate_df"
	elseif famePoints >= 30 and famePoints < 50 then
		binderType = "frontgate_fame02"
	elseif famePoints >= 50 and famePoints < 70 then
		binderType = "frontgate_fame03"
	elseif famePoints >= 70 and famePoints < 90 then
		binderType = "frontgate_fame04"
	else
		binderType = "frontgate_fame05"
	end
	
	if lastBinderType == nil or binderType ~= lastBinderType then
		local gameMgr = queryObject("BFGManager")
		if gameMgr ~= nil then
			local gates = gameMgr:BFG_GET_ENTITIES("entrance")
			if gates ~= nil and table.getn(gates) > 0 then
				local thisGate = resolveTable(gates[1].value)
				if thisGate ~= nil then
					thisGate:BFG_ENTITY_MORPH_TO_NEW_ENTITY{ binderType }
					lastBinderType = binderType
				end
			end
		end
	end
end

function updateHalfStars(famePoints)
	local famePerHalfStar = 10
	local halfStarsMax = 10
	local halfStars = math.min(halfStarsMax, round(famePoints / famePerHalfStar) + 1)
	LUALOG(string.format("***** Fame: Points [%.1f] Stars [%.1f] *****", famePoints, halfStars / 2))
	if FameGlobals.status ~= nil then
		if not FameGlobals.halfStarsChanged then
			FameGlobals.halfStarsLast = FameGlobals.status:ZT_GET_FAME_HALFSTARS()
			if halfStars ~= FameGlobals.halfStarsLast then
				--LUALOG(string.format("***** Stars changed: Was[%.1f] Now[%.1f]; deferring update", FameGlobals.halfStarsLast / 2, halfStars / 2))
				FameGlobals.halfStarsChanged = true
				FameGlobals.halfStarsLast = halfStars
			else
				--LUALOG("***** Stars remain unchanged *****")
			end
		else 
			if halfStars ~= FameGlobals.halfStarsLast then
				--LUALOG(string.format("***** Stars changed: Was[%.1f] Now[%.1f]; deferring update again", FameGlobals.halfStarsLast / 2, halfStars / 2))
				FameGlobals.halfStarsLast = halfStars
			else
				LUALOG(string.format("***** Stars updated: Now[%.1f] *****", halfStars / 2))
				FameGlobals.halfStarsChanged = false
				FameGlobals.halfStarsLast = 0.0
				updateZooGate(famePoints)
				return halfStars
			end
		end
	end
	return nil
end

function setFamePoints(famePoints)
	local halfStars = updateHalfStars(famePoints)
	if halfStars ~= nil then
		FameGlobals.status:ZT_SET_FAME_HALFSTARS{ halfStars, famePoints }
	else
		FameGlobals.status:ZT_SET_FAME_HALFSTARS{ luanil, famePoints }
	end
end

function adjustZooFame(status)
	if FameGlobals.status == nil or FameGlobals.status ~= status then
		--LUALOG("***** Initializing FameGlobals.status *****")
		FameGlobals.status = status
		status.awardPoints = 0.0
		status.scenarioPoints = 0.0
	end

	--LUALOG("***** adjustZooFame called *****")	
	local speciesPoints = getSpeciesPoints() 
	--LUALOG(string.format("***** getSpeciesPoints returned: %.1f *****", speciesPoints))
	local surveyPoints = getSurveyPoints()
	--LUALOG(string.format("***** getSurveyPoints returned: %.1f *****", surveyPoints))
	local awardPoints = getAwardPoints()
	--LUALOG(string.format("***** getAwardPoints returned: %.1f *****", awardPoints))
	local scenarioPoints = getScenarioPoints()
	--LUALOG(string.format("***** getScenarioPoints returned: %.1f *****", scenarioPoints))
	local releaseToWildPoints = getReleaseToWildPoints()
	--LUALOG(string.format("***** getReleaseToWildPoints returned: %.1f *****", releaseToWildPoints))
	local famePointsMin = 1.0
	local famePointsMax = 100.0
	local famePoints = speciesPoints + surveyPoints + awardPoints + scenarioPoints + releaseToWildPoints
	famePoints = math.max(famePointsMin, math.min(famePointsMax, famePoints))
	setFamePoints(famePoints)
end
