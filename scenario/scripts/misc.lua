-- misc.lua
-- Misc lua functions


-- HEADER


-- Get the current month, returned as a base 0 int
-- function getCurrentMonth()

-- Initializes a loan.  Size is how much to give the player to start.  Payback is how much
-- they need to pay back before the loan is gone.  Skim is the percentage (0 - 1.0) to take
-- from their profits.
-- function initLoan(size, payback, skim)

-- Handles a player's loan (if they have one)
-- Call this at every scenario update
-- function checkLoan()

-- Pass in a month, and will return the number of guests who visited that month
-- function getNumGuests(month)

-- Gets the current time of day - float from [0 - 1]
-- function getCurrentTimeOfDay()

-- Gets the real time (in seconds) since the program was started
-- function getRealTime()

-- Pass in an entity, and return it's primary biome
-- function getPrimaryBiome(entity)

-- Gets the current camera X value
-- function getCameraX()

-- Gets the current camera Y value
-- function getCameraY()

-- Gets the current camera Z value
-- function getCameraZ()

-- Gets the current camera zoom value
-- function getCameraZoom()

-- Sets a user profile variable
-- function setuservar(thekey, theval)

-- Returns the value of a user profile variable.
-- May return nil if the variable has never been set.
-- May return nil if the variable has been explicitly cleared. 
-- function getuservar(thekey)

-- Sets a global variable with key and value.
-- If value is nil, clears that global variable.
-- function setglobalvar(thekey, theval)

-- Returns the value of a global variable.
-- May return nil if the variable has never been set.
-- May return nil if the variable has been explicitly cleared. 
-- function getglobalvar(thekey)

-- Gives the player a reward
-- function giveaward(awardname)

-- Returns the number of enrichment objects currently researched
-- function howManyEnrichResearched()

-- Returns locid as a string
-- function getLocID(locidname)

-- Returns the zoo fame
-- function getZooFame()

-- Gives num guests
-- function giveGuest(num)

-- Gets the number of animals that have been put up for adoption
-- function getAnimalsPutUpForAdoption()

-- Gets the number of animals that have been released to the wild
-- function getAnimalsReleased()

-- Counts the center biome nodes of the whole zoo and returns the number
-- function countCenterBiome(biomename);


-- FUNCTIONS

-- Get the current month, returned as a base 0 int
function getCurrentMonth()
	local mgr = queryObject("ZTStatus");
	if (mgr) then
		local curMonth = mgr:ZT_GET_CURRENT_MONTH();
		return curMonth;
	end
	return nil;
end


-- Initializes a loan.  Size is how much to give the player to start.  Payback is how much
-- they need to pay back before the loan is gone.  Skim is the percentage (0 - 1.0) to take
-- from their profits.
function initLoan(size, payback, skim)
	if loanactive == nil then
		-- Initialize the loan info
		loanactive = 1;
		loanpayback = payback;
		loanskim = skim;
		loanmonth = getCurrentMonth();

		BFLOG(SYSTRACE, "Loan initialized - size: "..size.." payback: "..loanpayback.." skim: "..loanskim..".");

		-- Give them their money
		giveCash(size);		
	end

	-- If a loan is already active then don't do anything
end


-- Handles a player's loan (if they have one)
-- Call this at every scenario update
function checkLoan()
	BFLOG(SYSTRACE, "Checking loan...");
	-- Only if they currently have a loan
	if loanactive ~= nil then
		local curMonth = getCurrentMonth();

		BFLOG(SYSTRACE, "Last loan month: "..loanmonth.." current month: "..curMonth..".");

		-- If we have a new month to process
		if curMonth > loanmonth	then

			-- Figure out how much they profited last month
			local lastprofit = getProfit(loanmonth);

			BFLOG(SYSTRACE, "Last month profit: "..lastprofit..".");

			if lastprofit > 0 then

				local skimamount = lastprofit * loanskim;				
				-- Subtract this skim from their cash and loan payback
				takeCash(skimamount);

				BFLOG(SYSTRACE, "Paid back to loan: "..skimamount..".");				

				loanpayback = loanpayback - skimamount;

				-- If they have paid back their fair share
				if loanpayback < 0 then

					-- Give them back the overpay
					local overpay = 0 - loanpayback;
					giveCash(overpay);

					-- Now cancel the loan
					loanactive = nil;
					BFLOG(SYSTRACE, "Loan has been completely repaid!");
				end

				-- If it's not paid off yet, then update the month
				loanmonth = curMonth;
			else
				BFLOG(SYSTRACE, "Profit is negative or 0, so none of the loan was repaid.");
				loanmonth = curMonth;
			end
		end
	end
