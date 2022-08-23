
-- lua file for tutorial
include "scenario/scripts/misc.lua"
include "scenario/scripts/ui.lua"
include "scenario/scripts/entity.lua"

--sound to use when completing a tutorial goal
completionSound = "photo_challenges_completed"

--name of the ring layout
ringLayout = "tutorial ring"

tutorialPanelName = "tutorial info"

--default panel position, rules can specify a panel position, but if they don't use this panel position
defaultPanelPosition = { x=256, y=50 }
--panel size
defaultPanelSize = { x=512, y=256 }


--variable for one time initialization
ruleinitialized = 0

completionText = nil
completionTextPosition = nil

--initTutorialInfo
--initializes the tutorial rule info by populating the tutorial panel and goal with images and text
function initTutorialRuleInfo(data)

	--set the completiontext variable to the one specified in the data block
	completionText = data.completion;
	completionTextPosition = data.completiontextposition;

	if (data.heading) then
		showTutorialHeading(data.heading);
	end
	if (data.body) then
		showTutorialText(data.body);
	end
		
	showTutorialImage(data.image);


	--get the ring component in the gui and set it's animation data to highlight the specified rectangle
	local uimgr = queryObject("UIRoot");
	if (uimgr) then

		local currentPanelPosition = defaultPanelPosition;
		if (data.panelPosition) then
			currentPanelPosition = data.panelPosition;
		end
		
		local component = uimgr:UI_GET_CHILD(tutorialPanelName);
		if (component) then
			--setup the animation for the tutorial panel
			component:UI_SET_ANIM_RECT_START({ 	x=currentPanelPosition.x + defaultPanelSize.x / 2,
								y=currentPanelPosition.y,
								w=0,
								h=defaultPanelSize.y});
			component:UI_SET_ANIM_RECT_END({	x=currentPanelPosition.x,
								y=currentPanelPosition.y,
								w=defaultPanelSize.x,
								h=defaultPanelSize.y});
			component:UI_SHOW();
			component:UI_RAISE();
		end
	
		component = uimgr:UI_GET_CHILD(ringLayout);
		if (component) then
			--hide the component and wind the animation so the animation starts in the beginning
			component:UI_HIDE();
			component:UI_WIND_ANIMATION();
			if (data.ring) then
				--local start_x = data.ring.x + data.ring.w / 2;
				--local start_y = data.ring.y + data.ring.h / 2;
				
				local start_x = currentPanelPosition.x + 32;
				local start_y = currentPanelPosition.y + 32;
				
				component:UI_SET_ANIM_RECT_START({ x=start_x, y=start_y, w=0, h=0 });
				component:UI_SET_ANIM_RECT_END(data.ring);
				component:UI_SHOW();
			end
		end
	end
	

	ruleinitialized = 1;
end

--tutorialgoalcompleted
--selects the goals tab in the info panel. call this method when a tutorial rule succedes
function tutorialgoalcompleted()
	-- Show the primary goals tab
	local uimgr = queryObject("UIRoot");
	if (uimgr) then
		local gotoprimarygoals = uimgr:UI_GET_CHILD("primary goals tab");
		if (gotoprimarygoals) then
			gotoprimarygoals:UI_REPRESS();
			gotoprimarygoals:UI_ACTIVATE_ON();
		end
	end
	
	--Set the rule initialized to off so the next will initialize next time around
	ruleinitialized = 0;
	
	--play completion sound
	playSound(completionSound);
	
	--Reshow the tutorial panel so it plays its animaion
	if (uimgr) then
		local tutorialpanel = uimgr:UI_GET_CHILD(tutorialPanelName);
		if (tutorialpanel) then
			tutorialpanel:UI_HIDE();
			tutorialpanel:UI_WIND_ANIMATION();
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------
-- SHOW COMPLETION TEXT GOAL -- SPECIAL GOAL
-- This is a generic goal which simply shows the completion text
function showcompletiontext()
	if (ruleinitialized == 0) then
		--Initialization
		
		--show the last saved completionText as the body so we can give the user an afterthought
		showTutorialText(completionText);
		local uimgr = queryObject("UIRoot");
		if (uimgr) then
			local component = uimgr:UI_GET_CHILD(tutorialPanelName);
			if (component) then
				if (completionTextPosition ~= nil) then
					component:UI_SET_ANIM_RECT_START({ 	x=completionTextPosition.x + defaultPanelSize.x / 2,
										y=completionTextPosition.y,
										w=0,
										h=defaultPanelSize.y});
					component:UI_SET_ANIM_RECT_END({	x=completionTextPosition.x,
										y=completionTextPosition.y,
										w=defaultPanelSize.x,
										h=defaultPanelSize.y});
				end
								
				component:UI_SHOW();
				component:UI_RAISE();
			end
			
			component = uimgr:UI_GET_CHILD("continue tutorial");
			if (component) then
				component:UI_SHOW();
			end
			
			component = uimgr:UI_GET_CHILD(ringLayout);
			if (component) then
				component:UI_HIDE();
				component:UI_WIND_ANIMATION();
			end
		end
			
		
		ruleinitialized = 1;
	else
		
		--find out if the "continue tutorial button is still visible"
		if isVisibleByName("continue tutorial") == false then
			return 1;
		end
		
	end
	return 0;
end

function showcompletiontextsuccess()
	--Set the rule initialized to off so the next will initialize next time around
	ruleinitialized = 0;
	
	local uimgr = queryObject("UIRoot");
	--Reshow the tutorial panel so it plays its animaion
	if (uimgr) then
		local tutorialpanel = uimgr:UI_GET_CHILD(tutorialPanelName);
		if (tutorialpanel) then
			tutorialpanel:UI_HIDE();
			tutorialpanel:UI_WIND_ANIMATION();
		end
	end
	return 1;
end
----------------------------------------------------------------------------------------------------------------------------------------
