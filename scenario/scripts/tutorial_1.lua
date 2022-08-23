
-- lua file for tutorial
include "scenario/scripts/tutorial.lua"

--rule data defines locids and images to populate the tutorial panel and goal panel for each rule
--	'rulename' -> the name of the rule do display in the goal panel
--	'panelPosition' -> the location on screen of where the tutorial panel should go. Set to nil to use default position
--	'heading' -> the locid for the heading used in the tutorial panel
--	'body' -> the locid used for the body of text used in the tutorial panel
--	'completion' -> the locid used for tutorial goal completion
--	'image' -> the image used for the tutorial panel. To find the image definitions see data/ui/layout/challenge.xml 
--		and search for a component named 'tutorial image'. This component contains all the image definitions in a 
--		node called 'images'. Use the value in the key field as the parameter to define the image
--	'ring' the rectangle of the area of interest for a given rule.

ruledata = {

	welcome1 = {
		rulename = nil,
		panelPosition = nil,
		heading = "Tutoriallabels:T1",
		body = nil,
		completion = "tutorial1:tutorial1_welcome",
		completiontextposition = nil,
		image = nil,
		ring = nil
	},

	opengoals = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial1:goalpanelheading",
		body = "tutorial1:opengoalpanel",
		completion = nil,
		completiontextposition = nil,
		image = "scenariogoals",
		ring = { x=107, y=708, w=70, h=70 }
	},
	
	closegoals = {
		rulename =  nil,
		panelPosition = { x=256, y=266 },
		heading = "tutorial1:closegoalpanelheading",
		body = "tutorial1:closegoalpanel",
		completion = "tutorial1:opengoalpanelcompleted",
		completiontextposition = { x=256, y=50 },
		image = "scenariogoals",
		ring = { x=780, y=60, w=70, h=70 }
	},
	
	scrollmap = {
		rulename = "scrollmap",
		panelPosition = nil,
		heading = "tutorial1:cameracontrolscrollheading",
		body = "tutorial1:cameracontolscroll",
		completion = "tutorial1:cameracontolscrollcompleted",
		completiontextposition = nil,
		image = nil,
		ring = nil
	},
	
	zoommap = {
		rulename = "zoommap",
		panelPosition = nil,
		heading = "tutorial1:cameracontrolzoomheading",
		body = "tutorial1:cameracontolzoom",
		completion = "tutorial1:cameracontolzoomcompleted",
		completiontextposition = nil,
		image = "zoom",
		ring = { x=65, y=675, w=45, h=90 }
	},
	
	rotatemap = {
		rulename = "rotatemap",
		panelPosition = nil,
		heading = "tutorial1:cameracontrolrotateheading",
		body = "tutorial1:cameracontolrotate",
		completion = "tutorial1:cameracontolrotatecompleted",
		completiontextposition = nil,
		image = "rotate",
		ring = { x=35, y=695, w=105, h=50 }
	},
	
	firstperson = {
		rulename = "firstperson",
		panelPosition = nil,
		heading ="tutorial1:guestmodeheading",
		body = "tutorial1:guestmode",
		completion = "tutorial1:guestmodecompleted",
		completiontextposition = nil,
		image = "firstperson",
		ring = { x=-8, y=677, w=70, h=67 }
	},
	
	photosafarimode = {
		rulename = "photosafarimode",
		panelPosition = nil,
		heading = "tutorial1:photosafariheading",
		body = "tutorial1:photosafari",
		completion =  "tutorial1:photosafaricompleted",
		completiontextposition = nil,
		image = "photosafari",
		ring = { x=-8, y=710, w=70, h=67 }
	},
	
	returntooverheadmap = {
		rulename = "returntooverheadmap",
		panelPosition = nil,
		heading = "tutorial1:overheadmapheading",
		body = "tutorial1:overheadmap",
		completion = nil,
		completiontextposition = nil,
		image = "overhead",
		ring = { x=-10, y=634, w=70, h=67 }
	},
	
	mapoverview = {
		rulename = "mapoverview",
		panelPosition = nil,
		heading = "tutorial1:overviewmapheading",
		body = "tutorial1:overviewmap",
		completion = "tutorial1:overviewmapcompleted",
		completiontextposition = nil,
		image = "overviewmap",
		ring = { x=-10, y=605, w=70, h=67 }
	},
	
	
	mapoverviewclose = {
		rulename = "mapoverviewclose",
		panelPosition = nil,
		heading = "tutorial1:overviewmapheading",
		body = "tutorial1:overviewmapclose",
		completion = nil,
		completiontextposition = nil,
		image = "overviewmap",
		ring = { x=925, y=680, w=70, h=67 },
	},
	
	openzoopedia = {
		rulename = "openzoopedia",
		panelPosition = nil,
		heading = "tutorial1:zoopediaheading",
		body = "tutorial1:zoopedia",
		completion = nil,
		completiontextposition = nil,
		image = nil,
		ring = nil,
	},
	
	closezoopedia = {
		rulename = "closezoopedia",
		panelPosition = nil,
		heading = "tutorial1:zoopediacloseheading",
		body = "tutorial1:zoopediaclose",
		completion = "tutorial1:zoopediaclosecompleted",
		completiontextposition = nil,
		image = "scenariogoals",
		ring = { x=855, y=32, w=70, h=70 },
	},
	
	
};

