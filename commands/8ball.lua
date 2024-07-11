require("util")
local helpText = "8ball.\ndas it. usage: "..prefix.."8ball <question>"

-- i lvoe sex
local answers = {
    "it is certain",
    "it is decidedly so",
    "without a doubt",
    "yes, definitely",
    "you may rely on it",
    "as i see it, yes",
    "most likely",
    "outlook good",
    "yes",
    "signs point to yes",
    "reply hazy, try again",
    "better not tell you now",
    "ask again later",
    "cannot predict now",
    "concentrate and ask again",
    "don't count on it",
    "outlook not so good",
    "my sources say no",
    "very doubtful",
    "no"
}
addCommand("8ball", function(m, args)
    if #args == 0 then
        m.channel:send("where question")
        return
    end
    if args[1] == "" then
        m.channel:send("where question")
        return
    end
    if not args then
        m.channel:send("where question")
        return
    end
    local answer = answers[math.random(1, #answers)]

    m.channel:send(answer)
end, helpText)

return helpText