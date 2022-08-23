include "scenario/scripts/economy.lua"

function getNearestCompostBin(keeper, compostBins)
	if keeper == nil or compostBins == nil or table.getn(compostBins) <= 0 then
		return nil;
	end
	local pos2 = keeper:BFG_GET_ENTITY_POSITION()
	local nearestBin
	--LUALOG(SYSNOTE, string.format("***** Keeper: x=%.1f, y=%.1f, z=%.1f *****", pos2.x, pos2.y, pos2.z))
	for i,v in ipairs(compostBins) do
		local bin = resolveTable(v.value)
		if bin ~= nil then
			local pos1 = bin:BFG_GET_ENTITY_POSITION()
			if pos1 == nil or pos2 == nil then
				break
			end
			--LUALOG(SYSNOTE, string.format("***** Compost Bin %d: x=%.1f, y=%.1f, z=%.1f *****", i, pos1.x, pos1.y, pos1.z))
			local dx = pos2.x - pos1.x
			local dy = pos2.y - pos1.y
			bin.dist_squared = dx*dx + dy*dy
			if nearestBin == nil or bin.dist_squared < nearestBin.dist_squared then
				nearestBin = bin
			end
		end
	end
	return nearestBin
end
		
function sellCompostInternal(pooLevel)
	local fullPrice = 500.00
	local salePrice = fullPrice * pooLevel
	--LUALOG(SYSNOTE, string.format("***** Selling Compost: PooLevel [%.1f], Sale Price [%.1f] *****", pooLevel, salePrice))
	giveCashNoPopup(salePrice)	
end

function sellCompost(args)
	if args == nil or table.getn(args) < 2 then
		return
	end
	local gameMgr = queryObject("BFGManager")
	if gameMgr ~= nil then
		local bin = resolveTable(args[2].value)
		if bin ~= nil then
			local pooLevelMax = 100
			local pooLevel = bin:BFG_GET_ATTR_FLOAT("f_PooLevel")
			sellCompostInternal(pooLevel / pooLevelMax)
			bin:BFG_SET_ATTR_FLOAT{ "f_PooLevel", 0 }
		end
	end
end

function adjustAndSellCompost(nearestBin, poo)
	local pooAdjustScalar = 5.0
	local pooAdjust = { 
		Poop_BigCat = 3,
		Poop_Bird = 1,
		Poop_Large = 3,
		Poop_Medium = 2,
		Poop_Rhinoceros = 3,
		Poop_Small = 1,
		Poop_Ungulate = 2
	}
	local pooLevelMax = 100
	local pooLevel = nearestBin:BFG_GET_ATTR_FLOAT("f_PooLevel")
	local pooBinderType = poo:BFG_GET_BINDER_TYPE()
	pooLevel = pooLevel + pooAdjust[pooBinderType] * pooAdjustScalar	
	if pooLevel >= pooLevelMax then
		sellCompostInternal(1.0)
		pooLevel = pooLevel - pooLevelMax
	end
	nearestBin:BFG_SET_ATTR_FLOAT{ "f_PooLevel", pooLevel }
	--LUALOG(SYSNOTE, "***** Poo Level Adjusted to ["..pooLevel.."] *****")
end

function CompostPoo(args)
	if args == nil or table.getn(args) < 2 then
		return
	end
	local gameMgr = queryObject("BFGManager")
	if gameMgr ~= nil then
		local nearestBin = getNearestCompostBin(resolveTable(args[1].value), gameMgr:BFG_GET_ENTITIES("compost_df"))
		if nearestBin ~= nil then
			adjustAndSellCompost(nearestBin,resolveTable(args[2].value))
		end
	end
end