function setinitialtutorialstate(comp)
	if (disabletutorial1UIelements == nil) then
		local zoogate = countType("frontgate_df");
		if (zoogate > 0) then
		BFLOG(SYSTRACE, "Disabling UI Elements");
		local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				mgr:UI_DISABLE("Camera Set");
				mgr:UI_DISABLE("filter_maximize");
			
				mgr:UI_DISABLE("Buy Animal Tab");
				mgr:UI_DISABLE("Adopt Animal Tab");
				mgr:UI_DISABLE("open zoo toggle button");
				mgr:UI_DISABLE("Primary Game Button Pointers");
				mgr:UI_DISABLE("Main Game Buttons");
				mgr:UI_DISABLE("Selection Buttons");
				mgr:UI_DISABLE("Zoom and Rotate");
				mgr:UI_DISABLE("multinfo button");
				mgr:UI_DISABLE("Zoofinance");
				mgr:UI_DISABLE("undo");
				mgr:UI_DISABLE("Photo Album");
				mgr:UI_DISABLE("delete");
				mgr:UI_DISABLE("Buy Area Container");
				mgr:UI_DISABLE("minimize");
				mgr:UI_DISABLE("awards");
				
								
				--mgr:UI_DISABLE("multinfo button");
				--mgr:UI_DISABLE("multinfo button");
				--mgr:UI_DISABLE("multinfo button");
				disabletutorial1UIelements = 1;
					local uimgr = queryObject("UIRoot");
					if (uimgr) then
						local gotooverview = uimgr:UI_GET_CHILD("Introduction tab");
						if (gotooverview) then
							gotooverview:UI_ACTIVATE_OFF();
							gotooverview:UI_ACTIVATE_ON();
						end
						local goalpanel = uimgr:UI_GET_CHILD("goalpanel");
						if (goalpanel) then
							goalpanel:ZT_AUTOPOPULATE_LIST();
						end
						local panel = uimgr:UI_GET_CHILD("MainGUI");
						if (panel) then
							local pressanimalbutton = panel:UI_GET_CHILD("animals")
							if (pressanimalbutton) then
								pressanimalbutton:UI_ACTIVATE_ON();
							end
							local pressanimalenrich = panel:UI_GET_CHILD("Animal Enrichment Tab");
							if (pressanimalenrich) then
								pressanimalenrich:UI_ACTIVATE_ON();
							end
							
							if (pressanimalbutton) then
								pressanimalbutton:UI_ACTIVATE_OFF();
							end							
						end
					end
					BFLOG(SYSTRACE, "show goal panel overview");
				return 1;
			end
		end	
	end
	return 0;
end


----------------------------------------------------------------------------------------------------------------------------------------
-- WELCOME
function welcome1()	
	initTutorialRuleInfo(ruledata.welcome1);
	return 1;
end

function welcome1success()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN SCENARIO GOALS
function opengoals()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.opengoals);
		if (ruledata.opengoals.rulename) then
			showRule(ruledata.opengoals.rulename);
		end
	end

	if isNormalByName("goalpanel") == true then
			return 1;
	end
	
	return 0;
end

function opengoalssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE SCENARIO GOALS
function closegoals()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.closegoals);
		
	end


	if isNormalByName("goalpanel") == false then
		return 1;
	end
	
	return 0;
end

function closegoalssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- SCROLL THE MAP
function scrollmap()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.scrollmap);
	end

	-- Init the variables if this is the first time through
	if scrollmap_oldx == nil then
		scrollmap_oldx = getCameraX();
		scrollmap_oldy = getCameraY();
	else
		local cx = getCameraX();
		local cy = getCameraY();
		
		if (cx > scrollmap_oldx + 5) or (cx < scrollmap_oldx - 5) then
			return 1;
		end
		
		if (cy > scrollmap_oldy + 5) or (cy < scrollmap_oldy - 5) then
			return 1;
		end;
		
	end
	
	return 0;
end

function scrollmapsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- ZOOM THE MAP
function zoommap()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.zoommap);

		-- Reenable the zoom buttons
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:UI_ENABLE("Zoom In");
			mgr:UI_ENABLE("Zoom Out");
		end
	end

	-- Init the variables if this is the first time through
	if zoommap_old == nil then
		zoommap_old = getCameraZoom();
		BFLOG(SYSTRACE, "ZoomOld: "..zoommap_old..".");
	else
		local czoom = getCameraZoom();
		
		BFLOG(SYSTRACE, "Zoom: "..czoom..".");
		
		if (czoom > zoommap_old + 1) or (czoom < zoommap_old - 1) then
			return 1;
		end
	end
	
	return 0;
end

function zoommapsuccess()
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE THE MAP
function rotatemap()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.rotatemap);

		-- Reenable the rotate buttons
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:UI_ENABLE("Rotate Left");
			mgr:UI_ENABLE("Rotate Right");
		end
	end

	BFLOG(SYSTRACE, "Checking map rotation");
	
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD("Zoom and Rotate");
		if (element) then
			local rotleft = element:UI_GET_CHILD("Rotate Left");
			local rotright = element:UI_GET_CHILD("Rotate Right");
		
			if (rotleft) and (rotright) then
				BFLOG(SYSTRACE, "Got element ok");
				if (isActivated(rotright) == true) or (isActivated(rotleft) == true) then
					BFLOG(SYSTRACE, "true");
					return 1;
				else
					BFLOG(SYSTRACE, "false");
					return 0;
				end
			end
		end
	end
	
	
	return 0;
end

function rotatemapsuccess()
	tutorialgoalcompleted();	
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- GO TO FIRST PERSON
function firstperson()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.firstperson);

		-- Reenable the first person button
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:UI_ENABLE("firstperson");
		end
	end


	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD("Camera Set");
		if (element) then
			local fpc = element:UI_GET_CHILD("firstperson");
		
			if (fpc) then
				if isAlternate(fpc) == true then
					return 1;
				else
					return 0;
				end
			end
		end
	end

	return 0;
end

function firstpersonsuccess()
	tutorialgoalcompleted();	
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- GO TO PHOTO SAFARI

function photosafarimode()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.photosafarimode);
		
		-- Reenable the photo safari button
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:UI_ENABLE("photo");
		end
	end
	
	showUI("help2 screen", false)
	
	
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD("Camera Set");
		if (element) then
			local pc = element:UI_GET_CHILD("photo");
			if (pc) then
				if isAlternate(pc) == true then
					return 1;
				else
					return 0;
				end
			end
		end
	end

	return 0;
end

	

function photosafarimodesuccess()
	tutorialgoalcompleted();	
	return 1;
end


----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- GO TO OVERHEAD VIEW
function returntooverheadmap()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.returntooverheadmap);
		
		-- Reenable the overhead button
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:UI_ENABLE("overhead");
		end
	end


	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD("Camera Set");
		if (element) then
			local over = element:UI_GET_CHILD("overhead");
			if (over) then		
				if isAlternate(over) == true then
					return 1;
				else
					return 0;
				end
			end
		end
	end
	
	return 0;
end

function returntooverheadmapsuccess()
	tutorialgoalcompleted();	
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- GO TO MAP OVERVIEW
function mapoverview()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.mapoverview);
		
		-- Reenable the overview map button
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:UI_ENABLE("overviewmap");
		end
	end

	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local element = uimgr:UI_GET_CHILD("overview");
		if (element) then
			element = element:UI_GET_CHILD("overview_screen");
			if isNormal(element) == true then
				return 1;
			else
				return 0;
			end
		end
	end
	
	return 0;
end


function mapoverviewsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE MAP OVERVIEW
function mapoverviewclose()

	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.mapoverviewclose);		
	end


	if (isVisibleByName("overview_screen") == false) then
		return 1;
	end

	
	return 0;
end

function mapoverviewclosesuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN THE ZOOPEDIA
function openzoopedia()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.openzoopedia);
	end
	
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local layout = uimgr:UI_GET_CHILD("zoopedia layout");
		if (layout) then
			BFLOG("Got layout");
			element = layout:UI_GET_CHILD("ztzoopedia");
			if (element) then
				BFLOG("Got element");
				if isNormal(element) == true then
					BFLOG("true");
					return 1;
				else
					BFLOG("false");
					return 0;
				end
			end
		end
	end
	
	return 0;
end

function openzoopediasuccess()
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE ZOOPEDIA GOALS
function closezoopedia()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.closezoopedia);
	end


	if (isVisibleByName("ztzoopedia") == false) then
		return 1;
	end
	
	return 0;
end

function closezoopediasuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- SCENARION END
function endscenario()
	
	
	return 1;
end

function endscenariosuccess()
	setuservar("Tutorial1", "completed");
	showtutorialwin("tutorial1:tutorial_1_complete", "Tutorial2");
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------