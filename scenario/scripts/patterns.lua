-- patterns.lua
-- Example of how to do some various things


-- Keep all of your Tigers happy for 6 months (basic needs met)
function keephappy()
	require "scenario/scripts/misc";
	
	-- If we haven't set this up yet, do so
	if happytimer == nil then
		happytimer = getCurrentMonth();
		BFLOG(SYSTRACE, "KeepHappy started.");	
	end

	-- Keep going if we're not finished yet
	if happyover == nil then
		if allTypeBasicNeedsMet("TigerBengal") == false then
			BFLOG(SYSTRACE, "FAILED challenge.");
			happyover = 1;
		end

		local tmpmonth = getCurrentMonth();

		local time = happytimer + 6;
		if tmpmonth >= time then
			BFLOG(SYSTRACE, "Passed challenge!");
			happyover = 1;
		end
	end
end



-- Reduce the admission price in half, for 6 months
-- If the player manages to not get a sick animal in that time, then give them
-- a bonus based on the number of guests they had in those 6 months
-- also, give them $5000 up front
function reduceadmissionrefundsick()
	require "scenario/scripts/misc";
	
	-- If we haven't set this up yet, do so
	if refundtimer == nil then
		refundtimer = getCurrentMonth();
		giveCash(5000);

		-- backup their current admission prices
		oldadmissionadult = getAdmissionPrice("adult_admission");
		oldadmissionchild = getAdmissionPrice("child_admission");

		-- set the new ones to 1/2 what they used to be
		setAdmissionPrice("adult_admission", oldadmissionadult / 2);
		setAdmissionPrice("child_admission", oldadmissionchild / 2);

		displayadmissionadult = oldadmissionadult / 2;
		displayadmissionchild = oldadmissionchild / 2;

		BFLOG(SYSTRACE, "Setting adult admission to: "..displayadmissionadult..".");
		BFLOG(SYSTRACE, "Setting child admission to: "..displayadmissionchild..".");

		BFLOG(SYSTRACE, "ReduceAdmissionRefundSick started.");	
	end

	-- Keep going if we're not finished yet
	if refundover == nil then
		-- If any of their animals are sick, then fail the challenge
		if areAnySick() == true then
			refundover = 1;
			BFLOG(SYSTRACE, "Animal sick.  Challenge FAILED");
		end

		local tmpmonth = getCurrentMonth();

		local time = refundtimer + 6;
		if tmpmonth >= time then
			BFLOG(SYSTRACE, "Passed challenge!");

			-- so put their prices back to normal
			setAdmissionPrice("adult_admission", oldadmissionadult);
			setAdmissionPrice("child_admission", oldadmissionchild);

			local totalguests = 0;

			-- and then give them their refund
			for i = refundtimer, tmpmonth do
				totalguests = totalguests + getNumGuests(i);			
			end

			BFLOG(SYSTRACE, "Total number of guests for refund: "..totalguests..".");

			-- Their refund is going to be the average of the discount adult and child admission
			-- multiplied by the total number of guests who were admitted through the months the
			-- challenge was taking place
			local refund = totalguests * (((oldadmissionadult/2) +  (oldadmissionchild/2)) / 2);
			giveCash(refund);

			BFLOG(SYSTRACE, "Total refund: "..refund..".");
		
			refundover = 1;
		end
	end
end