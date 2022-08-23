-- lua file with functions related to freeform mode
-- primarily for awards


-- Include statements
include "scenario/scripts/misc.lua";
include "scenario/scripts/ui.lua";
include "scenario/scripts/entity.lua";
include "scenario/scripts/economy.lua";
-- include "scenario/scripts/test.lua";


-- use this to monitor zoo. this is called by freeformgoals.xml
function monitorfreeform(comp)

	BFLOG(SYSTRACE, "monitorfreeform");
	
	checkawards(comp);

	return 0;
end


-------temporary test function!------------
function setguests()
	hundredguests = 100
	BFLOG(SYSTRACE, "hundredguests at 100");
end

--- temporarily here (and in ui.lua which is only place it should live) as with
--- scriptcaching it had to be here when testing it by running monitorfreefrom using dev console.
function showawardpanel()
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local awardpanel = uimgr:UI_GET_CHILD("zoo status");
		local gotoawardstab = uimgr:UI_GET_CHILD("awards tab");
		if (gotoawardstab) then
			gotoawardstab:UI_ACTIVATE_OFF();
			gotoawardstab:UI_REPRESS();
			gotoawardstab:UI_ACTIVATE_ON();
		end
	end	
	BFLOG(SYSTRACE, "Show award page");
	showUI("zoo status layout", true);
end


function checkawards(comp)

	-- Anniversary awards
	if (comp.firstanniversary == nil) then
		if (firstanniversary() == true) then
			comp.firstanniversary = 1;
		end
	elseif (comp.fifthanniversary == nil) then
		if (fifthanniversary() == true) then
			comp.fifthanniversary = 1;
		end
	elseif (comp.tenthanniversary == nil) then
		if (tenthanniversary() == true) then
			comp.tenthanniversary = 1;
		end
	elseif (comp.twentiethanniversary == nil) then
		if (twentiethanniversary() == true) then
			comp.twentiethanniversary = 1;
		end
	end
	
	-- Guest population awards
	
	if (comp.hundredguests == nil) then
		if (hundredguests() == true) then
			comp.hundredguests = 1;
		end
	elseif (comp.thousandguests == nil) then
		if (thousandguests() == true) then
			comp.thousandguests = 1;
		end
	elseif (comp.fivethousandguests == nil) then
		if (fivethousandguests() == true) then
			comp.fivethousandguests = 1;
		end
	elseif (comp.tenthousandguests == nil) then
		if (tenthousandguests() == true) then
			comp.tenthousandguests = 1;
		end
	elseif (comp.twentythousandguests == nil) then
		if (twentythousandguests() == true) then
			comp.twentythousandguests = 1;
		end
	end


	-- Total species cash grants
	if (comp.speciesgrantone == nil) then
		if (speciesgrantone() == true) then
			comp.speciesgrantone = 1;
		end
	elseif (comp.speciesgranttwo == nil) then
		if (speciesgranttwo() == true) then
			comp.speciesgranttwo = 1;
		end
	elseif (comp.speciesgrantthree == nil) then
		if (speciesgrantthree() == true) then
			comp.speciesgrantthree = 1;
		end
	elseif (comp.speciesgrantfour == nil) then
		if (speciesgrantfour() == true) then
			comp.speciesgrantfour = 1;
		end
	end
	
	-- Education and entertainment donations
	
	if (comp.entertainmentaward == nil) then
		if (entertainmentaward() == true) then
			comp.entertainmentaward = 1;
		end
	end

	if (comp.educationaward == nil) then
		if (educationaward() == true) then
			comp.educationaward = 1;
		end
	end

end


function firstanniversary()
-- get this once
-- after zoo open one year
-- giveaward("awards/Firstani.xml");
-- get 1 zoo fame point

	local month = getCurrentMonth();
	if (month >= 12) then
		-- If they have gone 12 months
		giveaward("awards/Firstani.xml");
		FameGlobals.status.scenarioPoints = FameGlobals.status.scenarioPoints + 1;
		showawardpanel();
		return true;
	end
	
	return false;
end

function fifthanniversary()
-- get this once
-- giveaward("awards/Fifthani.xml");
-- get 1 zoo fame point

	local month = getCurrentMonth();
	if (month >= 60) then
		-- If they have gone 60 months
		giveaward("awards/Fifthani.xml");
		FameGlobals.status.scenarioPoints = FameGlobals.status.scenarioPoints + 1;
		showawardpanel();
		return true;
	end
	
	return false;
end

function tenthanniversary()
-- get this once
-- giveaward("awards/Tenthani.xml");
-- get 1 zoo fame point()

	local month = getCurrentMonth();
	if (month >= 120) then
		-- If they have gone 120 months
		giveaward("awards/Tenthani.xml");
		FameGlobals.status.scenarioPoints = FameGlobals.status.scenarioPoints + 1;
		showawardpanel();
		return true;
	end
	
	return false;
end

function twentiethanniversary()
-- get this once
-- giveaward("awards/Twentiethani.xml");
-- get 1 zoo fame point

	local month = getCurrentMonth();
	if (month >= 240) then
		-- If they have gone 240 months
		giveaward("awards/Twentiethani.xml");
		FameGlobals.status.scenarioPoints = FameGlobals.status.scenarioPoints + 1;
		showawardpanel();
		return true;
	end
	
	return false;
end

function hundredguests()
-- get this once
-- giveaward("awards/ZooAttendance100.xml");
-- get 1 zoo fame point

	local totalguests = getNumGuests(-1);

	if (totalguests ~= nil) then
		if (totalguests >= 100) then
			giveaward("awards/ZooAttendance100.xml");
			FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
			showawardpanel();
			return true;
		end
	end
	
	return false;
end

