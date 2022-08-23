-- randomanimalchance.lua
-- random tier 1 or 2 animal

include "scenario/scripts/ui.lua";
include "scenario/scripts/entity.lua";


function evalrandomanimalchance(comp)
-- basic (tier 1) and medium (tier 2) animals unlocked

-- player pays $1200 and gets a random animal (crated near front gate)
-- ** it would be good if we could calculate off animal prices just in case animal prices 
-- change - it's the average cost of all animals in tier 1 and 2... doable?
-- from tier 1 or 2
-- must meet animals environment need for the challenge to be "over"

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
			local showchallengepanel = showchallengepanel("Challengetext:CHRandomAnimalChance");
			
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!");
			setglobalvar("challenge", "waiting");
		end
	end

end




function completerandomanimalchance(comp)
-- there are 2 "success" locids for the goal overview panel
-- <CHRandomAnimalChanceGreatSuccess> if the animal's value exceeds $1400
-- <CHRandomAnimalChanceSuccess> if the animal's value is less than $1400

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
	
	local whatanimal = masteranimal[math.random(table.getn(masteranimallist))];
	
	randomanimal_type = whatanimal = whatanimal + "_Adult_M";
			
	BFLOG(SYSTRACE, "type: "..randomanimal_type..".");
	
	-- Now take the money and give them their animal
	takeCash(1400);
	placeObject(randomanimal_type, 50, 10, 0);
	

	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("randomanimalchange_over", "true");
	
	showchallengewin("Challengetext:CHRandomAnimalChanceGreatSuccess");
end



function failrandomanimalchance(comp)
	BFLOG(SYSTRACE, "Failed randomanimalchange");
	
	setglobalvar("challenge", nil)
	setglobalvar("challengeactive", "false");
	setglobalvar("randomanimalchance_over", "true");
end