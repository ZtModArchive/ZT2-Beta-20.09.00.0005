-- ui.lua
-- UI oriented lua functions


-- HEADER


-- Pass in a UI element and will return true if it is activated, false otherwise
-- function isActivated(element)

-- Pass in a UI element and will return true if it is highlighted, false otherwise
-- function isHighlighted(element)

-- Pass in a UI element and will return true if it is normal, false otherwise
-- function isNormal(element)

-- Pass in a UI element and will return  true if it is set to alternate
-- Use this to check if tabs are selected (animal, animal enrichment, etc.)
-- function isAlternate(element)

-- Pass in a UI element and will return true if it is visible (not hidden)
-- function isVisible(element)

-- Pass in a UI element name, NOT an element, and will return true if it is normal
-- Use for top level UI components directly underneath UIRoot
-- function isNormalByName(elementname)

-- Pass in a UI element name, NOT an element, and will return true if it is activated
-- Use for top level UI components directly underneath UIRoot
-- function isActivatedByName(elementname)

-- Pass in a UI element name, NOT an element, and will return true if it is highlighted
-- Use for top level UI components directly underneath UIRoot
-- function isHighlightedByName(elementname)

-- Pass in a UI element name, NOT an element, and will return true if it is alternate
-- Use for top level UI components directly underneath UIRoot
-- function isAlternateByName(elementname)

-- Pass in a UI element name, NOT an element, and will return true if it is visible
-- Use for top level UI components directly underneath UIRoot
-- function isVisibleByName(elementname)


-- Will show the tutorial heading text with the locid
-- function showTutorialHeading(locid)

-- Will show the tutorial text window, with passed in locid
-- function showTutorialText(locid)

-- Will show the tutorial image with passed in key
-- function showTutorialImage(key)

-- Shows the specified rule
-- function showRule(rule)

-- Enable a section of the UI
-- function UIenable(what)

-- Disable a section of the UI
-- function UIdisable(what)

-- Shows or hides a section of the UI
-- function showUI(name, showFlag)

-- Shows the main challenge panel
-- function showchallengepanel(arg)

-- Shows the main challenge panel (passing text, not a locid)
-- function showchallengepaneltext(arg)

-- Shows the overview panel
-- function completeshowoverview()

-- Shows the primary goals
-- function showprimarygoals()

-- Shows the secondary goals
-- function showsecondarygoals()

-- Shows the photo goals
-- function showphotogoals()

-- Shows the scenario win panel with the specified locid. Pass string as next scenario
-- function showscenariowin(locid, nextScenario)

-- Shows the scenario win panel with the specified locid
-- But hides the next scenario button
-- function showscenariowinhidenext(locid)

-- Shows the scenario fail panel with the specified locid
-- function showscenariofail(locid, nextScenario)

-- Shows the tutorial win panel with the specified locid
-- function showtutorialwin(locid, nextScenario)

-- Shows the tutorial win panel with the specified locid
-- But hides the next scnearion button
-- functionshowtutorialwinhidenext(locid)

-- Shows the challenge win panel with the specified locid
-- function showchallengewin(locid)

-- Shows the challenge fail panel with the specified locid
-- function showchallengefail(locid)

-- Shows the cash panel with the specified locid, AND the specified amount
-- function showgivecash(locid, amount)

-- function showawardpanel()

-- Plays the specified sound
-- function playSound(whatsound)


-- FUNCTIONS


-- Pass in a UI element and will return true if it is activated, false otherwise
function isActivated(element)
	if element:UI_IS_ACTIVATED() == true then
		return true;
	else
		return false;
	end
end

-- Pass in a UI element and will return true if it is highlighted, false otherwise
function isHighlighted(element)
	if element:UI_IS_HIGHLIGHTED() == true then
		return true;
	else
		return false;
	end
end

-- Pass in a UI element and will return true if it is normal, false otherwise
function isNormal(element)
	if element:UI_IS_NORMAL() == true then
		return true;
	else
		return false;
	end
end

-- Pass in a UI element and will return  true if it is set to alternate
-- Use this to check if tabs are selected (animal, animal enrichment, etc.)
function isAlternate(element)
	if element:UI_IS_ALTERNATE() == true then
		return true;
	else
		return false;
	end
end

-- Pass in a UI element and will return true if it is visible on screen, false otherwise
function isVisible(element)
	if element:UI_IS_HIDDEN() == false then
		return true;
	else
		return false;
	end
end

-- Pass in a UI element name, NOT an element, and will return true if it is normal (not hidden)
function isNormalByName(elementname)
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD(elementname);
		if (element) then
			if isNormal(element) == true then
				return true;
			else
				return false;
			end
		end
	end

	return nil;
