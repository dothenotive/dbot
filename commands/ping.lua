require("util")
local helpText = "view the delay of the bot\nusage: "..prefix.."ping"

addCommand("ping", function(msg) 
	local new = msg:reply("pong")
	new:setContent("delay: `".. math.abs(round((new.createdAt - msg.createdAt) * 1000)) .." ms`")
end, helpText)

return helpText

