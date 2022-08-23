
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

	welcome3 = {
		rulename = nil,
		panelPosition = nil,
		heading = "Tutoriallabels:T3",
		body = nil,
		completion = "tutorial3:tutorial3_welcome",
		completiontextposition = nil,
		image = nil,
		ring = nil
	},

	selectanimal = {
		rulename = "selectanimal",
		panelPosition = nil,
		heading = "tutorial3:selectanimalheading",
		body = "tutorial3:selectanimal",
		completion = "tutorial3:selectanimalcompleted",
		completiontextposition = nil,
		image = nil,
		ring = nil,
	},
	
	viewanimalneeds = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:viewanimalneedsheading",
		body = "tutorial3:viewanimalneeds",
		completion = "tutorial3:viewanimalneedscompleted",
		completiontextposition = nil,
		image = "animalneeds",
		ring = {x=790, y=515, w=70, h=60}, 
	},
	
	viewanimalgeneral = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:viewanimalgeneralheading",
		body = "tutorial3:viewanimalgeneral",
		completion = nil,
		completiontextposition = nil,
		image = "animalgeneral",
		ring = { x=835, y=515, w=70, h=60 },
	},
	
	viewrecommendations = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:viewrecommendationsheading",
		body = "tutorial3:viewrecommendations",
		completion = "tutorial3:viewrecommendationscompleted",
		completiontextposition = nil,
		image = "recommendations",
		ring = { x=960, y=583, w=70, h=70 },
	},
	
	closerecommendations = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:viewrecommendationsheading",
		body = "tutorial3:closerecommendations",
		completion = nil,
		completiontextposition = nil,
		image = "recommendationsclose",
		ring = { x=960, y=583, w=70, h=70 },
	},
	
	selectkeeper = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectkeeperheading",
		body = "tutorial3:selectkeeper",
		completion = nil,
		completiontextposition = nil,
		image = nil,
		ring = nil,
	},
	
	viewassignments = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:viewassignmentsheading",
		body = "tutorial3:viewassignments",
		completion = nil,
		completiontextposition = nil,
		image = "assignments",
		ring = { x=815, y=515, w=70, h=60 },
	},
	
	selectaddassign = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectaddassignheading",
		body = "tutorial3:selectaddassign",
		completion = "tutorial3:selectaddassigncompleted",
		completiontextposition = nil,
		image = "addassignment",
		ring = { x=820, y=715, w=70, h=60 },
	},
	
	selectstaffthoughts = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectstaffthoughtsheading",
		body = "tutorial3:selectstaffthoughts",
		completion = nil,
		completiontextposition = nil,
		image = "staffthoughts",
		ring = { x=865, y=515, w=70, h=60  },
	},
	
	selectstaffsalary = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectstaffsalaryheading",
		body = "tutorial3:selectstaffsalary",
		completion = nil,
		completiontextposition = nil,
		image = "staffsalary",
		ring = { x=915, y=515, w=70, h=60  },
	},
	
	selectguest = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectguestheading",
		body = "tutorial3:selectguest",
		completion = "tutorial3:selectguestcompleted",
		completiontextposition = nil,
		image = nil,
		ring = nil,
	},
	
	selectgueststatus = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectgueststatusheading",
		body = "tutorial3:selectgueststatus",
		completion = nil,
		completiontextposition = nil,
		image = "gueststatus",
		ring = { x=790, y=515, w=70, h=60  },
	},
	
	selectguestfavorites = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectguestfavoritesheading",
		body = "tutorial3:selectguestfavorites",
		completion = nil,
		completiontextposition = nil,
		image = "guestfavorites",
		ring = { x=837, y=515, w=70, h=60  },
	},
	
	selectguestthoughts = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectguestthoughtsheading",
		body = "tutorial3:selectguestthoughts",
		completion = nil,
		completiontextposition = nil,
		image = "guestthoughts",
		ring = { x=883, y=515, w=70, h=60  },
	},
	
	selectfoodstand = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectfoodstandheading",
		body = "tutorial3:selectfoodstand",
		completion = nil,
		completiontextposition = nil,
		image = nil,
		ring = nil,
	},
	
	selectfoodstandfinance = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectfoodstandfinanceheading",
		body = "tutorial3:selectfoodstandfinance",
		completion = nil,
		completiontextposition = nil,
		image = "buildingfinance",
		ring = { x=785, y=515, w=70, h=60  },
	},
	
	selectzoostatus = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:selectzoostatusheading",
		body = "tutorial3:selectzoostatus",
		completion = nil,
		completiontextposition = nil,
		image = "zoostatus",
		ring = { x=155, y=677, w=50, h=50  },
	},

	selectzoofinances = {
		rulename = nil,
		panelPosition = { x=510, y=266 },
		heading = "tutorial3:selectzoofinancesheading",
		body = "tutorial3:selectzoofinances",
		completion = nil,
		completiontextposition = nil,
		image = "zoofinances",
		ring = { x=405, y=105, w=70, h=50  },
	},
	
	closezoostatus = {
		rulename = nil,
		panelPosition = { x=510, y=266 },
		heading = "tutorial3:closezoostatusheading",
		body = "tutorial3:closezoostatus",
		completion = nil,
		completiontextposition = nil,
		image = "zoostatusclose",
		ring = { x=780, y=60, w=70, h=70  },
	},
	
	openquickstats = {
		rulename = { x=510, y=266 },
		panelPosition = nil,
		heading = "tutorial3:openquickstatsheading",
		body = "tutorial3:openquickstats",
		completion = nil,
		completiontextposition = nil,
		image = "quickstats",
		ring = { x=115, y=677, w=50, h=50  },
	},

	viewguestlist = {
		rulename = nil,
		panelPosition = { x=310, y=488 },
		heading = "tutorial3:viewguestlistheading",
		body = "tutorial3:viewguestlist",
		completion = nil,
		completiontextposition = nil,
		image = "guestlist",
		ring = { x=475, y=105, w=70, h=50  },
	},
	
	viewstafflist = {
		rulename = nil,
		panelPosition = { x=310, y=488 },
		heading = "tutorial3:viewstafflistheading",
		body = "tutorial3:viewstafflist",
		completion = nil,
		completiontextposition = nil,
		image = "stafflist",
		ring = { x=525, y=105, w=70, h=50  },
	},
	
	closequickstats = {
		rulename = nil,
		panelPosition = { x=310, y=488 },
		heading = "tutorial3:closequickstatsheading",
		body = "tutorial3:closequickstats",
		completion = nil,
		completiontextposition = nil,
		image = "quickstatsclose",
		ring = { x=755, y=65, w=50, h=50  },
	},
	
	enterphotosafari = {
		rulename = nil,
		panelPosition = { x=256, y=50 },
		heading = "tutorial3:enterphotosafariheading",
		body = "tutorial3:enterphotosafari",
		completion = nil,
		completiontextposition = nil,
		image = "photosafari",
		ring = { x=-5, y=715, w=55, h=60  },
	},
	
	takephotos = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:takephotosheading",
		body = "tutorial3:takephotos",
		completion = nil,
		completiontextposition = nil,
		image = nil,
		ring = nil,
	},
	
	openphotoalbum = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:openphotoalbumheading",
		body = "tutorial3:openphotoalbum",
		completion = nil,
		completiontextposition = nil,
		image = "photoalbum",
		ring = { x=-5, y=553, w=55, h=60  },

	},
	
	closephotoalbum = {
		rulename = nil,
		panelPosition = nil,
		heading = "tutorial3:closephotoalbumheading",
		body = "tutorial3:closephotoalbum",
		completion = nil,
		completiontextposition = nil,
		image = "photoalbumclose",
		ring = { x=25, y=683, w=70, h=70  }
	},
};


