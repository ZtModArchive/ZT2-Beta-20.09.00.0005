-- photoutil.lua
-- Misc photo utility functions

-- HEADER

-- entity of type t1 contains TWO entities of type t2
-- if this works, move it to testscoring.lua?
-- function scoreT1ContainsTwoT2(pt, t1, t2)

-- function scoreT1(pt, t1)

-- entity of type t1 contains an entity of type t2
-- function scoreT1ContainsT2(pt, t1, t2)

-- returns the number of photochallenge requirements completed
-- function numPhotoRequirementsMet()

-- returns the number of photochallenge requirements
-- function numPhotoRequirements()



-- FUNCTIONS

-- entity of type t1 contains TWO entities of type t2
function scoreT1ContainsTwoT2(pt, t1, t2)
	countguest = 0
	local score = 0
	local t = pt:getType(t1)
	local e1 = pt:getFirstInterestingEntity()
	while (e1) do
		if (e1:isKindOf(t)) then
			BFLOG(SYSTRACE, "found t1")
			local pac = e1:getPAC()
			if (pac) then
				BFLOG(SYSTRACE, "found t1's PAC")
				-- iterate over entities held by t1
				local be = pac:getFirstContainedEntity()
				while be do
					BFLOG(SYSTRACE, "examining an entity")
					-- is any a t2?
					if (be:isKindOf(t2)) then
						BFLOG(SYSTRACE, "found t2")
						-- if so, score is 1
						score = 1
						countguest = countguest + 1
						if (countguest == 2) then
							break
						end
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

-- find first entity of this type
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

-- find first entity of this type that is in the water
function findMatchingEntityInWater(pt, etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(etype)) then
			local pac = e:getPAC()
			if (pac) then