end


-- Pass in a month, and will return the number of guests who visited that month
function getNumGuests(month)
        local mgr = queryObject("ZTEconomyMgr");
        if (mgr) then
		if month == -1 then
			return mgr:ZT_GET_INFO{ _type="ZTEconomyInfo", period="lifetime", category="admissions", type="totalUsers" }
		else
			return mgr:ZT_GET_INFO{ _type="ZTEconomyInfo", period="monthly", category="admissions", type="totalUsers", month=month }
		end
	end                   
end


-- Gets the current time of day - float from [0 - 1]
function getCurrentTimeOfDay()
	local mgr = queryObject("ZTStatus");
	if (mgr) then
		local time = mgr:ZT_GET_CURRENT_TIMEOFDAY();
		return time;
	else
		return -1;
	end
end


-- Gets the real time (in seconds) since the program was started
function getRealTime()
	local time = os.clock();
	return time;
end



-- Pass in an entity.  If it's environment need is met, will return a string of it's biome name
-- If the environment need is not met, will return nil
function animalMeetsBiomeNeed(entity)
	local ismet = needMet(entity, "environment");

	if ismet == true then
		-- get entity biome type and return it
		local retval = getPrimaryBiome(entity);
	
		if retval ~= "" then
			return retval;
		end
	end

	-- Otherwise return nil
	return nil;
end


-- Pass in an entity, and return it's primary biome
function getPrimaryBiome(entity)
	if entity ~= nil then
		local whatbiome = entity:BFG_GET_PRIMARY_BIOME();
		return whatbiome;
	end

	return nil;
end


-- Gets the current camera X value
function getCameraX()
	mgr = queryObject("ZTWorldMgr");
	if (mgr) then
		local camerax = mgr:BFG_GET_CAMERA_X();
		return camerax;
	end
	return nil;
end

-- Gets the current camera Y value
function getCameraY()
	mgr = queryObject("ZTWorldMgr");
	if (mgr) then
		local cameray = mgr:BFG_GET_CAMERA_Y();
		return cameray;
	end
	return nil;
end

-- Gets the current camera Z value
function getCameraZ()
	mgr = queryObject("ZTWorldMgr");
	if (mgr) then
		local cameraz = mgr:BFG_GET_CAMERA_Z();
		return cameraz;
	end
	return nil;
end


-- Gets the current camera zoom value
function getCameraZoom()
	mgr = queryObject("ZTWorldMgr");
	if (mgr) then
		local zoom = mgr:BFG_GET_CAMERA_ZOOM();
		return zoom;
	end
	return nil;
end


function setuservar(thekey, theval)
	local mgr = queryObject("BFScenarioMgr");
	mgr:BFS_SETUSERVAL({key=thekey, val=theval});
	if (theval ~= nil) then
		BFLOG(SYSTRACE, "SetUserVar: "..thekey.."="..theval);
	else
		BFLOG(SYSTRACE, "SetUserVar: "..thekey.."=<nil>");
	end
end

-- Returns the value of a user profile variable.
-- May return nil if the variable has never been set.
-- May return nil if the variable has been explicitly cleared. 
function getuservar(thekey)
	local mgr = queryObject("BFScenarioMgr");
	local val = mgr:BFS_GETUSERVAL(thekey);
	if (val ~= nil) then
		BFLOG(SYSTRACE, "GetUserVar: "..thekey.."="..val);
	else
		BFLOG(SYSTRACE, "GetUserVar: "..thekey.."=<nil>");
	end
	return val;
end


-- Sets a global variable with key and value.
-- If value is nil, clears that global variable.
function setglobalvar(thekey, theval)
	local mgr = queryObject("BFScenarioMgr");
	mgr:BFS_SETGLOBALVAR({key=thekey, val=theval});
	if (theval ~= nil) then
		BFLOG(SYSTRACE, "SetGlobalVar: "..thekey.."="..theval);
	else
		BFLOG(SYSTRACE, "SetGlobalVar: "..thekey.."=<nil>");
	end