end

-- Pass in a UI element name, NOT an element, and will return true if it is activated
function isActivatedByName(elementname)
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD(elementname);
		if (element) then
			if isActivated(element) == true then
				return true;
			else
				return false;
			end
		end
	end

	return nil;
end

-- Pass in a UI element name, NOT an element, and will return true if it is highlighted
function isHighlightedByName(elementname)
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD(elementname);
		if (element) then
			BFLOG(SYSTRACE, "Got element ok");
			if isHighlighted(element) == true then
				BFLOG(SYSTRACE, "true");
				return true;
			else
				BFLOG(SYSTRACE, "false");
				return false;
			end
		end
	end

	return nil;
end

-- Pass in a UI element name, NOT an element, and will return true if it is alternate
function isAlternateByName(elementname)
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD(elementname);
		if (element) then
			if isAlternate(element) == true then
				return true;
			else
				return false;
			end
		end
	end

	return nil;
end

-- Pass in a UI element name, NOT an element, and will return true if it is visible
function isVisibleByName(elementname)
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD(elementname);
		if (element) then
			if isVisible(element) == true then
				return true;
			else
				return false;
			end
		end
	end

	return nil;
end

-- Will show the tutorial text window, with passed in locid
function showTutorialHeading(locid)
	local scen = queryObject("ZTScenarioMgr");
	if (scen) then
		scen:UI_SHOW("tutorial info");
	end

	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("tutorial info");
		if (ui) then				
			--Display the heading text
			local text = ui:UI_GET_CHILD("tutorial heading text");
			if (text) then
				text:UI_SET_LOCID(locid)
			end				
		end
	end
end

-- Will show the tutorial text window, with passed in locid
function showTutorialText(locid)
	local scen = queryObject("ZTScenarioMgr");
	if (scen) then
		scen:UI_SHOW("tutorial info");
	end

	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("tutorial info");
		if (ui) then				
			--Display the body text
			local text = ui:UI_GET_CHILD("tutorial text");
			if (text) then
				text:UI_SET_SIZE({x=425, y=0});
				text:UI_SET_LOCID(locid)
			end
				

		end
	end
end

-- Will show the tutorial image with passed in key
function showTutorialImage(key)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("tutorial info");
		if (ui) then				
			--Display the image
			local image = ui:UI_GET_CHILD("tutorial image");
			if (image) then
				if (key == nil) then
					image:UI_SET_VALUE("blank");
				else
					image:UI_SET_VALUE(key);
				end
				
			end


		end
	end
end

-- Hides the tutorial text window
function hideTutorialText()
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("tutorial info");
		if (ui) then
			ui:UI_HIDE();
		end
	end
end

-- Shows the specified rule
function showRule(rule)
	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		mgr:BFS_SHOWRULE(rule);
	end
end


-- Enable a section of the UI
function UIenable(what)
	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		mgr:UI_ENABLE(what);
		
	end
end


-- Disable a section of the UI
function UIdisable(what)
	local mgr = queryObject("BFScenarioMgr");
	if (mgr) then
		mgr:UI_DISABLE(what);
		
	end
end

-- Shows or hides a section of the UI
function showUI(name, showFlag)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD(name);
		if (ui) then
			if (showFlag) then
				ui:UI_SHOW();
			else
				ui:UI_HIDE();
			end
		end
	end
end


function showchallengepanel(arg)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("challenge layout");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if text then
					text:UI_SET_LOCID(arg)
				end
		end
	end	
	BFLOG(SYSTRACE, "Show challenge panel");
end

-- Shows the main challenge panel (passing text, not a locid)
function showchallengepaneltext(arg)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("challenge layout");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if text then
					text:UI_SET_TEXT(arg)
				end
		end
	end	
	BFLOG(SYSTRACE, "Show challenge panel");
end


function completeshowoverview()
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
		if (gotooverview) then
			gotooverview:UI_REPRESS();
			gotooverview:UI_ACTIVATE_OFF();
			gotooverview:UI_ACTIVATE_ON();
		end
	end	
	BFLOG(SYSTRACE, "Show overview");
	showUI("goals layout", true);
end

function showprimarygoals()
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotooverview = uimgr:UI_GET_CHILD("primary goals tab");
		if (gotooverview) then
			gotooverview:UI_ACTIVATE_OFF();
			gotooverview:UI_REPRESS();
			gotooverview:UI_ACTIVATE_ON();
		end
	end	
	BFLOG(SYSTRACE, "Show primary page");
	showUI("goals layout", true);
end

