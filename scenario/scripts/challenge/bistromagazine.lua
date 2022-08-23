-- bistromagazine.lua
-- bistromagazine photo challenge
 
include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalbistromagazine(comp)
	BFLOG(SYSTRACE, "evalbistromagazine");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("bistromagazinephoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("BistroMagazine");
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
			local showchallengepanel = showchallengepanel("BistroMagazinetext:PHBistroMagazine");
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



function scoreTigerEatMeatCarcass(comp)
	if (scoreAnyEntityTypeDoingTaskWithTarget(comp, "TigerBengal", {"Eat"}, "Carcass_Meat") >= 1.0) then
		return 1
	end
	return 0
end


function scoreGiraffeEatBranchesBrowseHolder(comp)
	if (scoreAnyEntityTypeDoingTaskWithTarget(comp, "GiraffeReticulated", {"Eat"}, "BrowseHolder") >= 1.0) then
		return 1
	end
	return 0
end

function scoreLemurEatElevatedDish(comp)
	if (scoreAnyEntityTypeDoingTaskWithTarget(comp, "LemurRingtailed", {"Eat"}, "ElevatedDish") >= 1.0) then
		return 1
	end
	return 0
end









function completebistromagazine(comp)
	BFLOG(SYSTRACE, "complete bistromagazine");
	
	
	-- Give rewards here
	giveCash(6000);
	
	showchallengewin("BistroMagazinetext:PHBistroMagazineSuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("bistromagazine_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));

end



function failbistromagazine(comp)
	BFLOG(SYSTRACE, "fail bistromagazine");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("bistromagazine_over", "true");
end