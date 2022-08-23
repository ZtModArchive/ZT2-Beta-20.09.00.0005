
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

	welcome2 = {
		rulename = nil,
		panelPosition = nil,
		heading = "Tutoriallabels:T2",
		body = nil,
		completion = "tutorial2:tutorial2_welcome",
		completiontextposition = nil,
		image = nil,
		ring = nil
	},

	openconstructionpanel = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:openconstructionpanelheading",
		body = "tutorial2:openconstructionpanel",
		completion = "tutorial2:openconstructionpanelcompleted",
		completiontextposition = nil,
		image = "construction",
		ring = { x=58, y=614, w=70, h=70 }
	},
	
	selectrectangletool = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:openfencerectangletoolheading",
		body = "tutorial2:openfencerectangletool",
		completion = "tutorial2:openfencerectangletoolcompleted",
		completiontextposition = nil,
		image = "rectangle",
		ring = { x=320, y=605, w=30, h=45 }
	},
	
	placefences = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:placefencesheading",
		body = "tutorial2:placefences",
		completion = "tutorial2:placefencescompleted",
		completiontextposition = nil,
		image = "chainlink",
		ring = { x=290, y=680, w=70, h=70 }
	},
	
	placegate = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:placegateheading",
		body = "tutorial2:placegate",
		completion = "tutorial2:placegatecompleted",
		completiontextposition = nil,
		image = "staffgate",
		ring = { x=290, y=630, w=70, h=70 }
	},
	
	selectscenerytab = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:selectscenerytabheading",
		body = "tutorial2:selectscenerytab",
		completion = "tutorial2:selectscenerytabcompleted",
		completiontextposition = nil,
		image = "scenerytab",
		ring = { x=445, y=560, w=70, h=50 }
	},
	
	placedonationbox = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:placedonationboxheading",
		body = "tutorial2:placedonationbox",
		completion = "tutorial2:placedonationboxcompleted",
		completiontextposition = nil,
		image = "donationbox_df",
		ring = { x=290, y=630, w=70, h=70 }
	},
	
	selectpathtab = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:selectpathtabheading",
		body = "tutorial2:selectpathtab",
		completion = "tutorial2:selectpathtabcompleted",
		completiontextposition = nil,
		image = "pathtab",
		ring = { x=350, y=560, w=70, h=50 };
	},
	
	placepath = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:placepathheading",
		body = "tutorial2:placepath",
		completion = "tutorial2:placepathcompleted",
		completiontextposition = nil,
		image = "asphalt",
		ring = { x=290, y=630, w=70, h=70 }
	},
	
	selectbuildingtab= {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:selectbuildingtabheading",
		body = "tutorial2:selectbuildingtab",
		completion = "tutorial2:selectbuildingtabcompleted",
		completiontextposition = nil,
		image = "buildingtab",
		ring = { x=400, y=560, w=70, h=50 }
	},
	
	placebuildings= {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:placebuildingsheading",
		body = "tutorial2:placebuildings",
		completion = "tutorial2:placebuildingscompleted",
		completiontextposition = nil,
		image = nil,
		ring = { x=270, y=625, w=160, h=130 }
	},
	
	selectpretzelcart= {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:selectpretzelcartheading",
		body = "tutorial2:selectpretzelcart",
		completion = "tutorial2:selectpretzelcartcompleted",
		completiontextposition = nil,
		image = "snackcartpretzeldf",
		ring = nil,
	},	
	
	moveselectedentity= {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:moveselectedentityheading",
		body = "tutorial2:moveselectedentity",
		completion = "tutorial2:moveselectedentitycompleted",
		completiontextposition = nil,
		image = "snackcartpretzeldf",
		ring = { x=910, y=590, w=50, h=50 };
	},

	openanimalpanel = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:openanimalpanelheading",
		body = "tutorial2:openanimalpanel",
		completion = "tutorial2:openanimalpanelcompleted",
		completiontextposition = nil,
		image = "adoptanimals",
		ring = { x=107, y=617, w=70, h=70 }
	},
	
	placeanimal = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:placeanimalheading",
		body = "tutorial2:placeanimal",
		completion = "tutorial2:placeanimalcompleted",
		completiontextposition = nil,
		image = "elephantafricanadultf",
		ring = { x=284, y=625, w=80, h=80 };
	},

	selectfoodtab= {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:selectfoodtabbheading",
		body = "tutorial2:selectfoodtab",
		completion = "tutorial2:selectfoodtabcompleted",
		completiontextposition = nil,
		image = "animalfoodtab",
		ring = { x=400, y=560, w=70, h=50 }
	},

	placewaterfood = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:placewaterfoodheading",
		body = "tutorial2:placewaterfood",
		completion = "tutorial2:placewaterfoodcompleted",
		completiontextposition = nil,
		image = "trough",
		ring = { x=275, y=615, w=100, h=140 }
	},
	
		
	selectsheltertab= {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:selectsheltertabheading",
		body = "tutorial2:selectsheltertab",
		completion = "tutorial2:selectsheltertabcompeted",
		completiontextposition = nil,
		image = "animalsheltertab",
		ring = { x=445, y=560, w=70, h=50 }
	},
	
	researchobject= {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:researchobjectheading",
		body = "tutorial2:researchobject",
		completion = "tutorial2:researchobjectcompleted",
		completiontextposition = nil,
		image = "startresearchbutton",
		ring = {x=943, y=603, w=70, h=70 }
	},
	
	placeshelter = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:placeshelterheading",
		body = "tutorial2:placeshelter",
		completion = "tutorial2:placesheltercompleted",
		completiontextposition = nil,
		image = "elephanthouseshelter",
		ring = { x=290, y=630, w=70, h=70 }
	},
	
	selectenrichmenttab = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:enrichmentpanelheading",
		body = "tutorial2:enrichmentpanel",
		completion = "tutorial2:enrichmentpanelcompleted",
		completiontextposition = nil,
		image = "animalenrichmenttab",
		ring = { x=350, y=560, w=70, h=50 };
	},
	
	placepursuitball = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:placeopursuitballheading",
		body = "tutorial2:placeopursuitball",
		completion = "tutorial2:placeopursuitballcompleted",
		completiontextposition = nil,
		image = "pursuitball",
		ring = { x=290, y=630, w=70, h=70 }
	},
	
	openlandscapingpanel = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:openlandscapingpanelheading",
		body = "tutorial2:openlandscapingpanel",
		completion = "tutorial2:openlandscapingpanelcompleted",
		completiontextposition = nil,
		image = "terraform",
		ring = { x=157, y=617, w=70, h=70 }

	},
	
	paintsavannah = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:paintsavannahheading",
		body = "tutorial2:paintsavannah",
		completion = "tutorial2:paintsavannahcompleted",
		completiontextposition = nil,
		image = "savannah",
		ring = { x=477, y=594, w=230, h=70 },
	},

	openstaffpanel = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:openstaffpanelheading",
		body = "tutorial2:openstaffpanel",
		completion = "tutorial2:openstaffpanelcompleted",
		completiontextposition = nil,
		image = "staff",
		ring = { x=207, y=617, w=70, h=70 }

	},
	
	hirezookeeper = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial2:hirezookeeperheading",
		body = "tutorial2:hirezookeeper",
		completion = "tutorial2:hirezookeepercompleted",
		completiontextposition = nil,
		image = "keeper",
		ring = { x=346, y=627, w=70, h=70 }
	},

};


