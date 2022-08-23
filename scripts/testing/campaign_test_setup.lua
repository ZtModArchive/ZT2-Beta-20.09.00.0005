-- by rgb

-- Includes:

include "scenario/scripts/entity.lua"
include "scenario/scripts/misc.lua"
include "scripts/testing/bfg_animal_needs.lua"


-- test 1: Lemur Grooming another
function setupLemurGroom()

	LUALOG(SYSINFO, "Placing animal...")
	placeObject("LemurRingtailed_Adult_M", 75, 65, 0)
	placeObject("LemurRingtailed_Adult_F", 75, 65, 0)
	
	LUALOG(SYSINFO, "Placing food...")
	placeObject("FoodDish_Branches", 80, 70, 0)
	placeObject("FoodDish_Water", 70, 60, 0)
	
	LUALOG(SYSINFO, "Placing enrichment...")
	placeObject("RattleBall", 70, 65, 0)
	placeObject("IceBlock_Apples", 80, 65, 0)

	LUALOG(SYSINFO, "Setting needs for test...")	
	setAnimalNeed("LemurRingtailed", "social", 89.0)
	setAnimalNeed("LemurRingtailed", "hygiene", 89.0)
	setAnimalNeed("LemurRingtailed", "stimulation", 45.0)
		
end


-- Prevent Animal Abuse Campaign
function setupPreventAnimalAbuse(part)

	local part = args[1].value

end


-- using Scenario name as function name to help make it clear
function setupCruelAndInhumaneConditions(args)

	local part = args[1].value
	
	if part == "1" then
		LUALOG(SYSERROR, "Setting up part 1")
		zeroNeeds("Lion")
		zeroNeeds("ZebraCommon")
	end
	
	if part == "2" then
		zeroNeeds("Chimpanzee")
	end

end


-- Prevent Animal Abuse Campaign
function setupSmugglingRingExposed(args)

	LUALOG(SYSINFO, "Campaign: Prevent Animal Abuse")

	local part = args[1].value

	if part == "1" then
	
		LUALOG(SYSINFO, "Setting up part one...")
		zeroNeeds("Kangaroo")
		
	end
	
	if part == "2" then
		
		LUALOG(SYSINFO, "setting up part two...")
		zeroNeeds("Kangaroo")
		zeroNeeds("TigerBengal")
		
	end

	if part == "3" then
	
		LUALOG(SYSINFO, "Setting up part three...")
		zeroNeeds("Kangaroo")
		zeroNeeds("TigerBengal")
		zeroNeeds("BearGrizzly")
	
	end

	if part == "4" then
	
		LUALOG(SYSINFO, "Setting up part three...")
		zeroNeeds("Kangaroo")
		zeroNeeds("TigerBengal")
		zeroNeeds("BearGrizzly")
		zeroNeeds("GorillaMountain")
	
	end

	if part == "5" then
	
		LUALOG(SYSINFO, "Setting up part three...")
		zeroNeeds("Kangaroo")
		zeroNeeds("TigerBengal")
		zeroNeeds("BearGrizzly")
		zeroNeeds("GorillaMountain")
		zeroNeeds("RhinocerosBlack")
	
	end

	if part == "6" then
	
		LUALOG(SYSINFO, "Setting up part three...")
		zeroNeeds("Kangaroo")
		zeroNeeds("TigerBengal")
		zeroNeeds("BearGrizzly")
		zeroNeeds("GorillaMountain")
		zeroNeeds("RhinocerosBlack")
		zeroNeeds("ElephantAfrican")
	
	end

	if part == "7" then
	
		LUALOG(SYSINFO, "Setting up part three...")
		zeroNeeds("Kangaroo")
		zeroNeeds("TigerBengal")
		zeroNeeds("BearGrizzly")
		zeroNeeds("GorillaMountain")
		zeroNeeds("RhinocerosBlack")
		zeroNeeds("ElephantAfrican")
		zeroNeeds("LeopardSnow")
	
	end

end

-- don't run this... won't work
-- The Mysterious Panda Campaign
function setupTheMysteriousPanda(args)

	local part = args[1].value

	if part == "0" then

		LUALOG(SYSINFO, "Placing animal...")
		placeObject("LemurRingtailed_Adult_M", 75, 65, 0)
		placeObject("LemurRingtailed_Adult_F", 75, 65, 0)
		
		placeObject("Cheetah_Adult_M", 75, 65, 0)
		placeObject("Cheetah_Adult_F", 75, 65, 0)

		placeObject("Giraffe_Adult_M", 75, 65, 0)
		placeObject("Giraffe_Adult_F", 75, 65, 0)

		placeObject("BearGrizzly_Adult_M", 75, 65, 0)
		placeObject("BearGrizzly_Adult_F", 75, 65, 0)

		placeObject("ElephantAfrican_Adult_M", 75, 65, 0)
		placeObject("ElephantAfrican_Adult_F", 75, 65, 0)
		
		-- while we're not yet at five stars, keep animals happy
		local zooFame = getZooFame()
		while zooFame < 100 do

			zeroNeeds("LemurRingtailed")
			zeroNeeds("Cheetah")
			zeroNeeds("Giraffe")
			zeroNeeds("BearGrizzly")
			zeroNeeds("ElephantAfrican")

			local zooFame = getZooFame()

		end

	end

