require("util")

local helpText = "remind me command. thats it\nusage: "..prefix.."remindme <timeInt>, <timeUnit>, [note]\nexample: `"..prefix.."remindme 10, s, test`\nwill wait for 10 seconds and then will send back the text you provided(which in my case, is test)"

local function settimer(message, args)
    if #args < 2 then
        message.channel:send("invalid usage, use /remindme <time>, <unit>, <note> (yes, with the comma)")
        return
    end

    local time = tonumber(args[1])
    local unit = args[2]
    if not time or not unit then
        message.channel:send("invalid usage, use "..prefix.."remindme <time>, <unit>, <note> (yes, with the comma)")
        return
    end

    local seconds
    local unit_full
    if unit == "s" then
        seconds = time
        unit_full = "second"
    elseif unit == "m" then
        seconds = time * 60
        unit_full = "minute"
    elseif unit == "h" then
        seconds = time * 60 * 60
        unit_full = "hour"
    elseif unit == "d" then
        seconds = time * 60 * 60 * 24
        unit_full = "day"
    else
        message.channel:send("invalid time unit, use `s`, `m`, `h`, or `d`.")
        return
    end

    if time == 1 then
        unit_full = unit_full
      else
        unit_full = unit_full .. "s"
      end

    local timestamp_now = os.time()
    message.channel:send("reminder scheduled for " .. time .. " " .. unit_full .. " on <t:" .. timestamp_now .. ":f>.")
    local note = args[3]
    if note == nil then
        note = "not specified"
    end
    local reminderMessage = "hey, you set a timer <t:" .. timestamp_now .. ":R>;" .. "\ntimer ended - " .. note

    local reminder = function()
        message.channel:send(reminderMessage)
    end
    timer.sleep(seconds * 1000)
    reminder()
end

addCommand("remindme", settimer, helpText)
addCommand("st", settimer, helpText)
return helpText