function setinitialtutorialstate(comp)
	if (disabletutorial3UIelements == nil) then
		local zoogate = countType("frontgate_df");
		if (zoogate > 0) then
		BFLOG(SYSTRACE, "Disabling UI Elements");
		local mgr = queryObject("BFScenarioMgr");
			disabletutorial3UIelements = true;
			if (mgr) then
				
			end
		end	
	end
	return 1;
end
function ringhack()
	--------------------------------------------------
	-------- hack block for ring movement
	--------------------------------------------------
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		component = uimgr:UI_GET_CHILD(ringLayout);
		if (component) then
			
			local r = { x=25, y=683, w=70, h=70  };

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
function welcome3()	
	initTutorialRuleInfo(ruledata.welcome3);
	return 1;
end

function welcome3success()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT AN ANIMAL
function selectanimal()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectanimal);
		if (ruledata.selectanimal.rulename) then
		showRule(ruledata.selectanimal.rulename);
		end
	end

	local selectedentity = getSelectedEntity();
	if (selectedentity ~= nil) then
		if (isEntityKindOf(selectedentity, "animal")) then
			return 1;
		end
	end
	-- ringhack();
	
	return 0;
end

function selectanimalsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--VIEW ANIMAL NEEDS
function viewanimalneeds()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.viewanimalneeds);
	end

	if isAlternateByName("Animal Info Tab Button") == true then
		return 1;
	end
	return 0;