function setinitialtutorialstate(comp)
	if (disabletutorial2UIelements == nil) then
		BFLOG(SYSTRACE, "HELLO");
		local zoogate = countType("frontgate_df");
		if (zoogate > 0) then
		BFLOG(SYSTRACE, "Disabling UI Elements");
		local mgr = queryObject("BFScenarioMgr");
			if (mgr) then
				
				
				mgr:BFS_ADD_SCENARIO_OBJECT("chainlink");
				mgr:BFS_ADD_SCENARIO_OBJECT("gate");
					
				mgr:BFS_ADD_SCENARIO_OBJECT("DonationBox_df");
				mgr:BFS_ADD_SCENARIO_OBJECT("path");
				
				mgr:BFS_ADD_SCENARIO_OBJECT("foodstand_soda_df");
				mgr:BFS_ADD_SCENARIO_OBJECT("foodstand_hotdog_df");
				mgr:BFS_ADD_SCENARIO_OBJECT("snackcart_pretzel_df");
				mgr:BFS_ADD_SCENARIO_OBJECT("bathroomsmall_df");
				
				
				mgr:BFS_ADD_SCENARIO_OBJECT("ElephantAfrican_Adult_F");
				
				mgr:BFS_ADD_SCENARIO_OBJECT("Trough_Hay");
				
				mgr:BFS_ADD_SCENARIO_OBJECT("Trough_Water");
				
				mgr:BFS_ADD_SCENARIO_OBJECT("PursuitBall");
				
				
				
				mgr:BFS_ADD_SCENARIO_OBJECT("ElephantHouse_Shelter");
				
				mgr:BFS_ADD_SCENARIO_OBJECT("Staff");
				
			--	mgr:BFS_ADD_SCENARIO_OBJECT, BFS_EVENT("");
				
				
				
				mgr:UI_DISABLE("open zoo toggle button");
															
				mgr:UI_DISABLE("animals");
				mgr:UI_DISABLE("terraform");
				mgr:UI_DISABLE("Staff");
								
				mgr:UI_DISABLE("Selection Buttons");
				
				mgr:UI_DISABLE("multinfo button");
				mgr:UI_DISABLE("Zoofinance");
				mgr:UI_DISABLE("undo");
				mgr:UI_DISABLE("Photo Album");
				mgr:UI_DISABLE("delete");
				mgr:UI_DISABLE("minimize");
				mgr:UI_DISABLE("awards");
				
				mgr:UI_DISABLE("Path Tab");
				mgr:UI_DISABLE("Building Tab");
				mgr:UI_DISABLE("Scenery Tab");
			
				
				mgr:UI_DISABLE("Animal Enrichment Tab");
				mgr:UI_DISABLE("Animal Food Tab");
				mgr:UI_DISABLE("Animal Shelter Tab");
				
				--we will use the buy animals in this scenario
				mgr:UI_HIDE("Adopt Animal Tab");
				mgr:UI_SHOW("Buy Animal Tab");
								
				--mgr:UI_DISABLE("multinfo button");
				--mgr:UI_DISABLE("multinfo button");
				--mgr:UI_DISABLE("multinfo button");
				disabletutorial2UIelements = 1;
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
						
						local buyanimal = uimgr:UI_GET_CHILD("Buy Animal Tab");
						if (buyanimal) then
							buyanimal:UI_ACTIVATE_OFF();
							buyanimal:UI_ACTIVATE_ON();
						end
					end
					
					--tell the main mode to deselect the placement object
					local mode = queryObject("ZTMode");
					if (mode) then
						mode:sendMessage("ZT_SETMODE", "mode_selection");
					end
					
					
					BFLOG(SYSTRACE, "show goal panel overview");
				return 1;
			end
		end	
	end
	return 0;
