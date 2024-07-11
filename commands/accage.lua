require("util")
local helpText = "gets the account age of the mentioned user/userid\nusage: "..prefix.."accage @user"

-- my first command
-- proud of it :blush:

addCommand("accage", function(m, args)
    if args[1] then 
        local user = m.mentionedUsers.first or client:getUser(args[1])
        if user then
            m.channel:send(user.tag.."'s acc was created on "..os.date("%m/%d/%Y at %I:%M:%S%p", user.createdAt))
        else
            m.channel:send("invalid user/user ID")
        end
    end 
end, helpText)

return helpText