end

function viewanimalneedssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--VIEW ANIMAL GENERAL
function viewanimalgeneral()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.viewanimalgeneral);
	end

	if isAlternateByName("Animal Info Conservation Tab") == true then
		return 1;
	end
	return 0;
end

function viewanimalgeneralsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--VIEW KEEPER RECCOMENDATIONS
function viewrecommendations()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.viewrecommendations);
	end

	if isAlternateByName("in game sort button") == true then
		return 1;
	end
	return 0;
end

function viewrecommendationssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------- 
--CLOSE KEEPER RECCOMENDATIONS
function closerecommendations()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.closerecommendations);
	end

	if isAlternateByName("in game sort button") == false then
		return 1;
	end
	return 0;
end

function closerecommendationssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT A KEEPER
function selectkeeper()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectkeeper);
	end

	local selectedentity = getSelectedEntity();
	if (selectedentity ~= nil) then
		if (isEntityKindOf(selectedentity, "Keeper")) then
			return 1;
		end
	end
	return 0;
end

function selectkeepersuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--VIEW KEEPER ASSIGNMENTS
function viewassignments()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.viewassignments);
	end

	if isAlternateByName("Keeper Assignments Tab") == true then
		return 1;
	end
	return 0;
end

function viewassignmentssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT ADD ASSIGNMENT
function selectaddassign()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectaddassign);
	end

	if isAlternateByName("Add Assignment") == true then
		return 1;
	end
	return 0;
end

function selectaddassignsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT STAFF THOUGHTS
function selectstaffthoughts()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectstaffthoughts);
	end

	if isAlternateByName("Keeper Thoughts Tab") == true then
		return 1;
	end
	return 0;
end

function selectstaffthoughtssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT STAFF SALARY
function selectstaffsalary()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectstaffsalary);
	end
	
	if isAlternateByName("Keeper Info Status Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectstaffsalarysuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT A GUEST
function selectguest()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectguest);
	end
	
	local selectedentity = getSelectedEntity();
	if (selectedentity ~= nil) then
		if (isEntityKindOf(selectedentity, "Guest")) then
			return 1;
		end
	end
	return 0;
end

function selectguestsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT GUEST STATUS
function selectgueststatus()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectgueststatus);
	end
	
	if isAlternateByName("Guest Info Status Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectgueststatussuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT GUEST FAVORITES
function selectguestfavorites()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectguestfavorites);
	end
	
	if isAlternateByName("Guest Info Fav Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectguestfavoritessuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--
function selectguestthoughts()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectguestthoughts);
	end

	if isAlternateByName("Guest Info thoughts Tab") == true then
		return 1;
	end
	
	return 0;
end

function selectguestthoughtssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT A FOODSTAND
function selectfoodstand()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectfoodstand);
	end
	
	local selectedentity = getSelectedEntity();
	if (selectedentity ~= nil) then
		if (isEntityKindOf(selectedentity, "Foodstand")) then
			return 1;
		end
	end
	
	return 0;
end

function selectfoodstandsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT FOODSTAND FINANCE
function selectfoodstandfinance()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectfoodstandfinance);
	end
	
	if isAlternateByName("Commerce Building Info Status Tab Button") == true then
		return 1;
	end	
	
	return 0;
end

function selectfoodstandfinancesuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--OPEN ZOO STATUS PANEL
function selectzoostatus()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectzoostatus);
	end

	if isVisibleByName("zoo status layout") == true then
		return 1;
	end

	return 0;
end

function selectzoostatussuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--VIEW ZOO FINANCES
function selectzoofinances()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.selectzoofinances);
	end
	
	if isAlternateByName("balance sheet tab") == true then
		return 1;
	end	
	
	return 0;
end

function selectzoofinancessuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------- 
--CLOSE ZOO STATUS PANEL
function closezoostatus()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.closezoostatus);
	end

	if isVisibleByName("zoo status layout") == false then
		return 1;
	end
	
	return 0;
end

function closezoostatussuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--
function openquickstats()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.openquickstats);
	end
	
	if isVisibleByName("multilist layout") == true then
		return 1;
	end	
	
	return 0;
end

function openquickstatssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--
function viewguestlist()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.viewguestlist);
	end
	
	if isAlternateByName("Guest Multilist Tab") == true then
		return 1;
	end	
	
	return 0;
end

function viewguestlistsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--
function viewstafflist()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.viewstafflist);
	end
	
	if isAlternateByName("Staff Multilist Tab") == true then
		return 1;
	end	
	
	return 0;
end

function viewstafflistsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--
function closequickstats()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.closequickstats);
	end

	if isVisibleByName("multilist layout") == false then
		return 1;
	end	

	return 0;
end

function closequickstatssuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--SELECT PHOTO SAFARI MODE
function enterphotosafari()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.enterphotosafari);
	end
	
	if isAlternateByName("photo") == true then
		return 1;
	end	
	
	return 0;
end

function enterphotosafarisuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--TAKE 3 PHOTOS
function takephotos(comp)
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.takephotos);
		
		comp.photocount = 0;
		
		local photomgr = queryObject("ZTPhotoManager");
		if (photomgr ~= nil) then
			comp.photocount = photomgr:ZT_PHOTOEVENT_NUM_PICTURES();		
		end

	end
	
	local photocount = 0;
	local photomgr = queryObject("ZTPhotoManager");
	if (photomgr ~= nil) then
		photocount = photomgr:ZT_PHOTOEVENT_NUM_PICTURES();
		BFLOG(SYSTRACE, "PHOTO COUNT"..photocount)
	end

	if (photocount < comp.photocount) then
		--if we had less photos than we started with, the user probably cleared out his film
		--if that happens we need to reset the photo count.
		comp.photocount = photocount;
	end

	if (photocount >= comp.photocount + 3) then
		return 1;
	end
	
	return 0;
end

function takephotossuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--OPEN PHOTO ALBUM
function openphotoalbum()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.openphotoalbum);
	end

	if isVisibleByName("photoalbum_layout") == true then
		return 1;
	end	

	return 0;
end

function openphotoalbumsuccess()	
	tutorialgoalcompleted();
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------- 
--CLOSE PHOTO ALBUM
function closephotoalbum()
	if (ruleinitialized == 0) then
		--Initialization
		initTutorialRuleInfo(ruledata.closephotoalbum);
	end

	if isVisibleByName("photoalbum_layout") == false then
		return 1;
	end	
	
	return 0;
end

function closephotoalbumsuccess()	
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
	setuservar("Tutorial3", "completed");
	showtutorialwinhidenext("tutorial3:tutorial_3_complete");
	return 1;
end

----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------