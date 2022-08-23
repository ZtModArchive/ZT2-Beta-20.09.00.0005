-- lua file for testing photo scoring

function scoreTigerBig(pt)
	local score = 0
	local t1 = pt:getType("TigerBengal")
	local e1 = findMatchingEntity(pt, t1)
	if (e1) then
		pa = e1:getPAC()
		if (pa) then
			score = pa.getPercentOfScreen
			BFLOG(SYSNOTE, "tiger percent seen: "..pa.percentSeen)
			BFLOG(SYSNOTE, "tiger percent seen in center: "..pa.percentSeenInCenter)
			BFLOG(SYSNOTE, "tiger percent of screen: "..pa.percentOfScreen)
		else
			BFLOG(SYSNOTE, "no photo analysis component")
		end
	else
		BFLOG(SYSNOTE, "no TigerBengal present")
	end
	return score
end

-- entity of type t1 contains an entity of type t2
function scoreT1ContainsT2(pt, t1, t2)
	local score = 0
	local t = pt:getType(t1)
	local e1 = pt:getFirstInterestingEntity()
	while (e1) do
		if (e1:isKindOf(t)) then
			BFLOG(SYSNOTE, "found t1")
			local pac = e1:getPAC()
			if (pac) then
				BFLOG(SYSNOTE, "found t1's PAC")
				-- iterate over entities held by t1
				local be = pac:getFirstContainedEntity()
				while be do
					BFLOG(SYSNOTE, "examining an entity")
					-- is any a t2?
					if (be:isKindOf(t2)) then
						BFLOG(SYSNOTE, "found t2")
						-- if so, score is 100
						score = 100
						break
					end
					be = pac:getNextContainedEntity()
				end
			else
			end
		else
		end
		e1 = pt:getNextInterestingEntity()
	end
	return score
end

function keeperOnBench(pt)
	local score = 0
	local t1 = pt:getType("bench")
	local e1 = pt:getFirstInterestingEntity()
	while (e1) do
		if (e1:isKindOf(t1)) then
			BFLOG(SYSNOTE, "found bench")
			local pac = e1:getPAC()
			if (pac) then
				BFLOG(SYSNOTE, "found bench's PAC")
				-- iterate over entities on bench
				local be = pac:getFirstContainedEntity()
				while be do
					-- is any a keeper?
					BFLOG(SYSNOTE, "checking out "..be:getEDI():getVar("s_name"))
					if (be:isKindOf("Keeper")) then
						BFLOG(SYSNOTE, "found keeper")
						-- if so, score is 100
						score = 100
						break
					end
					be = pac:getNextContainedEntity()
				end
			else
			end
		else
		end
		e1 = pt:getNextInterestingEntity()
	end
	return score
end

function guestHoldingHamburger(pt)
	local score = 0
	local t1 = pt:getType("Guest")
	local e1 = pt:getFirstInterestingEntity()
	while (e1) do
		if (e1:isKindOf(t1)) then
			BFLOG(SYSNOTE, "found guest "..e1:getEDI():getVar("s_name"))
			local pac = e1:getPAC()
			if (pac) then
				BFLOG(SYSNOTE, "found guest's PAC")
				-- iterate over entities held by guest
				local be = pac:getFirstContainedEntity()
				while be do
					BFLOG(SYSNOTE, "examining an item")
					-- is any a burger?
					if (be:isKindOf("Hamburger")) then
						BFLOG(SYSNOTE, "found burger")
						-- if so, score is 100
						score = 100
						break
					end
					be = pac:getNextContainedEntity()
				end
			else
			end
		else
		end
		e1 = pt:getNextInterestingEntity()
	end
	return score
end

function chimpInTree(pt)
	return scoreT1ContainsT2(pt, "tree", "Chimpanzee")
end

function scoreTigerWalking(pt)
--	return chimpInTree(pt)
--	return guestHoldingHamburger(pt)
	return scoreAnyEntityTypeDoingX(pt, "TigerBengal", "Walk_Ahead")
end

function scoreTigerEating(pt)
	return scoreAnyEntityTypeDoingX(pt, "TigerBengal", "Eat")
end

function scoreElephantWalking(pt)
	return scoreAnyEntityTypeDoingX(pt, "ElephantAfrican", "Walk_Ahead")
end

function scoreElephantBrowsing(pt)
	return scoreAnyEntityTypeDoingX(pt, "ElephantAfrican", "Browse")
end

function scoreNearbyMotherAndYoungTiger(pt)
	local t1 = pt:getType("TigerBengal_Adult_F")
	local t2 = pt:getType("TigerBengal_Young")
	local score = scoreNearbyEntityTypes(pt, t1, t2, 10.0, 100.0)
	return score
end

function scoreNearbyTigerAndGorilla(pt)
	local t1 = pt:getType("TigerBengal")
	local t2 = pt:getType("GorillaMountain")
	local score = scoreNearbyEntityTypes(pt, t1, t2, 10.0, 100.0)
	return score
end

function scoreHungryTiger(pt)
	local highscore = 0.0
	local etype = pt:getType("TigerBengal")
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(etype)) then
			score = getEntityStateVar(e, "hunger") / 100.0
			BFLOG(SYSNOTE, "score: "..score)
			if (score > highscore) then
				highscore = score
				BFLOG(SYSNOTE, "new highscore: "..highscore)
			end
		end
		e = pt:getNextInterestingEntity()
	end
	BFLOG(SYSNOTE, "highscore: "..highscore)
	return highscore
end

