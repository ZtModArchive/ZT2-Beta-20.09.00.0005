-- wildlifemagazine.lua
-- Wildlife magazine photo challenge

include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalwildlifemagazinephoto(comp)
	BFLOG(SYSTRACE, "evalwildlife");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("wildlifemagazinephoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("WildlifeMagazine");
		end
		
		setglobalvar("challenge", nil);
		setglobalvar("challengeactive", "true");
		
		comp.accept = 1;
		showphotogoals();
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!")
		
		setglobalvar("challenge", nil);
		
		BFLOG(SYSTRACE, "About to return -1 from wildlifemagazine");
		return -1;
	end
	

	if (comp.accept == nil) then
		if (challenge == nil) then
			showchallengepanel("WildlifeMagChallengetext: PHWildlifeMag");
			
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting")
		end
	end

	if (comp.accept == 1) then
		local pm = queryObject("ZTPhotoChallengesComponent");
		local flag = pm:ZT_PHOTOEVENT_GET_CHALLENGES_COMPLETED();
		if (flag) then
			
			-- GIVE STUFF OUT
			giveCash(8000);
			
			return 1;
		else
			return 0;
		end
	end	

end

-- >= 3 zebras
function scoreThreeZebras(comp)
	if (numberOfT1(comp, "ZebraCommon") >= 3) then
		return 1
	else
		return 0
	end
end

-- >= 2 flamingos, >= 1 hippo
function scoreFlamingoesandHippo(comp)
	if (numberOfT1(comp, "FlamingoGreater") >= 2) then
		if (numberOfT1(comp, "Hippopotamus") >= 1) then
			return 1
		else
			return 0
		end
	end
	return 0
end

function scoreCrocinWater(comp)
	if (numberOfT1(comp, "CrocodileNile") >= 1) then	-- TODO add in-water test
		return 1
	else
		return 0
	end
end

function scoreKangarooTailThumping(comp)
	if (scoreAnyEntityTypeDoingAnimX(comp, "KangarooRed", "Stand_ThumpTail") >= 1.0) then
		return 1
	end
	return 0
end

function completewildlifemagazinephoto(comp)

	BFLOG(SYSTRACE, "WE DID IT");
	
	showchallengewin("PhotoChallengetext:PHWildlifeMagFullSuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("wildlifemagazine_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));
end


function failwildlifemagazinephoto(comp)

	BFLOG(SYSTRACE, "FAILURE");
	
	-- completeshowoverview();
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("wildlifemagazine_over", "true");
	
	return 1;
end