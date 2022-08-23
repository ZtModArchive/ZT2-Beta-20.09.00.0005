-- psychologicalconference.lua
-- national confernce on psychological animal stimulation photo challenge
 
include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalpsychologicalconference(comp)
	BFLOG(SYSTRACE, "evalpsychologicalconference");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("psychologicalconferencephoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("PsychologicalConference");
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
			local showchallengepanel = showchallengepanel("PsychologicalConferencetext:PHPsychologicalConference");
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



function scorePandaUseCarTire(comp)
	if (scoreAnyEntityTypeDoingTaskAndBehsetWithTarget(comp,
			"PandaGiant",
			{"PlayElite"},
			"NudgeObject_Whap",
			"CarTire") >= 1.0) then
		return 1
	elseif (scoreAnyEntityTypeDoingTaskAndBehsetWithTarget(comp,
				"PandaGiant",
				{"PlayElite"},
				"TackleObject_Whap",
				"CarTire") >= 1.0) then
		return 1
	elseif (scoreAnyEntityTypeDoingTaskAndBehsetWithTarget(comp,
				"PandaGiant",
				{"PlayElite"},
				"BatObject_Whap",
				"CarTire") >= 1.0) then
		return 1
	elseif (scoreAnyEntityTypeDoingTaskAndBehsetWithTarget(comp,
				"PandaGiant",
				{"PlayElite"},
				"ChaseBall",
				"CarTire") >= 1.0) then
		return 1
	end
	return 0
end


function scoreElephantUseEasel(comp)
	if (scoreAnyEntityTypeDoingTaskAndBehsetWithTarget(comp,
			"ElephantAfrican",
			{"Paint"},
			"Paint",
			"Easel")
			>= 1.0) then
		return 1
	end
	return 0
end

function scoreCheetahUseHeatedRock(comp)
	if (scoreAnyEntityTypeDoingTaskAndBehsetWithTarget(comp,
			"Cheetah",
			{"HeatedRockMedium", "HeatedRockAdvanced", "HeatedRockElite"},
			"UseHeatedRock",
			"HeatedRock")
				>= 1.0) then
		return 1
	end
	return 0
end

function scoreRhinoUsePursuitBall(comp)
	if (scoreAnyEntityTypeDoingTaskAndBehsetWithTarget(comp,
			"RhinocerosBlack",
			{"PlayBasic", "PlayMedium", "PlayAdvanced", "PlayElite"},
			"ChaseBall",
			"PursuitBall")
				>= 1.0) then
		return 1
	end
	return 0
end


function completepsychologicalconference(comp)
	BFLOG(SYSTRACE, "complete psychologicalconference");
	
	
	-- Give rewards here
	giveCash(20000);
	
	showchallengewin("PsychologicalConferencetext:PHPsychologicalConferenceSuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("psychologicalconference_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));
end



function failpsychologicalconference(comp)
	BFLOG(SYSTRACE, "fail psychologicalconference");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("psychologicalconference_over", "true");
end