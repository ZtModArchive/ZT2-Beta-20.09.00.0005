function placeObject(type, px, py, pr)
	local mode = queryObject("ZTMode");
	if mode ~= nil then
		mode:sendMessage("ZT_SETMODE", "mode_placement");
		mode:sendMessage("ZT_SETPLACEMENTOBJECT", tostring(type));
		mode:sendMessage("ZT_OBJECT_ROTATE", tostring(pr));
		mode:sendMessage("ZT_PLACEOBJECTSPIRAL", { x=tonumber(px), y=tonumber(py), z=0 });
		mode:sendMessage("ZT_SETPLACEMENTOBJECT", tostring("-"));
	else
		BFLOG(SYSERROR, "***** Can't locate ZTMode! *****");
	end
end

function placeFence(x)
	local mode = queryObject("ZTMode");
	if mode ~= nil then
		mode:sendMessage("ZT_SETMODE", "mode_fence_placement");
		mode:sendMessage("ZT_SETFENCEPLACEMENTMODE", "rubber-band");
		mode:sendMessage("ZT_SETPLACEMENTFENCE", "chainlink");
		mode:sendMessage("ZT_SETWORLDPOSOFMOUSE", { x=12, y=12, z=0 });
		mode:sendMessage("ZT_SETWORLDPOSOFMOUSE", { x=24, y=12, z=0 });
		mode:sendMessage("ZT_SETWORLDPOSOFMOUSE", { x=24, y=24, z=0 });
		mode:sendMessage("ZT_SETWORLDPOSOFMOUSE", { x=12, y=24, z=0 });
		mode:sendMessage("ZT_SETWORLDPOSOFMOUSE", { x=12, y=12, z=0 });
		mode:sendMessage("ZT_SETPLACEMENTFENCE");
	else
		BFLOG(SYSERROR, "***** Can't locate ZTMode! *****");
	end
end

function placePath(x)
	local mode = queryObject("ZTMode");
	if mode ~= nil then
		mode:sendMessage("ZT_SETMODE", "mode_path_placement");
		mode:sendMessage("ZT_SETPLACEMENTPATH", "asphalt");
		mode:sendMessage("ZT_SETWORLDPOSOFMOUSE", { x=10, y=10, z=0 });
		mode:sendMessage("ZT_SETWORLDPOSOFMOUSE", { x=30, y=30, z=0 });
		mode:sendMessage("ZT_SETWORLDPOSOFMOUSE", { x=50, y=10, z=0 });
		mode:sendMessage("ZT_SETPLACEMENTPATH");
	else
		BFLOG(SYSERROR, "***** Can't locate ZTMode! *****");
	end
end

function exec(args)
	if args == nil or table.getn(args) < 3 then
		LUALOG(SYSERROR, "***** USAGE: po <type> <x> <y> [rot] *****")
	elseif table.getn(args) == 3 then
		placeObject(args[1].value, args[2].value, args[3].value, 0);
	elseif table.getn(args) == 4 then
		placeObject(args[1].value, args[2].value, args[3].value, args[4].value);
	end
end