end

function ringhack()
	--------------------------------------------------
	-------- hack block for ring movement
	--------------------------------------------------
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		component = uimgr:UI_GET_CHILD(ringLayout);
		if (component) then
			local r = { x=207, y=617, w=70, h=70 };

	 		component:UI_SET_POS({x=r.x, y=r.y});
	 		component:UI_SET_SIZE({x=r.w, y=r.h});
	 		component:UI_SHOW();
		end
	end
---------------------------------------------------
end

----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- WELCOME
function welcome2()	
	initTutorialRuleInfo(ruledata.welcome2);
	return 1;
end

function welcome2success()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------- 
--OPEN CONSTRUCTION PANEL
function openconstructionpanel()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.openconstructionpanel);
		if (ruledata.openconstructionpanel.rulename) then
			showRule(ruledata.openconstructionpanel.rulename);
		end
	end

	if isAlternateByName("construction") == true then
	 return 1;
	
	end
	--ringhack();
	
	return 0;
end

function openconstructionpanelsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT RECTANGLE TOOL
function selectrectangletool()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectrectangletool);
		
	end

	if isAlternateByName("rectangle") == true then
		return 1;
	end
	
	return 0;
end

function selectrectangletoolsuccess()	
	tutorialgoalcompleted();
	UIdisable("octagon");
	UIdisable("rubberband");
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE FENCES
function placefences(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.placefences);
		comp.fencecount = countType("fence");
	end
	

	local fencecount = countType("fence");
	if (fencecount > comp.fencecount) then
		return 1;
	end
	
	return 0;
