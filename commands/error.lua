require("util")

local helpText = "crashes the fuckin gbot\nonly i can use it"

addCommand("error",function(m, args)
    if m.author == client.owner then
        error("test")
    else
        m.channel:send("no")
    end

end, helpText)

return helpText