function thousandguests()
-- get this once
-- giveaward("awards/ZooAttendance1000.xml");
-- get 1 zoo fame point

	local totalguests = getNumGuests(-1);

	if (totalguests ~= nil) then
		if (totalguests >= 1000) then
			giveaward("awards/ZooAttendance1000.xml");
			FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
			showawardpanel();
			return true;
		end
	end

	return false;
end

function fivethousandguests()
-- get this once
-- award 1 zoo fame point
-- giveaward("awards/ZooAttendance5000.xml");

	local totalguests = getNumGuests(-1);

	if (totalguests ~= nil) then
		if (totalguests >= 5000) then
			giveaward("awards/ZooAttendance5000.xml");
			FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
			showawardpanel();
			return true;
		end
	end

	return false;
end

function tenthousandguests()
-- get this once
-- award 1 zoo fame point
-- giveaward("awards/ZooAttendance10000.xml");
	
	local totalguests = getNumGuests(-1);

	if (totalguests ~= nil) then
		if (totalguests >= 10000) then
			giveaward("awards/ZooAttendance10000.xml");
			FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
			showawardpanel();
			return true;
		end
	end

	return false;
end

function twentythousandguests()
-- get this once
-- award 1 zoo fame point
-- giveaward("awards/ZooAttendance20000.xml");

	local totalguests = getNumGuests(-1);

	if (totalguests ~= nil) then
		if (totalguests >= 20000) then
			giveaward("awards/ZooAttendance20000.xml");
			FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
			showawardpanel();
			return true;
		end
	end

	return false;
end

function habitattrophy()
-- get this once
-- for having a zoo with every biome represented
-- award 1 zoo fame point
-- giveaward("awards/Habitat.xml");
end


function globalaward()
-- get this once
-- for having a zoo with animals from north america, africa, asia, australia, and india 
-- award 1 zoo fame point
-- giveaward("awards/Global.xml");
end

function entertainmentaward()
-- get this once
-- for obtaining $10000 in entertainment donations
-- award 1 zoo fame point
-- giveaward("awards/Entertainment.xml");

	local totaldon = getDonationsAllAnimals();
	
	if (totaldon >= 10000) then
		giveaward("awards/Entertainment.xml");
		FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
		showawardpanel();
		return true;
	end

end

function educationaward()
-- get this once
-- for obtaining $10000 in educational donations
-- award 1 zoo fame point
-- giveaward("awards/Scholars.xml");

	local total = getDonations("Education");
	BFLOG(SYSTRACE, "current education donation total: "..total..".");
	
	if (total >= 10000) then
		giveaward("awards/Scholars.xml");
		FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
		showawardpanel();
		return true;
	end
end

function firstlevelanimalreleased()
-- get this once
-- for the first animal released to the wild
-- giveaward("awards/ConservationEffort.xml");
-- get 1 zoo fame point

	local numreleased = getAnimalsReleased();

	if (numreleased ~= nil) then
		if (numreleased >= 1) then
			giveaward("awards/ConservationEffort.xml");
			FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
			showawardpanel();
			return true;
		end
	end
	
	return false;
end

function secondlevelanimalreleased()
-- get this once
-- for ten animals released to the wild
-- award 1 zoo fame point
-- giveaward("awards/ConservationAchieve.xml");

	local numreleased = getAnimalsReleased();

	if (numreleased ~= nil) then
		if (numreleased >= 10) then
			giveaward("awards/ConservationAchieve.xml");
			FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
			showawardpanel();
			return true;
		end
	end
	
	return false;
end

function thirdlevelanimalreleased()
-- get this once
-- for twentyfive animals released to the wild
-- award 1 zoo fame point
-- giveaward("awards/ConservationExel.xml");

	local numreleased = getAnimalsReleased();

	if (numreleased ~= nil) then
		if (numreleased >= 25) then
			giveaward("awards/ConservationExel.xml");
			FameGlobals.status.awardPoints = FameGlobals.status.awardPoints + 1;
			showawardpanel();
			return true;
		end
	end

	return false;
end


function animalbirthcertificate()
-- for births of any endangered animals
-- rhino, chimp, gorilla, elephant, okapi, snow leopard, giant panda, red panda
-- can get this multiple times but
-- the first time you get this award, give 1 zoo fame point
-- giveaward("awards/AnimalBirth.xml");
end



--------Money grants------------


-- for each of the following money grants, display the grant panel with the 
-- locid moneygrants:speciesgrant (same locid for all)

function speciesgrantone()
-- give player $1000 when 5 different species in zoo

	local numinzoo = howManyAnimalsInZoo();

	if (numinzoo ~= nil) then
		if (numinzoo >= 5) then
			giveCash(1000);
			showgivecash("moneygrants:speciesgrant", 1000);
			return true;
		end
	end

	return false;
end


function speciesgranttwo()
-- give player $5000 when 12 different species in zoo

	local numinzoo = howManyAnimalsInZoo();

	if (numinzoo ~= nil) then
		if (numinzoo >= 12) then
			giveCash(5000);
			showgivecash("moneygrants:speciesgrant", 5000);
			return true;
		end
	end

	return false;

end



function speciesgrantthree()
-- give player $20000 when 18 different species in zoo
	
	local numinzoo = howManyAnimalsInZoo();

	if (numinzoo ~= nil) then
		if (numinzoo >= 18) then
			giveCash(20000);
			showgivecash("moneygrants:speciesgrant", 20000);
			return true;
		end
	end

	return false;
end


function speciesgrantfour()
-- give player $50000 when 30 different species in zoo
	local numinzoo = howManyAnimalsInZoo();

	if (numinzoo ~= nil) then
		if (numinzoo >= 30) then
			giveCash(50000);
			showgivecash("moneygrants:speciesgrant", 50000);
			return true;
		end
	end

	return false;
end