end

function placefencessuccess()	
	tutorialgoalcompleted();
	
	--press the construction button again to prevent automatic gate placement mode... we will do that manually
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local component = uimgr:UI_GET_CHILD("Fence Typelist");
		if (component ~= nil) then
			component:UI_ACTIVATE_OFF();
		end
	end
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE GATE
function placegate(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.placegate);

		comp.gatecount = countType("gate");
		comp.fencecount = countType("fence") - comp.gatecount;
	end

	local gatecount = countType("gate");
	local fencecount = countType("fence") - gatecount;
	
	if (gatecount > comp.gatecount and fencecount < comp.fencecount) then
		return 1;
	end
	
	return 0;
end

function placegatesuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
-- SELECT PATH TAB
function selectscenerytab()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectscenerytab);
		
		-- Reenable the path tab
		UIenable("Scenery Tab");
	
	end

	if isAlternateByName("Scenery Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectscenerytabsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE DONATION BOX
function placedonationbox(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.placedonationbox);
		comp.donationboxcount = countType("donationbox");
	end
	
	local donationboxcount = countType("donationbox");
	if (donationboxcount > comp.donationboxcount) then
		return 1;
	end
	
	return 0;
end

function placedonationboxsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
-- SELECT PATH TAB
function selectpathtab()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectpathtab);
		
		-- Reenable the path tab
		UIenable("Path Tab");
	
	end

	if isAlternateByName("Path Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectpathtabsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE PATH
function placepath(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.placepath);
		comp.pathcount = countType("path");
	end
	

	local pathcount = countType("path");
	if (pathcount >= comp.pathcount + 4) then
		return 1;
	end
	
	return 0;
end

function placepathsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
-- SELECT BUIILDING TAB
function selectbuildingtab()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectbuildingtab);
		
		UIenable("Building Tab");
	end

	if isAlternateByName("Building Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectbuildingtabsuccess()	
	tutorialgoalcompleted();
	return 1;
end


----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE BUILDINGS
function placebuildings(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.placebuildings);
		comp.hotdogcount = countType("foodstand_hotdog");
		comp.pretzelcount = countType("snackcart_pretzel");
		comp.sodacount = countType("foodstand_soda");
	end
	
	local hotdogcount = countType("foodstand_hotdog");
	local pretzelcount = countType("snackcart_pretzel");
	local sodacount = countType("foodstand_soda");
	if (hotdogcount > comp.hotdogcount and pretzelcount > comp.pretzelcount and sodacount > comp.sodacount) then
		return 1;
	end
	
	return 0;
end

function placebuildingssuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT PRETZEL CART
function selectpretzelcart(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectpretzelcart);

	end
	
	local selectedentity = getSelectedEntity();
	if (selectedentity ~= nil) then
		local bindertype = selectedentity:BFG_GET_BINDER_TYPE();
		if (bindertype == "snackcart_pretzel_df") then
			return 1;
		end
	end
	
	
	return 0;
end

function selectpretzelcartsuccess()	
	tutorialgoalcompleted();

		return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--MOVE SELECTED ENTITY
function moveselectedentity(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.moveselectedentity);
		comp.selectedentity = nil;
	end
	
	local selectedentity = getSelectedEntity();
	if (selectedentity ~= comp.selectedentity) then
		--store out the selected entity, its type and the count so we know if its being moved
		comp.selectedentity = selectedentity;
		comp.entitymoved = false;
		if (selectedentity ~= nil) then
			comp.selectedentitytype = selectedentity:BFG_GET_BINDER_TYPE();
			comp.selectedentitycount = countType(comp.selectedentitytype);
			
		else
			--there is no selected entity so we should nil out the entity type and the count
			comp.selectedentitytype = nil;
			comp.selectedentitycount = nil;
		end
	else
		if (comp.selectedentitytype ~= nil) then
			local entitytypecount = countType(comp.selectedentitytype);
			if (comp.entitymoved and entitytypecount == comp.selectedentitycount) then
				--the entity has been moved and the entity is on the map so that means
				--this goal is completed
				return 1;
			end
			if (entitytypecount < comp.selectedentitycount) then
				--the entity has been pick up so set the entitymoved flag
				comp.entitymoved = true;
			end
		end
	end
	
	return 0;
end

function moveselectedentitysuccess()	
	tutorialgoalcompleted();
	
	return 1;
	
end

----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--OPEN ANIMAL PANEL
function openanimalpanel()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.openanimalpanel);
		UIenable("animals");
		
	end

	if isAlternateByName("animals") == true then
			return 1;
	end
	
	return 0;