--				if (pac:
			
					return e
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return e
end

-- return number of entities doing anim X
function numEntitiesDoingAnim(pt, etype, anim)
	local matchingEntityType = pt:getType(etype)
	local e = pt:getFirstInterestingEntity()
	local nummatching = 0
	while e do
		if (e:isKindOf(matchingEntityType)) then
			--BFLOG(SYSNOTE, "found a matching entity")
			local pac = e:getPAC()
			if (pac) then
				local animdoing = pac:getActiveSequenceName()
				--local animtime = pac:getActiveSequenceTime()
				BFLOG(SYSNOTE, "found a matching entity doing "..animdoing)
				if (anim == animdoing) then
					nummatching = nummatching + 1
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	BFLOG(SYSNOTE, "found "..nummatching.." matching entity/ies doing "..anim)
	return nummatching
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

function scoreAnyEntityTypeDoingTaskAndAnim(pt, etype, task, anim)
	local score = 0.0
	local matchingEntityType = pt:getType(etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			--BFLOG(SYSNOTE, "found a matching entity")
		
			local pac = e:getPAC()
			if (pac) then
				local taskdoing = pac:getCurrTask()
				local animdoing = pac:getActiveSequenceName()
				--local animtime = pac:getActiveSequenceTime()
				BFLOG(SYSNOTE, "found a matching entity doing anim "..animdoing.." and task "..taskdoing)
				if (anim == animdoing) then
					if (task == taskdoing) then
						return 1.0
					end
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

function scoreAnyEntityTypeDoingMatchingPlaySetInList(pt, etype, playsetlist)
	local score = 0.0
	local matchingEntityType = pt:getType(etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			score = 0.3
			local luabm = e:getBM()
			if (luabm) then
				local ps = luabm:getCurrentPlaySet()
				for v in ipairs(playsetlist) do
					local found, donotcare = string.find(ps, playsetlist[v])
					if (found) then
						return 1.0
					end
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

function scoreAnyDoingTaskInList(pt, etype, tasklist)
	local score = 0.0
	local matchingEntityType = pt:getType(etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			score = 0.3
			local pac = e:getPAC()
			if (pac) then
				local task = pac:getCurrTask()
				for v in ipairs(tasklist) do
					BFLOG(SYSNOTE, "look for "..tasklist[v].." in "..task)
					local found, donotcare = string.find(task, tasklist[v])
					if (found) then
						return 1.0
					end
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

function scoreAnyEntityTypeDoingTaskWithTarget(pt, etype, tasklist, target)
	local score = 0.0
	local matchingEntityType = pt:getType(etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			local pac = e:getPAC()
			if (pac) then
				local tasktarget = pac:getTaskTarget()
				BFLOG(SYSNOTE, "target: "..target.."  tasktarget: "..tasktarget)
				if (target == tasktarget) then
					local task = pac:getCurrTask()
					for v in ipairs(tasklist) do
						BFLOG(SYSNOTE, "is "..task.." within "..tasklist[v].."?")
						local found, donotcare = string.find(task, tasklist[v])
						if (found) then
							BFLOG(SYSNOTE, "yes!")
							return 1
						end
					end
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

function scoreAnyEntityTypeDoingTarget(pt, etype, target)
	local score = 0.0
	local matchingEntityType = pt:getType(etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			local pac = e:getPAC()
			if (pac) then
				local tasktarget = pac:getTaskTarget()
				BFLOG(SYSNOTE, "target: "..target.."  tasktarget: "..tasktarget)
				if (isKindOf(tasktarget, target)) then
					return 1
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

function scoreAnyEntityTypeDoingTaskAndBehsetWithTarget(pt, etype, tasklist, behset, target)
	local score = 0.0
	local matchingEntityType = pt:getType(etype)
	local e = pt:getFirstInterestingEntity()
	while e do
		if (e:isKindOf(matchingEntityType)) then
			BFLOG(SYSNOTE, "found matching entity")
			local pac = e:getPAC()
			if (pac) then
				local tasktarget = pac:getTaskTarget()
				BFLOG(SYSNOTE, "tasktarget of "..tasktarget.."...is it a kind of "..target.."?")
				if (isKindOf(tasktarget, target)) then
					local luabm = e:getBM()
					if (luabm) then
						local ps = luabm:getCurrentPlaySet()
						BFLOG(SYSNOTE, "playset "..ps.."...does it match "..behset.."?")
						if (ps == behset) then
							BFLOG(SYSNOTE, "yes")
							local task = pac:getCurrTask()
							for v in ipairs(tasklist) do
								local found, donotcare = string.find(task, tasklist[v])
								BFLOG(SYSNOTE, "doing "..task.."...does it match "..tasklist[v].."?")
								if (found) then
									BFLOG(SYSNOTE, "yes!")
									return 1
								end
							end
						end
					end
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

-- return 0.0 if no such entity; 0.3 if did, but not one doing any anim in animlist;
-- 1.0 if found an entity doing any anim in animlist
function scoreAnyEntityTypeDoingMatchingAnimInList(pt, etype, animlist)
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
				for v in ipairs(animlist) do
					local found, donotcare = string.find(animdoing, animlist[v])
					if (found) then
						return 1.0
					end
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	return score
end

function scoreT1(pt, t1)
	local score = 0
	local t = pt:getType(t1)
	local e1 = pt:getFirstInterestingEntity()
	while (e1) do
		if (e1:isKindOf(t)) then
			BFLOG(SYSNOTE, "found t1")
			return 1
		else
		end
		e1 = pt:getNextInterestingEntity()
	end
	return score
end

-- number of entity type T1 within frame
function numberOfT1(pt, t1)
	local num = 0
	local t = pt:getType(t1)
	local e1 = pt:getFirstInterestingEntity()
	while (e1) do
		if (e1:isKindOf(t)) then
			num = num + 1
		else
		end
		e1 = pt:getNextInterestingEntity()
	end
	return num
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
						-- if so, score is 1
						score = 1
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


-- returns the number of photochallenge requirements completed
function numPhotoRequirementsMet()
	local mgr = queryObject("ZTPhotoChallengesComponent");
	
	if (mgr) then
		local numchalphotos = mgr:ZT_PHOTOEVENT_GET_NUM_CHALLENGE_PHOTOS();
		local count = 0;
		
		for i = 0, numchalphotos do
			local reqstars = mgr:ZT_PHOTOEVENT_GET_REQUIRED_CHALLENGE_STARS(i);
			local obstars = mgr:ZT_PHOTOEVENT_GET_OBTAINED_CHALLENGE_STARS(i);
			
			if (obstars >= reqstars) then
				count = count + 1;
			end
		end
		
		BFLOG(SYSTRACE, "Photo challenges: [ "..count.." / "..numchalphotos.." ]");
		
		return count;
	end
end

-- returns the number of photochallenge requirements
function numPhotoRequirements()
	local mgr = queryObject("ZTPhotoChallengesComponent");
	
	if (mgr) then
		local numchalphotos = mgr:ZT_PHOTOEVENT_GET_NUM_CHALLENGE_PHOTOS();
		
		return numchalphotos;
	end
end