-- Photo Challenge Testing (pchal_test_setup.lua)
-- This script will help setting up of the photo challenge tests.  At this point it needs some manual testing.
--
-- Challenge:	Animal Instincts
-- Save:		sngl_encl.zt2
--
-- 
-- by rgb

-- Includes:

include "scenario/scripts/entity.lua"
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

-- test 2: Lion Pride resting in the shade
function setupLionPride()

	LUALOG(SYSINFO, "Placing animal...")
	placeObject("Lion_Adult_M", 75, 65, 0)
	placeObject("Lion_Adult_F", 75, 65, 0)
	placeObject("Lion_Adult_F", 75, 65, 0)
	placeObject("Lion_Young_M", 75, 65, 0)
	
	LUALOG(SYSINFO, "Placing food...")
	placeObject("MetalTrough_Meat", 80, 70, 0)
	placeObject("MetalTrough_Water", 70, 60, 0)
	
	LUALOG(SYSINFO, "Placing enrichment...")
	placeObject("RattleBall", 70, 65, 0)
	
	-- setting animals needs, but basing them on default values when they are placed.
	LUALOG(SYSINFO, "Setting needs for test...")	
	setAnimalNeed("Lion", "rest", 89.0)
	setAnimalNeed("Lion", "exercise", 0.0)
	setAnimalNeed("Lion", "privacy", 89.0)
		
end

-- test 3: Ostrich Mating dance
function setupOstrichDance()

	LUALOG(SYSINFO, "Placing animal...")
	placeObject("Ostrich_Adult_M", 75, 65, 0)
	placeObject("Ostrich_Adult_F", 75, 65, 0)

	
	LUALOG(SYSINFO, "Placing food...")
	placeObject("FoodDish_Grass", 80, 70, 0)
	placeObject("FoodDish_Water", 70, 60, 0)
	
	LUALOG(SYSINFO, "Placing enrichment...")
	placeObject("RattleBall", 70, 65, 0)
	placeObject("Ball", 65, 70, 0)
	
	-- setting animals needs, but basing them on default values when they are placed.
	LUALOG(SYSINFO, "Setting needs for test...")

	setNeedPointsGood("Ostrich", 55.0)
		
	setAnimalNeed("Ostrich", "rest", 40.0)
	setAnimalNeed("Ostrich", "reproduction", 89.0)
		
end

-- test 4: Giraffe calls to it's mother
function setupGiraffeCall()

	LUALOG(SYSINFO, "Placing animal...")
	placeObject("Giraffe_Adult_F", 75, 65, 0)
	placeObject("Giraffe_Adult_M", 75, 65, 0)

	
	LUALOG(SYSINFO, "Placing food...")
	placeObject("Trough_Branches", 80, 70, 0)
	placeObject("Trough_Water", 70, 60, 0)
	
	LUALOG(SYSINFO, "Placing enrichment...")
	placeObject("Apple", 70, 65, 0)
	
	-- setting animals needs, but basing them on default values when they are placed.
	LUALOG(SYSINFO, "Setting needs for test...")
	setNeedPointsGood("Giraffe", 50.0)
	
	-- All we can do is promote some reproduction and hope it will take.
	setAnimalNeed("Giraffe", "social", 50.0)
	setAnimalNeed("Giraffe", "reproduction", 89.0)
	setAnimalNeed("Giraffe", "rest", 50.0)
		
end