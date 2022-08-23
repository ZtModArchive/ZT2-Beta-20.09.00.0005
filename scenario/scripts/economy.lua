-- economy.lua

-- HEADERS

-- Gets the income for the passed in month.  If the month hasn't happened yet it will return nil
-- Pass in -1 to get the income for the current month
-- function getIncome(month)

-- Gets the profit for the passed in month.  If the month hasn't happened yet it will return nil
-- Pass in -1 to get the profit for the current month
-- function getProfit(month)

-- Gives the player the amount of cash passed in
-- function giveCash(cash)

-- Takes from the player the amount of cash passed in
-- function takeCash(cash)

-- Sets how much cash the player currently has
-- function setCash(cash)

-- Returns how much cash the player currently has
-- function howMuchCash()

-- Pass in a type ("adult_admission", "child_admission", or "group_admission" for now)
-- Will return the price of admission for the specified type
-- function getAdmissionPrice(type)

-- Pass in an admission type ("adult_admission", "child_admission", or "group_admission" for now)
-- and a cost.  Will set the specified type to the cost.
-- function setAdmissionPrice(type, price)

-- Gets donations by type
-- function getDonations(animalType)

-- Gets donation total for all animal species
-- function getDonationsAllAnimals()

include "scenario/scripts/ui.lua";
include "scenario/scripts/misc.lua";
include "scenario/scripts/entity.lua";


-- FUNCTIONS


-- Gets the income for the passed in month.  If the month hasn't happened yet it will return nil
-- Pass in -1 to get the income for the current month
function getIncome(month)
	local mgr = queryObject("ZTEconomyMgr");
	if (mgr) then
		local income = mgr:ZT_GET_ZOO_INCOME(month);
		if income ~= nil then
			return income;
		end
	end
	return nil;
end


-- Gets the profit for the passed in month.  If the month hasn't happened yet it will return nil
-- Pass in -1 to get the profit for the current month
function getProfit(month)
	local mgr = queryObject("ZTEconomyMgr");
	if (mgr) then
		local profit = mgr:ZT_GET_ZOO_PROFIT(month);
		if profit ~= nil then
			return profit;
		end
	end
	return nil;
end


-- Returns how much cash the player currently has
function howMuchCash()
	local mgr = queryObject("ZTEconomyMgr");
	if (mgr) then
		local cash = mgr:ZT_GET_ZOO_CASH();
		return cash;
	end

	return nil;	
end


-- Sets how much cash the player currently has
function setCash(cash)
	local mgr = queryObject("ZTEconomyMgr");
	if (mgr) then
		mgr:ZT_SET_ZOO_CASH(cash);
	end
end


-- Gives the player the amount of cash passed in (does not display UI)
function giveCashNoPopup(cash)
	local mgr = queryObject("ZTEconomyMgr");
	if (mgr) then
		local now = mgr:ZT_GET_ZOO_CASH();
		now = now + cash;
		mgr:ZT_SET_ZOO_CASH(now);
	end
end


-- Gives the player the amount of cash passed in
function giveCash(cash)
	local mgr = queryObject("ZTEconomyMgr");
	if (mgr) then
		local now = mgr:ZT_GET_ZOO_CASH();
		now = now + cash;
		mgr:ZT_SET_ZOO_CASH(now);
		
		showgivecash("Challengetext:GenericMoneyGrant", cash);
	end
end


-- Takes from the player the amount of cash passed in
function takeCash(cash)
	local mgr = queryObject("ZTEconomyMgr");
	if (mgr) then
		local now = mgr:ZT_GET_ZOO_CASH();
		now = now - cash;
		mgr:ZT_SET_ZOO_CASH(now);
	end
end


-- Pass in an admission type ("adult_admission", "child_admission", or "group_admission" for now)
-- Will return the price of admission for the specified type
function getAdmissionPrice(type)
	local mgr = queryObject("ZTStatus");
	if (mgr) then
		local admissionPrice = mgr:ZT_GET_ADMISSION_PRICE(type);
		return admissionPrice;
	end

	BFLOG(SYSERROR, "Can't get ZTStatus");
	return nil;	
end


-- Pass in an admission type ("adult_admission", "child_admission", or "group_admission" for now)
-- and a cost.  Will set the specified type to the cost.
function setAdmissionPrice(type, price)
	local tokenInit = { _type = "ZTAdmissionData", admissiontype = type, admissionprice = price }

	local mgr = queryObject("ZTStatus");
	if (mgr) then
		local admissionPrice = mgr:ZT_SET_ADMISSION_PRICE(tokenInit);
	end
end

-- Gets donations by type
function getDonations(animalType)
	local mgr = queryObject("ZTStatus");
	
	if (mgr) then
		local donstring = "Donate_"..animalType;
		local temp = mgr:ZT_GET_DONATIONBYANIMALTYPE(donstring);
		
		--BFLOG(SYSTRACE, "donations for "..animalType..": "..temp..".");
		return temp;
	else
		BFLOG(SYSTRACE, "Error querying ZTStatus");
	end
	
	return 0;
end


-- Gets donation total for all animal species
function getDonationsAllAnimals()
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

	local total = 0;

	local num = table.getn(masteranimallist);
		
	for i = 1, num do
		total = total + getDonations(masteranimallist[i]);
	end
	
	BFLOG(SYSTRACE, "all animal donations: "..total..".");
	
	return total;
end