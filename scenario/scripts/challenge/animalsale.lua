-- animalsale.lua
-- animalsale
include "scenario/scripts/ui.lua";






function evalanimalsale(comp)

-- must have at least 5 animals to qualify
-- an animal is randomly chosen from players animals
-- dollar offer is random.. it is no less than 80% less than purchase price
-- and no higher than 40% over purchase price


	BFLOG(SYSTRACE, "evalanimalsale");
	
	challenge = getglobalvar("challenge")
	
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("animalsale");
		end
		
		setglobalvar("challenge", nil)
		setglobalvar("challengeactive", "true");
		
		deleteEntity(comp.theanimal);
		giveCash(comp.theprice);
		
		return 1;
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		
		return -1;
	end
	
	if (comp.accept == nil) then
		if (challenge == nil) then
		
			-- Decide which one of their animals will be up for sale
			local objects = findType("animal");

			if (objects == nil) then
				BFLOG(SYSTRACE, "NO ANIMALS");
				return -1;
			end

			local num = 0;
			num = table.getn(objects);
			
			-- Get the index of the animal we will offer to buy
			local whatanimal = math.random(num);
			
			comp.theanimal = resolveTable(objects[whatanimal].value);
			comp.theprice = math.random(5000);
			
			local animalname = comp.theanimal:BFG_GET_ATTR_STRING("s_name");
			BFLOG(SYSTRACE, "Animal name: "..animalname.."    Animal price: "..comp.theprice..".");
			
			
			local stringdat = getLocID("Challengetext:CHAnimalSale");
			local showme = string.format(stringdat, comp.theanimal, comp.theprice);
			
			showchallengepaneltext(showme);
			
			--showchallengepanel("Challengetext:CHAnimalSale");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!")
			setglobalvar("challenge", "waiting");
		end
	end
end




function completeanimalsale(comp)
	-- bye animal, hello cash... 
	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("animalsale_over", "true");
	
	showchallengewin("Challengetext:CHAnimalSaleSuccess");
	
	BFLOG(SYSTRACE, "Animal price: "..comp.theprice..".");
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));

	BFLOG(SYSTRACE, "Accepted animal sale");

end


function failanimalsale(comp)

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("animalsale_over", "true");
	
	BFLOG(SYSTRACE, "Declined animal sale");
end