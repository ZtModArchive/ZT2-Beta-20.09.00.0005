-- marketingbrochure.lua
-- Marketing brochure photo challenge


include "scenario/scripts/photoutil.lua";


function evalmarketingbrochure(comp)

	BFLOG(SYSTRACE, "evalmarketingbrochure");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("marketingbrochure");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("Marketing_brochure");
		end
		
		setglobalvar("challenge", nil);
		setglobalvar("challengeactive", "true");
		
		comp.accept = 1;
		showphotogoals();
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		
		-- Return failure
		return -1;
	end
	

	if (comp.accept == nil) then
		if (challenge == nil) then
			local showchallengepanel = showchallengepanel("PhotoChallengetext:PHMarketingBrochure");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting")
		end
	end

	if (comp.accept == 1) then
	
		numPhotoRequirementsMet();
	
		local pm = queryObject("ZTPhotoChallengesComponent");
		local flag = pm:ZT_PHOTOEVENT_GET_CHALLENGES_COMPLETED();
		if (flag) then
			return 1;
		else
			return 0;
		end
	end			
end


function completemarketingbrochure(comp)
	
	setglobalvar("challengeactive", "false");
	setglobalvar("challenge", nil);
	-- If we never want to see this challenge again, need a global variable
	setglobalvar("marketingbrochure_over", "true");
	
	FameGlobals.status.scenarioPoints = FameGlobals.status.scenarioPoints + 2;
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));
	
	showchallengewin("PhotoChallengetext:PHMarketingBrochureSuccess");
	
	BFLOG(SYSTRACE, "Completed marketing brochure challenge");
end

-- this function called by bearbiologistschallenge.xml when bearbiologistschallenge rule is failed
function failmarketingbrochure(comp)
	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	
	-- If we never want to see this challenge again, need a global variable
	setglobalvar("marketingbrochure_over", "true");

	BFLOG(SYSTRACE, "Failed marketing brochure challenge");
end




function takepicofguest(pt)
	return scoreT1ContainsT2(pt, "bench", "Guest")

end

function guestwithsoda(pt)
	return scoreT1ContainsT2(pt, "Guest", "Soda")
end