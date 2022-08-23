-- zoodesign.lua
-- zoodesign photo challenge

include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalzoodesign(comp)

	BFLOG(SYSTRACE, "evalzoodesign");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("zoodesignphoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("ZooDesignMonthly");
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
			local showchallengepanel = showchallengepanel("ZooDesigntext:PHZooDesign");
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



function scoreFamilyRestroom(comp)
	return scoreT1(comp, "bathroomlarge")
end

function scoreGiftShop(comp)
	return scoreT1(comp, "giftshop_df")
end

function scoreAnimalPhotoBooth(comp)
	return scoreT1(comp, "animalphotobooth_df")
end

function scoreAnyFoodStand(comp)
	return scoreT1(comp, "foodstand")
end








function completezoodesign(comp)
	BFLOG(SYSTRACE, "complete zoodesign");
	
	
	-- Give rewards here
	
	
	showchallengewin("ZooDesigntext:PHZooDesignSuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("zoodesign_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));

end


function failzoodesign(comp)
	BFLOG(SYSTRACE, "fail zoodesign");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("zoodesign_over", "true");
end
