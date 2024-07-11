require("util")
local helpText = "no, me-only commmand"

function command(m,args)
    if m.author ~= client.owner then return end
    m.channel:send("ok, shutting down\ncall with ./luvit b.lua")
    client:stop()
end

addCommand("exit", command, helpText)
return helpText