end

-- Conservation Programs Campaign
function setupAnimalAdoptionProgram(args)

	local part = args[1].value
	
	if part == "1" then
	
		zeroNeeds("Hippopotamus")
		zeroNeeds("Cheetah")
		zeroNeeds("Ibex")
		zeroNeeds("BeaverAmerican")

		LUALOG(SYSINFO, "Setting needs for test...")
		
		placeObject("Hippopotamus_Adult_M", 75, 65, 0)
		placeObject("Hippopotamus_Adult_F", 75, 65, 0)
		placeObject("Hippopotamus_Adult_M", 75, 65, 0)
		placeObject("Hippopotamus_Adult_F", 75, 65, 0)
		placeObject("Hippopotamus_Adult_M", 75, 65, 0)
		placeObject("Hippopotamus_Adult_F", 75, 65, 0)			
			
		setAnimalNeed("Hippopotamus", "reproduction", 89.0)
		setAnimalNeed("Hippopotamus", "rest", 10.0)
		setNeedPointsGood("Hippopotamus", 50.0)

		setAnimalNeed("Cheetah", "reproduction", 89.0)
		setAnimalNeed("Cheetah", "rest", 10.0)
		setNeedPointsGood("Cheetah", 50.0)
		
		setAnimalNeed("Ibex", "reproduction", 89.0)
		setAnimalNeed("Ibex", "rest", 10.0)
		setNeedPointsGood("Ibex", 50.0)		
	
		setAnimalNeed("BeaverAmerican", "reproduction", 89.0)
		setAnimalNeed("BeaverAmerican", "rest", 10.0)
		setNeedPointsGood("BeaverAmerican", 50.0)		

	end


end

-- Conservation Programs Campaign
function setupAnimalConservation(args)

	local part = args[1].value
	
	if part == "1" then

		zeroNeeds("GorillaMountain")
		zeroNeeds("PandaRed")
		zeroNeeds("LeopardSnow")

		setAnimalNeed("GorillaMountain", "reproduction", 89.0)
		setAnimalNeed("GorillaMountain", "rest", 10.0)
		setAnimalNeed("GorillaMountain", "social", 50.0)		
		setNeedPointsGood("GorillaMountain", 50.0)

		setAnimalNeed("PandaRed", "reproduction", 89.0)
		setAnimalNeed("PandaRed", "rest", 10.0)
		setAnimalNeed("GorillaMountain", "social", 50.0)		
		setNeedPointsGood("PandaRed", 50.0)
		
		setAnimalNeed("LeopardSnow", "reproduction", 89.0)
		setAnimalNeed("LeopardSnow", "rest", 10.0)
		setAnimalNeed("GorillaMountain", "social", 50.0)		
		setNeedPointsGood("LeopardSnow", 50.0)

	end


end

-- Conservation Programs Campaign
function setupSecondGenerationAnimals(args)

	local part = args[1].value

end

-- Troubled Zoos Campaign
function setupWAPRedevelopment(args)

	local part = args[1].value

	if part == "1" then
	
		zeroNeeds("TigerBengal")
		zeroNeeds("ElephantAfrican")
		zeroNeeds("ZebraCommon")
	
	end

end

function setupRaintreeCooperative(args)

	local part = args[1].value

	if part == "1" then
	
	end

end

function setupWolvertonAnimalCenter(args)

	local part = args[1].value

	if part == "1" then
	
	end

end

-- The Globe
function setupNorthAmericanContent(args)

	local part = args[1].value

	if part == "1" then

		--placeObject("Lion_Adult_M", 75, 65, 0)
		placeObject("Lion_Adult_F", 75, 65, 0)
		--placeObject("ElephantAfrican_Adult_M", 75, 65, 0)
		placeObject("ElephantAfrican_Adult_F", 75, 65, 0)
		--placeObject("PandaRed_Adult_M", 75, 65, 0)
		placeObject("PandaRed_Adult_F", 75, 65, 0)			
		--placeObject("PandaGiant_Adult_M", 75, 65, 0)
		placeObject("PandaGiant_Adult_F", 75, 65, 0)
		--placeObject("ZebraCommon_Adult_M", 75, 65, 0)
		placeObject("ZebraCommon_Adult_F", 75, 65, 0)
		--placeObject("Cheetah_Adult_M", 75, 65, 0)
		placeObject("Cheetah_Adult_F", 75, 65, 0)
		--placeObject("CamelDromedary_Adult_M", 75, 65, 0)
		placeObject("CamelDromedary_Adult_F", 75, 65, 0)			
		--placeObject("GazelleThompsons_Adult_M", 75, 65, 0)
		placeObject("GazelleThomsons_Adult_F", 75, 65, 0)

		--placeObject("BeaverAmerican_Adult_M", 75, 65, 0)
		placeObject("BeaverAmerican_Adult_F", 75, 65, 0)
		--placeObject("BearGrizzly_Adult_M", 75, 65, 0)
		placeObject("BearGrizzly_Adult_F", 75, 65, 0)
		--placeObject("BearPolar_Adult_M", 75, 65, 0)
		placeObject("BearPolar_Adult_F", 75, 65, 0)			
		
		zeroNeeds("Lion")
		zeroNeeds("ElephantAfrican")
		zeroNeeds("PandaRed")
		zeroNeeds("PandaGiant")	
		zeroNeeds("ZebraCommon")	
		zeroNeeds("Cheetah")
		zeroNeeds("CamelDromedary")
		zeroNeeds("GazelleThomsons")		
		zeroNeeds("BeaverAmerican")
		zeroNeeds("BearGrizzly")	
		zeroNeeds("BearPolar")
					
	end

	-- just fullfill the needs
	if part == "1b" then
	
		zeroNeeds("Lion")
		zeroNeeds("ElephantAfrican")
		zeroNeeds("PandaRed")
		zeroNeeds("PandaGiant")	
		zeroNeeds("ZebraCommon")	
		zeroNeeds("Cheetah")
		zeroNeeds("CamelDromedary")
		zeroNeeds("GazelleThompsons")		
		zeroNeeds("BeaverAmerican")
		zeroNeeds("BearGrizzly")	
		zeroNeeds("BearPolar")	
	
	end