-- pt: parse tree
-- t1: pt:getType("type1")
-- t2: pt:getType("type2")
-- minDist: distance radius inside of which is 1.0 score
-- maxDist: distance radius outside of which is 0.0 score
function scoreNearbyEntityTypes(pt, t1, t2, minDist, maxDist)
	local e1 = findMatchingEntity(pt, t1)
	if (e1) then
		BFLOG(SYSNOTE, "found first entity")
		local e2 = pt:getFirstInterestingEntity()
		while e2 do
			if (e2:isKindOf(t2)) then
				BFLOG(SYSNOTE, "found matching entities!")
				local po1 = e1:getFirstPhysObj()
				local p1 = po1:getPosition()
				local po2 = e2:getFirstPhysObj()
				local p2 = po2:getPosition()
				return nearbyScore(p1, p2, minDist, maxDist)
			end
			e2 = pt:getNextInterestingEntity()
		end
	end
	BFLOG(SYSNOTE, "did not find matching entities!")
	return 0.0
end

function scoreIsEntitySleeping(e)
	return scorePlaySetInContext(e, "Sleep")
end



-- global functions for photo analysis

function nearbyScore(e1, e2, minDist, maxDist)
	local dist = distSquared(e1, e2)
	BFLOG(SYSNOTE, "dist: "..dist)
	local distScore = 0.0
	if (dist <= minDist) then
		BFLOG(SYSNOTE, "dist <= minDist")
		distScore = 1.0
	elseif (dist >= maxDist) then
		BFLOG(SYSNOTE, "dist >= minDist")
		distScore = 0.0
	else
		BFLOG(SYSNOTE, "minDist < dist < maxDist")
		distScore = 1.00 - (dist - minDist) / (maxDist - minDist)
	end
	return distScore
end

function findMatchingEntity(pt, etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(etype)) then
			return e
		end
		e = pt:getNextInterestingEntity()
	end
	return e
end

function distSquared(p1, p2)
	return (p1.x - p2.x) * (p1.x - p2.x) +
			(p1.y - p2.y) * (p1.y - p2.y) +
			(p1.z - p2.z) * (p1.z - p2.z)
end

function scorePlaySetInContext(e, ps)
	local luabm = e:getBM()
	if (luabm) then
		--BFLOG(SYSNOTE, "testing against playset "..ps)
		local isDoing = luabm:isPlaySetInContext(ps)
		if (isDoing) then
			BFLOG(SYSNOTE, "entity is doing "..ps);
			return 1.0
		end
	end
	return 0.0
end

function scoreEntityCurrentlyDoingPlaySet(e, ps)
	local luabm = e:getBM()
	if (luabm) then
		local ps = luabm:getCurrentPlaySet()
		BFLOG(SYSNOTE, "current playset: "..ps)
		return ps
	else
		BFLOG(SYSNOTE, "no BFBehaviorMgr found")
	end
	return ""
end

function getEntityStateVar(e, var)
	local luacm = e:getCM()
	if (luacm) then
		value = luacm:getStateVar(var)
		BFLOG(SYSNOTE, var.." (var)= "..value)
		return value
	else
		BFLOG(SYSNOTE, "no BFAICognitiveMgr found")
	end
	return 0.0
end

function getEntitySharedVar(e, var)
	value = e:getSharedVar(var)
	BFLOG(SYSNOTE, var.." (shared var)= "..value)
	return value
end

-- return 0.0 if no such entity; 0.3 if did, but not one doing X; 1.0 if found an entity doing X
function scoreAnyEntityTypeDoingX(pt, etype, verb)
	local score = 0.0
	local matchingEntityType = pt:getType(etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			--BFLOG(SYSNOTE, "found a matching entity")
			score = 0.3
			
			local psscore = scorePlaySetInContext(e, verb)
			if (psscore > 0.0) then
				return 1.0
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

-- return 0.0 if no such entity; 0.3 if did, but not one doing X; 1.0 if found an entity doing anim X
function scoreAnyEntityTypeDoingAnimX(pt, etype, anim)
	local score = 0.0
	local matchingEntityType = pt:getType(etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			--BFLOG(SYSNOTE, "found a matching entity")
			score = 0.3
			
			local pac = e:getPAC()
			if (pac) then
				local animdoing = pac:getActiveSequenceName()
				--local animtime = pac:getActiveSequenceTime()
				BFLOG(SYSNOTE, "found a matching entity doing "..animdoing)
				if (anim == animdoing) then
					return 1.0
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

-- given entity e, return anim and animtime (time w/in animation)
function doingAnimX(e, anim, animtime)
	local pac = e:getPAC()
	local anim, animtime
	if (pac) then
		anim = pac:getActiveSequenceName()
		animtime = pac:getActiveSequenceTime()
	else
		anim = ""
		animtime = 0.0
	end
	return anim, animtime
end

function scoreLionRoaring(pt)
	local score = 0.0
	local matchingEntityType = pt:getType("Lion")
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			local anim
			local animtime
			anim, animtime = doingAnimX(e)
			if (anim == "Stand_Roar" and 0.3 <= animtime and animtime <= 1.3) then
				return 1.0
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

function scoreZebraGrazing(pt)
	local score = 0.0
	local matchingEntityType = pt:getType("ZebraCommon")
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			local anim
			local animtime
			anim, animtime = doingAnimX(e)
			BFLOG(SYSNOTE, "doing "..anim.." at time "..animtime)
			if (anim == "Graze_Idle" and 0.6 <= animtime and animtime <= 3.5) then
				return 1.0
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end
