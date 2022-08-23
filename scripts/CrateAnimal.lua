function CrateAnimal(args)
   if args ~= nil then
      BFLOG(SYSMSG, "args is "..table.getn(args).." elements")
      local firstarg = args[1]
      if firstarg ~= nil then
         local subjecthandle = firstarg.value
         if subjecthandle ~= nil then
            local subject = resolveTable(subjecthandle)
            if subject ~= nil then
               subject:BFG_SEND_SIGNAL_SHARED("ZT_CRATE_ENTITY")
            else
               BFLOG(SYSERROR, "couldn't resolve subject entity pointer")
            end
         else
            BFLOG(SYSERROR, "couldn't resolve subject handle")
         end
      else
         BFLOG(SYSERROR, "couldn't parse first argument")
      end
   end
	
   return "complete"
end

