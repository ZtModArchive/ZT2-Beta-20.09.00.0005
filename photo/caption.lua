-- lua file for captioning pictures

function getEntityInstanceData(e, var)
	local luadi = e:getEDI()
	if (luadi) then
		local value = luadi:getVar(var)
		--BFLOG(SYSNOTE, var.." (var)= "..value)
		return value
	else
		--BFLOG(SYSNOTE, "no BFAIEntityDataInstance found")
	end
	return 0.0
end

function generateCaption(pt)
	--BFLOG(SYSNOTE, "start of generateCaption")
	local caption = pt:localize("ZTPhotoMode:default_photo_caption")
	local dist = 100000000
	local e = pt:getFirstInterestingEntity()
	local closestEntity
	while e do
		local ename = getEntityInstanceData(e, "s_name")
		if (ename ~= nil) then
			--BFLOG(SYSNOTE, "entity: "..ename)
			local pa = e:getPAC()
			if (pa) then
				--BFLOG(SYSNOTE, "entity distFromCamera = "..pa:getDistFromCamera())
				if (not pa.obscured) then
					local thisdist = pa:getDistFromCamera()
					--BFLOG(SYSNOTE, "dist = "..thisdist)
					if (thisdist and thisdist < dist) then
						--BFLOG(SYSNOTE, "found closer entity at "..thisdist);
						closestEntity = e
						dist = thisdist
					end
				end
			end
		end
		e = pt:getNextInterestingEntity()
	end
	if (closestEntity) then
		local entityname = getEntityInstanceData(closestEntity, "s_name")
		--BFLOG(SYSNOTE, "closest entity: "..entityname)
		if (entityname) then
			caption = entityname
		end
	end
	--BFLOG(SYSNOTE, "caption to be "..caption)
	return caption
end
