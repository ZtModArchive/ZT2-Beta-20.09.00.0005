-- giverandomanimal.lua
-- Functions for the random animal "challenge"

-- this function called by giverandomanimal.xml
function evalgiverandomanimal(comp)
	BFLOG(SYSTRACE, "evalbearbiologist");
	
	challenge = getglobalvar("challenge");
	
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!");
		
		return 1;
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		
		-- Return failure
		return -1;
	end
	
	if (comp.accept == nil) then
		if (challenge == nil) then
			-- Figure out here exactly what we are going to be giving them
			randomanimal_howmany = 1;
			
			local whatanimal = math.random(5);
			if (whatanimal == 1) then
				randomanimal_type = "ElephantAfrican_Adult_F";
			elseif (whatanimal == 2) then
				randomanimal_type = "TigerBengal_Adult_F";
			elseif (whatanimal == 3) then
				randomanimal_type = "GazelleThomsons_Adult_F";
			elseif (whatanimal == 4) then
				randomanimal_type = "Gemsbok_Adult_F";
			else
				randomanimal_type = "CamelDromedary_Adult_F";
			end
				
			
			randomanimal_cost = math.random(5000);
			
			BFLOG(SYSTRACE, "howmany: "..randomanimal_howmany.."  type: "..randomanimal_type.."  cost: "..randomanimal_cost..".");
		
			-- If they don't have enough cash to accept the challenge
			-- Then disable the accept button
			local cashlevel = howMuchCash();
			if (cashlevel < randomanimal_cost) then
				local mgr = queryObject("UIRoot");
				if (mgr) then
					local ui = mgr:UI_GET_CHILD("challenge layout");
					if (ui) then
						local acceptbutton = ui:UI_GET_CHILD("accept");
						if (acceptbutton) then
							acceptbutton:UI_HIDE();
						else
							BFLOG(SYSTRACE, "Failed to get accept button UI");
						end
					else
						BFLOG(SYSTRACE, "Couldn't open Scenario Fail Layout");
					end
				end
			end
		
			-- Now show the panel
			local showchallengepanel = showchallengepanel("Challengetext:GenericRandomAnimal");
			
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!");
			setglobalvar("challenge", "waiting");
		end
	end
end


-- This function is called if they decide to take the animals
function completegiverandomanimal(comp)	
	BFLOG(SYSTRACE, "Accepted random animals");
	
	takeCash(randomanimal_cost);	
	placeObject(randomanimal_type, 10, 10, 0);	
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
end

-- Called when they decide to turn down the animals
function failgiverandomanimal(comp)
	
	BFLOG(SYSTRACE, "Declined randomanimal");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
end