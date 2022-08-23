function logTime(state, time)
	logMessage = string.format("***** %s load time: %.2f seconds *****", state, time)	
	LUALOG(SYSNOTE, logMessage)
end
	
function onLoadBegin(time)
	startTime = time
	logTime("Start", time)
end

function onLoadEnd(time)
	logTime("End", time)
	logTime("Elapsed", time - startTime)
end
