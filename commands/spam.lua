local stop_spam = false

-- question for me: why?
-- dave, 19th jan 2021

local function spam_command(m)
  if m.author == client.owner then
    stop_spam = true
    m.channel:send("ok stopping")
  else
    m.channel:send("u cant")
    return
  end
end

addCommand("spam", function(m, args)
  if m.author == client.owner then
      stop_spam = false
    while not stop_spam do
      m.channel:send(args[1])
      timer.sleep(1000)
    end
  else
    m.channel:send("no")
    return
  end
  
end, "spam")

addCommand("stop", spam_command, "stop spam")