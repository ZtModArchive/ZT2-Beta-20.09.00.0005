-- randomanimalchance2.lua
-- random tier 3 or 4 animal
include "scenario/scripts/ui.lua";






function evalrandomanimalchance2(comp)
-- advanced (tier 3) animals unlocked... will be a real bonus if you get a panda!

-- player pays $3300 and gets a random animal (crated near front gate)
-- ** it would be good if we could calculate this from animal prices just in case animal prices 
-- change - it's the average cost of all animals in tier 3 and 4... doable?
-- from tier 3 or 4


	BFLOG(SYSTRACE, "evalrandomanimal");
	
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
			-- Now show the panel
			local showchallengepanel = showchallengepanel("Challengetext:CHRandomAnimalChance2");
			
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!");
			setglobalvar("challenge", "waiting");
		end
	end


end




function completerandomanimalchance2(comp)
-- there are 2 "success" locids for the goal overview panel
-- <CHRandomAnimalChance2GreatSuccess> if the animal's value exceeds $4800
-- <CHRandomAnimalChance2Success> if the animal's value is less than $4800

	-- Create a master list of all animals
	local masteranimallist = { };
	
	masteranimallist[1] = "GazelleThomsons";
	masteranimallist[2] = "ZebraCommon"; 
	masteranimallist[3] = "Kangaroo";
	masteranimallist[4] = "CamelDromedary";
	masteranimallist[5] = "Moose";
	masteranimallist[6] = "Gemsbok";
	masteranimallist[7] = "PeafowlCommon";
	masteranimallist[8] = "FlamingoGreater";
	masteranimallist[9] = "CrocodileNile";
	masteranimallist[10] = "Ostrich";
	masteranimallist[11] = "TigerBengal";
	masteranimallist[12] = "Jaguar";
	masteranimallist[13] = "LemurRingtailed";
	masteranimallist[14] = "Giraffe";
	masteranimallist[15] = "Cheetah";
	masteranimallist[16] = "Hippopotamus";
	masteranimallist[17] = "Ibex";
	masteranimallist[18] = "PenguinEmperor";
	masteranimallist[19] = "Lion";
	masteranimallist[20] = "RhinocerosBlack";
	masteranimallist[21] = "Chimpanzee";
	masteranimallist[22] = "GorillaMountain";
	masteranimallist[23] = "BearPolar";
	masteranimallist[24] = "ElephantAfrican";
	masteranimallist[25] = "BearGrizzly";
	masteranimallist[26] = "BeaverAmerican";
	masteranimallist[27] = "Okapi";
	masteranimallist[28] = "PandaGiant";
	masteranimallist[29] = "PandaRed";
	masteranimallist[30] = "LeopardSnow";
	
	local whatanimal = masteranimal[math.random(table.getn(masteranimallist))];
	
	randomanimal_type = whatanimal = whatanimal + "_Adult_M";
	
	
	BFLOG(SYSTRACE, "type: "..randomanimal_type..".");
	
	-- Now take the money and give them their animal
	takeCash(3300);
	placeObject(randomanimal_type, 40, 10, 0);
	

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("randomanimalchance2_over", "true");
	
	showchallengewin("Challengetext:CHRandomAnimalChance2GreatSuccess");

end


function failrandomanimalchance2(comp)
	BFLOG(SYSTRACE, "Failed randomanimalchange");
	
	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("randomanimalchance2_over", "true");
end