end

function openanimalpanelsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE ANIMAL
function placeanimal(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.placeanimal);
		comp.animalcount = countType("animal");
	end
		
	
	local animalcount = countType("animal");
	
	if (animalcount > comp.animalcount) then
		return 1;
	end
	
	return 0;
end

function placeanimalsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
-- SELECT FOOD TAB
function selectfoodtab()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectfoodtab);
		
		UIenable("Animal Food Tab");
	end

	if isAlternateByName("Animal Food Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectfoodtabsuccess()	
	tutorialgoalcompleted();
	return 1;
end


----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE FOOD AND WATER
function placewaterfood(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.placewaterfood);
		comp.foodcount = countType("Trough_Hay");
		comp.watercount = countType("Trough_Water");
	end
		
	local foodcount = countType("Trough_Hay");
	local watercount = countType("Trough_Water");
	
	if (foodcount > comp.foodcount and watercount > comp.watercount) then
		return 1;
	end
	
	return 0;
end

function placewaterfoodsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
-- SELECT SHELTER TAB
function selectsheltertab()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectsheltertab);
		
		-- Reenable the path tab
		UIenable("Animal Shelter Tab");
	
	end

	if isAlternateByName("Animal Shelter Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectsheltertabsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
-- RESEARCH ELEPHANT HOUSE
function researchobject()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.researchobject);
		
	end

	if isAlternateByName("start research button") == true then
		return 1;
	end
	
	return 0;
end

function researchobjectsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE SHELTER
function placeshelter(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.placeshelter);
		comp.sheltercount = countType("shelters");
	end
		
	
	local sheltercount = countType("shelters");
	
	if (sheltercount > comp.sheltercount) then
		return 1;
	end
	
	return 0;
end

function placesheltersuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
-- SELECT ENRICHMENT TAB
function selectenrichmenttab()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectenrichmenttab);
		
		-- Reenable the path tab
		UIenable("Animal Enrichment Tab");
	
	end

	if isAlternateByName("Animal Enrichment Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectenrichmenttabsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE PURSUIT BALL
function placepursuitball(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.placepursuitball);
		comp.placepursuitballcount = countType("PursuitBall");
	end
		
	
	local placepursuitballcount = countType("PursuitBall");
	
	if (placepursuitballcount > comp.placepursuitballcount) then
		return 1;
	end
	
	return 0;
end

function placepursuitballsuccess()	
	tutorialgoalcompleted();
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--OPEN TERRAFORM PANEL
function openlandscapingpanel()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.openlandscapingpanel);
		UIenable("terraform");
		
	end

	if isAlternateByName("terraform") == true then
			return 1;
	end
	
	return 0;
end

function openlandscapingpanelsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--PAINT SAVANNAH
function paintsavannah(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.paintsavannah);
		comp.savannahcount = countCenterBiome("savannah");
		
	end

	local savannahcount = countCenterBiome("savannah");
	if (savannahcount > comp.savannahcount + 5) then
		return 1;
	end
	return 0;
end

function paintsavannahsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--OPEN STAFF PANEL
function openstaffpanel()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.openstaffpanel);
		UIenable("staff");
		
	end

	if isAlternateByName("staff") == true then
		return 1;
	end
	
	return 0;
end

function openstaffpanelsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------- 
--PLACE ZOOKEEPER
function hirezookeeper(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.hirezookeeper);
		UIenable("Staff Tab");
		comp.hirezookeepercount = countType("Keeper");
	end
		
	
	local hirezookeepercount = countType("Keeper");
	
	if (hirezookeepercount > comp.hirezookeepercount) then
		return 1;
	end
	
	return 0;
end

function hirezookeepersuccess()	
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
	setuservar("Tutorial2", "completed");
	showtutorialwin("tutorial2:tutorial_2_complete", "Tutorial3");
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
