-- raffle.lua
-- raffle

include "scenario/scripts/ui.lua";
include "scenario/scripts/economy.lua";


function evalraffle(comp)
-- need at least 50 guests for this to come up
-- deduct $100 for the raffle ticket... 

	BFLOG(SYSTRACE, "evalraffle");
	
	challenge = getglobalvar("challenge")
	
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("raffle");
		end
		
		-- Take away the hundred bucks
		takeCash(100);
		
		local numtickets = countType("Guest") + 10;
		
		local winningticket = math.random(numtickets);
		
		if (winningticket <= 10) then
			BFLOG(SYSTRACE, "WIN!!!!!!!!!!!");
			giveCash(numtickets * 10);
			return 1;
		else
			BFLOG(SYSTRACE, "!!!!!!!!!!!LOSE");
			
			return -1;
		end
		
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		return 1;
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		
		declinenotfail = 1;	
		
		return -1;
	end
	
	if (comp.accept == nil) then
		if (challenge == nil) then			
			showchallengepanel("Challengetext:CHRaffle");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting");
		end
	end




end




function completeraffle(comp)
	-- bye animal, hello cash... 
	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("raffle_over", "true");
	
	showchallengewin("Challengetext:CHRaffleSuccess");

	BFLOG(SYSTRACE, "Accepted animal sale");
end



function failraffle(comp)
-- Take one unhappy guest, or one random guest if none unhappy and make them Very happy!
-- add the amount of cash to them if possible so maybe they spend more money at your zoo 

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("raffle_over", "true");
	
	if (declinenotfail == nil) then
		showchallengefail("Challengetext:CHRaffleFailure");
	end
	
	BFLOG(SYSTRACE, "Declined raffle");


end