end

-- Returns the value of a global variable.
-- May return nil if the variable has never been set.
-- May return nil if the variable has been explicitly cleared. 
function getglobalvar(thekey)
	local mgr = queryObject("BFScenarioMgr");
	local val = mgr:BFS_GETGLOBALVAR(thekey);
	if (val ~= nil) then
		BFLOG(SYSTRACE, "GetGlobalVar: "..thekey.."="..val);
	else
		BFLOG(SYSTRACE, "GetGlobalVar: "..thekey.."=<nil>");
	end
	return val;
end

-- Gives the player a reward
function giveaward(awardname)
	local am = queryObject("ZTAwardMgr");
	if (am ~= nil) then
		local hasit = am:ZT_HAS_AWARD(awardname);
		if (hasit) then
			BFLOG(SYSTRACE, "Already has it.");
		else
			am:ZT_GIVE_AWARD(awardname);
			BFLOG(SYSTRACE, "Gave it.");
		end
	else
		BFLOG(SYSTRACE, "No award manager.");
	end
end

-- Returns the number of enrichment objects currently researched
function howManyEnrichResearched()
	local enrichtable = { };
	enrichtable[1] = "CarTire";
	enrichtable[2] = "Easel";
	enrichtable[3] = "HeatedRock";
	enrichtable[4] = "IceFloe_Large";
	enrichtable[5] = "MonkeyBars";
	enrichtable[6] = "LookoutPost";
	enrichtable[7] = "PeanutFeeder";
	enrichtable[8] = "PlasticBarrel";
	enrichtable[9] = "ScratchPost";
	enrichtable[10] = "WoodenRamp";
	enrichtable[11] = "RubberToy";
	
	local count = 0;
	local gameMgr = queryObject("ZTResearchMgr");
	if (gameMgr) then
		local num = table.getn(enrichtable);
		for i = 1, num do
			tmp = gameMgr:ZT_RESEARCH_IS_UNLOCKED(enrichtable[i]);
			if (tmp == true) then
				BFLOG(SYSTRACE, enrichtable[i]..": true");
				count = count + 1;
			else
				BFLOG(SYSTRACE, enrichtable[i]..": false");
			end
		end
	else
		BFLOG(SYSTRACE, "Can't grasp ZTResearchMgr");
	end
	
	return count;
end


-- Returns locid as a string
function getLocID(locidname)
	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		local returnval = mgr:BFS_GETLOCID(locidname);
		return returnval;
	else
		BFLOG(SYSTRACE, "Couldn't get BFScenarioMgr");
	end
end


-- Returns the zoo fame
function getZooFame()
	local mgr = queryObject("ZTStatus");
	if (mgr) then
		local zoofame = mgr:ZT_GET_ZOO_FAME();
		BFLOG(SYSTRACE, "Zoo fame is..." ..zoofame);
		return zoofame;
	end
end


-- Gives num guests
function giveGuest(num)
	local mgr = queryObject("ZTAIGuestMgr");
	if (mgr) then
		for i = 1, num do
			BFLOG(SYSTRACE, "Adding a guest");
			mgr:ZTAI_CREATE_GUEST();
		end
	else
		BFLOG(SYSTRACE, "Failed to query ZTAIGuestMgr");
	end
end

-- Gets the number of animals that have been put up for adoption
function getAnimalsPutUpForAdoption()
	local mgr = queryObject("ZTStatus");
	local numadopt = 0;
	
	if (mgr) then
		numadopt = mgr:ZT_GET_ANIMALS_PUTUPFORADOPTION();
	else
		BFLOG(SYSTRACE, "error querying ZTStatus");
	end
	
	return numadopt;
end

-- Gets the number of animals that have been released to the wild
function getAnimalsReleased()
	local mgr = queryObject("ZTStatus");
	local numreleased = 0;
	
	if (mgr) then
		numreleased = mgr:ZT_GET_ANIMALS_RELEASED();
	else
		BFLOG(SYSTRACE, "error querying ZTStatus");
	end
	
	return numreleased;
end

-- Counts the center biome nodes of the whole zoo and returns the number
function countCenterBiome(biomename)
	mgr = queryObject("ZTWorldMgr");
	if (mgr) then
		return mgr:ZT_GET_BIOME_COUNT(biomename);
	end
	return 0;
end