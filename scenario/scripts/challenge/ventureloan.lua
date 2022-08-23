-- ventureloan.lua
-- functions for the ventureloan challenge

include "scenario/scripts/ui.lua";
include "scenario/scripts/economy.lua";


-- gives you venture capitalist loan challenge
function evalventureloan(comp)

	BFLOG(SYSTRACE, "evalventureloan");

	challenge = getglobalvar("challenge")
	if (challenge == "accept") then
		BFLOG(SYSTRACE, "*******You accepted!")
		local mgr = queryObject("BFScenarioMgr");
		if (mgr) then
			mgr:BFS_SHOWRULE("ventureloan");
		end
		
		setglobalvar("challengeactive", "true");
		
		-- INIT THE LOAN
		if comp.loanactive == nil then
			-- Initialize the loan info
			comp.loanactive = 1;
			comp.loanpayback = 12000;
			comp.loanskim = .4;
			comp.loanmonth = getCurrentMonth();

			BFLOG(SYSTRACE, "Loan initialized - size: 10000  payback: "..comp.loanpayback.." skim: "..comp.loanskim..".");

			-- Give them their money
			giveCash(10000);	
		end
		
		comp.accept = 1;
		setglobalvar("challenge", nil);
		
	elseif (challenge == "decline") then
		BFLOG(SYSTRACE, "You declined!");
		setglobalvar("challenge", nil);
		
		setglobalvar("ventureloan_over", "true");
		return -1;
	end		
	
	if comp.accept == nil then
		if (challenge == nil) then
			local showchallengepanel = showchallengepanel("Challengetext:CHgrantmoney2");
			BFLOG(SYSTRACE, "I'm waiting for you to click accept or decline!");
			setglobalvar("challenge", "waiting");
		end	
	end

	if comp.accept == 1 then
		
		-- MAINTAIN THE LOAN
		
		BFLOG(SYSTRACE, "Checking loan...");
		-- Only if they currently have a loan
		if comp.loanactive ~= nil then
			local curMonth = getCurrentMonth();
			BFLOG(SYSTRACE, "Last loan month: "..comp.loanmonth.." current month: "..curMonth..".");

			-- If we have a new month to process
			if curMonth > comp.loanmonth then

				-- Figure out how much they profited last month
				local lastprofit = getProfit(comp.loanmonth);

				BFLOG(SYSTRACE, "Last month profit: "..lastprofit..".");

				if lastprofit > 0 then
					local skimamount = lastprofit * comp.loanskim;				
					-- Subtract this skim from their cash and loan payback
					takeCash(skimamount);

					BFLOG(SYSTRACE, "Paid back to loan: "..skimamount..".");				

					comp.loanpayback = comp.loanpayback - skimamount;

					-- If they have paid back their fair share
					if comp.loanpayback < 0 then

						-- Give them back the overpay
						local overpay = 0 - comp.loanpayback;
						giveCash(overpay);

						-- Now cancel the loan
						comp.loanactive = nil;
						BFLOG(SYSTRACE, "Loan has been completely repaid!");
					
						return 1;
					end
	
					-- If it's not paid off yet, then update the month
					comp.loanmonth = curMonth;
				else
					BFLOG(SYSTRACE, "Profit is negative or 0, so none of the loan was repaid.");
					comp.loanmonth = curMonth;
				end
			end
		end
	end
	
	return 0;
end


function completeventureloan(comp)

	BFLOG(SYSTRACE, "WE DID IT");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("ventureloan_over", "true");
		
	showchallengewin("Challengetext:CHgrantmoney2Failure");
	
	-- Increment the number of challenges completed
	local num = getglobalvar("numchallcomplete");
	if (num == nil) then
		num = 0;
	end
	local newnum = tonumber(num) + 1;
	BFLOG(SYSTRACE, "Setting number of challenges complete to: "..newnum..".");
	setglobalvar("numchallcomplete", tostring(newnum));

end

function failventureloan(comp)
	BFLOG(SYSTRACE, "DECLINED");
	
	setglobalvar("challengeactive", "false");
	
	-- Don't hit this challenge again.
	setglobalvar("ventureloan_over", "true");
end