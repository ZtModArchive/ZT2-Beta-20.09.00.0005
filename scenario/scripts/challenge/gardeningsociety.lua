-- gardeningsociety.lua
-- gardening society photo challenge
 
include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalgardeningsociety(comp)

	BFLOG(SYSTRACE, "evalgardeningsociety");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("gardeningsocietyphoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("GardeningSociety");
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
			local showchallengepanel = showchallengepanel("GardeningSocietytext:PHGardeningSociety");
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



function scoreBaobob(comp)
	return scoreT1(comp, "Baobob_Savannah")
end


function scoreKapok(comp)
	return scoreT1(comp, "Kapok_Rainforest")
end

function scoreTamarack(comp)
	return scoreT1(comp, "Tamarack_Boreal")
end

function scoreHimalayanPine(comp)
	return scoreT1(comp, "HimalayanPine_Alpine")
end








function completegardeningsociety(comp)
	BFLOG(SYSTRACE, "complete gardeningsociety");
	
	
	-- Give rewards here
	giveCash(3000);
	giveGuest(6);
	
	
	showchallengewin("GardeningSocietytext:PHGardeningSocietySuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("gardeningsociety_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));

end


function failgardeningsociety(comp)
	BFLOG(SYSTRACE, "fail gardeningsociety");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("gardeningsociety_over", "true");
end
