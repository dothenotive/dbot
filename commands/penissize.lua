local function penissize()
    local size = math.random(1, 15)
    local penis = string.rep("=", size)
    return "8" .. penis .. "D"
end

local helpText = "bruh\nusage: "..prefix.."penissize <@user/UID>"

addCommand("penissize", function(m, args)
    local user = m.mentionedUsers:toArray()[1]
    if args[1] == '<@' .. client.owner.id .. '>' then
        m.channel:send(user.mentionString..' penis size is 8=====================================================================D')
        return
    end
    if args[1] == '<@' .. "948552193122914364" .. '>' then
        local size = math.random(1, 4)
        local penis = string.rep("=", size)
        m.channel:send(user.mentionString..' penis size is 8'..penis.."D")
        return
    end
    if args[1] == '<@' .. "941839817338146836" .. '>' then
        local size = math.random(60, 70)
        local penis = string.rep("=", size)
        m.channel:send(user.mentionString..' penis size is 8'..penis.."D")
        return
    end
    if user then
        local pp = penissize()
        m.channel:send(string.format("%s penis size is %s", user.mentionString, pp))
    else
        m.channel:send("where user mention")
    end
end, helpText)

return helpText