-- primatepictures.lua
-- primate pictures photo challenge
 
include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalprimatepictures(comp)

	BFLOG(SYSTRACE, "evalprimatepictures");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("primatepicturesphoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("PrimatePictures");
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
			local showchallengepanel = showchallengepanel("PrimatePicturestext:PHPrimatePictures");
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



function scoreGorillaChuckling(comp)
	if (scoreAnyEntityTypeDoingAnimX(comp, "GorillaMountain", "Stand_Chuckle") >= 1.0) then
		return 1
	end
	return 0
end


function scoreGorillaCalling(comp)
	if (scoreAnyDoingTaskInList(comp, "GorillaMountain_Adult_M", {"Call_Sleep"}) >= 1.0) then
		return 1
	end
	return 0
end


function scoreChimpUseMonkeyBars(comp)
	if (scoreAnyEntityTypeDoingTaskWithTarget(comp,
			"Chimpanzee",
			{"MonkeyBars"},
			"MonkeyBars")
				>= 1.0) then
		return 1
	end
	return 0
end


function scoreChimpClimbTree(comp)
	return scoreT1ContainsT2(comp, "tree", "Chimpanzee")
end




function completeprimatepictures(comp)
	BFLOG(SYSTRACE, "complete primatepictures");
	
	-- Give rewards here
	giveGuest(20);
	
	showchallengewin("PrimatePicturestext:PHPrimatePicturesSuccess");
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("primatepictures_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));
end

function failprimatepictures(comp)
	BFLOG(SYSTRACE, "fail primatepictures");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("primatepictures_over", "true");
end

