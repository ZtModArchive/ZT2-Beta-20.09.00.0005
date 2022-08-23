-- animalinstincts.lua
-- animal instincts photo challenge
 
include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalanimalinstincts(comp)
	BFLOG(SYSTRACE, "evalanimalinstincts");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("animalinstinctsphoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("AnimalInstincts");
		end
		
		setglobalvar("challenge", nil);
		setglobalvar("challengeactive", "true");
		
		comp.accept = 1;
		showphotogoals();
		
	elseif (challenge == "decline") then

		BFLOG(SYSTRACE, "You declined!")

		return -1;
	end
	

	if (comp.accept == nil) then
		if (challenge == nil) then
			local showchallengepanel = showchallengepanel("AnimalInstinctstext:PHAnimalInstincts");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting")
		end
	end

	if (comp.accept == 1) then
	
		numPhotoRequirementsMet();
	
		local pm = queryObject("ZTPhotoChallengesComponent");
		local flag = pm:ZT_PHOTOEVENT_GET_CHALLENGES_COMPLETED();
		if (flag) then
			BFLOG(SYSTRACE, "!!!!!!!!!!!!!Done!!!!!!!!!!!!!");
			
			return 1;
		else
			return 0;
		end
	end
	
	return 0;

end



function scoreLemursGrooming(comp)
	if (scoreAnyEntityTypeDoingAnimX(comp, "LemurRingtailed", "GroomOther_Idle") >= 1.0) then
		return 1
	end
	return 0
end


function scoreLionsSleepinShade(comp)
-- one male, 3 females and one baby lion
	if (numberOfT1(comp, "Lion_Adult_M") >= 1 and numberOfT1(comp, "Lion_Adult_F") >= 3 and numberOfT1(comp, "Lion_Young") >= 1)then
		return 1
	end
	return 0
end

function scoreOstrichMatingDance(comp)
	if (scoreAnyEntityTypeDoingAnimX(comp, "Ostrich", "Stand_MateDance") >= 1.0) then
		return 1
	end
	return 0
end

function scoreYoungGiraffeCalling(comp)
	if (scoreAnyDoingTaskInList(comp, "Giraffe_Young", {"CallMother"}) >= 1.0) then
		return 1
	end
	return 0
end



function completeanimalinstincts(comp)
	BFLOG(SYSTRACE, "complete animalinstincts");
	
	
	-- Give rewards here
	FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 2;
	
	
	showchallengewin("AnimalInstinctstext:PHAnimalInstinctsSuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("animalinstincts_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));

end


function failanimalinstincts(comp)
	BFLOG(SYSTRACE, "fail animalinstincts");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("animalinstincts_over", "true");
end