function showsecondarygoals()
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotooverview = uimgr:UI_GET_CHILD(" secondary tab ");
		if (gotooverview) then
			gotooverview:UI_ACTIVATE_OFF();
			gotooverview:UI_REPRESS();
			gotooverview:UI_ACTIVATE_ON();
		end
	end	
	BFLOG(SYSTRACE, "Show secondary page");
	showUI("goals layout", true);
end

function showphotogoals()
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
		if (goalpanel) then
			goalpanel:ZT_AUTOPOPULATE_LIST();
		end
		local gotooverview = uimgr:UI_GET_CHILD("photo challenges tab ");
		if (gotooverview) then
			gotooverview:UI_ACTIVATE_OFF();
			gotooverview:UI_REPRESS();
			gotooverview:UI_ACTIVATE_ON();
		end
	end	
	BFLOG(SYSTRACE, "Show photo page");
	showUI("goals layout", true);
end

-- Shows the scenario win panel with the specified locid
function showscenariowin(locid, nextScenario)
	-- Set the next scenario global var
	setglobalvar("nextScenario", nextScenario);
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("Scenario Win  Layout");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if text then
					text:UI_SET_LOCID(locid)
				end
		else
			BFLOG(SYSTRACE, "Couldn't open Scenario Win Layout");
		end
	end	
end

-- Shows the scenario fail panel with the specified locid
function showscenariofail(locid, nextScenario)
	-- Set the next scenario global var
	setglobalvar("nextScenario", nextScenario);
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("Scenario Failed Layout");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if text then
					text:UI_SET_LOCID(locid)
				end
		else
			BFLOG(SYSTRACE, "Couldn't open Scenario Fail Layout");
		end
	end
end

-- Shows the tutorial win panel with the specified locid
function showtutorialwin(locid, nextScenario)
	-- Set the next scenario global var
	setglobalvar("nextScenario", nextScenario);
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("tutorial complete");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if text then
					text:UI_SET_LOCID(locid)
				end
				
				local button = ui:UI_GET_CHILD("continue");
				if (button) then
					button:UI_SHOW();
				end
		else
			BFLOG(SYSTRACE, "Couldn't open tutorial win layout");
		end
	end	
end

-- Shows the tutorial win panel with the specified locid
-- But hides the next scnearion button
function showtutorialwinhidenext(locid)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("tutorial complete");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if text then
					text:UI_SET_LOCID(locid)
				end
				
				local button = ui:UI_GET_CHILD("play next");
				if (button) then
					button:UI_HIDE();
				end
		else
			BFLOG(SYSTRACE, "Couldn't open Scenario Win Layout");
		end
	end	
end

function showchallengewin(locid)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("Challenge Won Layout");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if text then
					text:UI_SET_LOCID(locid)
				end
		else
			BFLOG(SYSTRACE, "Couldn't open Challenge Win Layout");
		end
	end	
end

-- Shows the challenge fail panel with the specified locid
function showchallengefail(locid)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("Challenge Failed Layout");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if text then
					text:UI_SET_LOCID(locid)
				end
		else
			BFLOG(SYSTRACE, "Couldn't open Challenge Fail Layout");
		end
	end
end

-- Shows the cash panel with the specified locid, AND the specified amount
function showgivecash(locid, amount)
	BFLOG(SYSTRACE, "showgivecash");	
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("Grant Layout");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if (text) then
					text:UI_SET_LOCID(locid);
				end
				
				local uiamount = ui:UI_GET_CHILD("zoo_bucks_display");
				if (uiamount) then
					BFLOG(SYSTRACE, "Setting zoo bucks");
					uiamount:UI_SET_VALUE(amount);
				end
		else
			BFLOG(SYSTRACE, "Couldn't open Challenge Fail Layout");
		end
	end
end


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


-- Shows the scenario win panel with the specified locid
-- But hides the next scenario button
function showscenariowinhidenext(locid)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		local ui = mgr:UI_GET_CHILD("Scenario Win  Layout");
		if (ui) then
				ui:UI_SHOW();
				local text = ui:UI_GET_CHILD("challenge text");
				if text then
					text:UI_SET_LOCID(locid)
				end
				
				local button = ui:UI_GET_CHILD("continue");
				if (button) then
					button:UI_HIDE();
				end
		else
			BFLOG(SYSTRACE, "Couldn't open Scenario Win Layout");
		end
	end	
end


-- Plays the specified sound
function playSound(whatsound)
	local mgr = queryObject("UIRoot");
	if (mgr) then
		BFLOG(SYSTRACE, "playing sound: "..whatsound..".");
		mgr:UI_PLAY_SOUND(whatsound);
	end
end