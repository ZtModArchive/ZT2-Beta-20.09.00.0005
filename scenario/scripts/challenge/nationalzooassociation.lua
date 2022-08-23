-- nationalzooassociation.lua
-- national zoo association photo challenge
 
include "scenario/scripts/ui.lua";
include "scenario/scripts/photoutil.lua";


function evalnationalzooassociation(comp)
	BFLOG(SYSTRACE, "evalnationalzooassociation");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");	
		if (mgr) then
			mgr:BFS_SHOWRULE("nationalzooassociationphoto");
		end
		
		-- define the photochallege
		local pcmgr = queryObject("ZTPhotoChallengesComponent");
		if (pcmgr) then
			pcmgr:ZT_PHOTOEVENT_SET_CURRENT_CHALLENGE("ZooAssociation");
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
			local showchallengepanel = showchallengepanel("ZooAssociationtext:PHZooAssociation");
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



function scoreAnyBabyAnimal(comp)
	local e = comp:getFirstInterestingEntity()
	while e do
		if (e:isKindOf("animal")) then
			-- not b_Adult, so a young
			BFLOG(SYSNOTE, "got an animal")
			if (e:getSharedVar("b_Adult") == "0") then
				BFLOG(SYSNOTE, "it was not an adult")
				local pac = e:getPAC()
				if (pac) then
					BFLOG(SYSNOTE, "it has a PAC")
					-- has mother relation means was born in zoo
					if (pac:hasRelationship("mother") == true) then
						return 1
					end
				end
			end
		end
		e = comp:getNextInterestingEntity()
	end
	return 0
end


function scoreAnyBabyAnimalwithMother(comp)
	local e = comp:getFirstInterestingEntity()
	while e do
		if (e:isKindOf("animal")) then
			BFLOG(SYSNOTE, "got an animal")
			-- not b_Adult, so a young
			if (e:getSharedVar("b_Adult") == "0") then
				BFLOG(SYSNOTE, "it was not an adult")
				local pac = e:getPAC()
				if (pac) then
					BFLOG(SYSNOTE, "it has a PAC")
					local myID = pac:getID()
					BFLOG(SYSNOTE, "its id is "..myID)
					
					local m = comp:getFirstInterestingEntity2()
					while m do
						local motherPAC = m:getPAC()
						if (motherPAC) then
							BFLOG(SYSNOTE, "potential mother has a PAC")
							local motherID = motherPAC:getID()
							BFLOG(SYSNOTE, "its id is "..motherID)
							local relationshipQueryData = { _type = "ZTRelationshipQueryData", relation = "mother", id = motherID }
							if (pac:testRelationship(relationshipQueryData)) then
								return 1
							end
						end
						m = comp:getNextInterestingEntity2()
					end
				end
			end
		end
		e = comp:getNextInterestingEntity()
	end
	return 0
end

function scoreTwoZebrasGrooming(comp)
	if (numEntitiesDoingAnim(comp, "ZebraCommon", "Stand_GroomOther") >= 1) then
		return 1
	end
	return 0
end

function scoreAnimalUsingEnrichment(comp)
	if (scoreAnyEntityTypeDoingTarget(comp, "animal", "enrichment") >= 1.0) then
		return 1
	end
	return 0
end








function completenationalzooassociation(comp)
	BFLOG(SYSTRACE, "complete nationalzooassociation");
	
	
	-- Give rewards here
	giveCash(25000);
	
	showchallengewin("ZooAssociationtext:PHZooAssociationSuccess");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("nationalzooassociation_over", "true");
	
	-- Increment the number of photo challenges completed
	local num = getglobalvar("numphotocomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of photo challenges complete to: "..newnum..".");
	setglobalvar("numphotocomplete", tostring(newnum));

end


function failnationalzooassociation(comp)
	BFLOG(SYSTRACE, "fail nationalzooassociation");
	
	setglobalvar("challenge", nil);
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("nationalzooassociation_over", "true");
end