end

function setupScarceAsian(args)

	local part = args[1].value

	if part == "1" then

		placeObject("PandaRed_Adult_F", 75, 65, 0)	
		placeObject("PandaGiant_Adult_F", 75, 65, 0)		
		placeObject("TigerBengal_Adult_F", 75, 65, 0)
		
		zeroNeeds("PandaRed")
		zeroNeeds("PandaGiant")	
		zeroNeeds("TigerBengal")	
				
	end

end

function setupAfricanEmpire(args)

	local part = args[1].value

	if part == "1" then

		-- CamelDromedary
		-- Chimpanzee
		-- Okapi
		-- GorillaMountain
		-- Lion
		-- Cheetah
		-- Giraffe
		-- ElephantAfrican
		-- GazelleThomsons
		-- ZebraCommon
		-- RhinocerosBlack
		-- Ostrich
		-- Gemsbok
		-- FlamingoGreater
		-- Hippopotamus

		placeObject("Lion_Adult_F", 75, 65, 0)
		placeObject("ElephantAfrican_Adult_F", 75, 65, 0)
		placeObject("Okapi_Adult_F", 75, 65, 0)			
		placeObject("Chimpanzee_Adult_F", 75, 65, 0)
		placeObject("ZebraCommon_Adult_F", 75, 65, 0)
		placeObject("Cheetah_Adult_F", 75, 65, 0)
		placeObject("CamelDromedary_Adult_F", 75, 65, 0)			
		placeObject("GazelleThomsons_Adult_F", 75, 65, 0)
		placeObject("RhinocerosBlack_Adult_F", 75, 65, 0)
		placeObject("Ostrich_Adult_F", 75, 65, 0)
		placeObject("Gemsbok_Adult_F", 75, 65, 0)	
		placeObject("GorillaMountain_Adult_F", 75, 65, 0)					
		
		zeroNeeds("Lion")
		zeroNeeds("ElephantAfrican")
		zeroNeeds("Okapi")
		zeroNeeds("Chimpanzee")	
		zeroNeeds("ZebraCommon")	
		zeroNeeds("Cheetah")
		zeroNeeds("CamelDromedary")
		zeroNeeds("GazelleThomsons")		
		zeroNeeds("RhinocerosBlack")
		zeroNeeds("Ostrich")	
		zeroNeeds("Gemsbok")
		zeroNeeds("GorillaMountain")			
				
	end

end

function setupCompleteEcosystem(args)

	local part = args[1].value

	if part == "1" then

		placeObject("Lion_Adult_F", 75, 65, 0)
		placeObject("ElephantAfrican_Adult_F", 75, 65, 0)
		placeObject("Okapi_Adult_F", 75, 65, 0)			
		placeObject("ZebraCommon_Adult_F", 75, 65, 0)
		placeObject("Cheetah_Adult_F", 75, 65, 0)
		placeObject("CamelDromedary_Adult_F", 75, 65, 0)			
		placeObject("GazelleThomsons_Adult_F", 75, 65, 0)
		placeObject("RhinocerosBlack_Adult_F", 75, 65, 0)
		placeObject("Gemsbok_Adult_F", 75, 65, 0)	
			
		
		zeroNeeds("Lion")
		zeroNeeds("ElephantAfrican")
		zeroNeeds("Okapi")
		zeroNeeds("Chimpanzee")	
		zeroNeeds("ZebraCommon")	
		zeroNeeds("Cheetah")
		zeroNeeds("CamelDromedary")
		zeroNeeds("GazelleThomsons")		
		zeroNeeds("RhinocerosBlack")
		zeroNeeds("Ostrich")	
		zeroNeeds("Gemsbok")
		zeroNeeds("GorillaMountain")
	
	end

end