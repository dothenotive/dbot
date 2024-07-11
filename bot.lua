local file1 = io.open("token.txt", "r")
local token = file1:read("*line")
file1:close()
_G.getKey = function()
    return token
end

print("sex")
_G.fs = require("fs")
_G.timer = require("timer")
print("sex 2")
_G.discordia = require("discordia")
_G.json = require("json")
_G.path = require("path")
print("sex 3")
_G.uv = require("uv")
_G.client = discordia.Client()
client:enableIntents(discordia.enums.gatewayIntent.messageContent)
_G.prefix = "prefix/"
_G.Http = require("coro-http")
_G.request = Http.request

discordia.extensions.string()

local authorizedUsers = {}
local authFilePath = "/whitelist.txt"
local file = io.open(authFilePath, "r")
if file then
    for line in file:lines() do
        table.insert(authorizedUsers, line)
    end
    file:close()
end

_G.bot_blacklist = {}
_G.bot_blacklistFilePath = "blacklist.txt"
_G.bot_bl_file = io.open(bot_blacklistFilePath, "a+")
bot_bl_file:close()
bot_bl_file = io.open(bot_blacklistFilePath, "r")
local operatorUsers = {}
local operatorFilePath = "operators.txt"
local operatorFile = io.open(operatorFilePath, "r")

if operatorFile then
    for line in operatorFile:lines() do
        table.insert(operatorUsers, line)
    end
    operatorFile:close()
end

_G.isOperator = function(author)
    for _, id in ipairs(operatorUsers) do
        if id == author.id then
            return true
        end
    end
    return false
end

_G.canExecuteRiskyCommands = function(author)
    return isOperator(author)
end

if bot_bl_file then
    for line in bot_bl_file:lines() do
        table.insert(bot_blacklist, line)
    end
    bot_bl_file:close()
end

_G.addOperator = function(author)
    table.insert(operatorUsers, author.id)
    local operatorFile = io.open(operatorFilePath, "a")
    if operatorFile then
        operatorFile:write(author.id .. "\n")
        operatorFile:close()
    end
end

_G.addAuthorizedUser = function(author)
    table.insert(authorizedUsers, author.id)
    local file = io.open(authFilePath, "a")
    if file then
        file:write(author.id .. "\n")
        file:close()
    end
end

local function isAuthorized(author)
    for _, id in ipairs(authorizedUsers) do
        if id == author.id then
            return true
        end
    end
    return false
end

_G.commands = {}

function _G.addCommand(actname, func, help)
    help = help or "not specified"
    local name = string.lower(actname)
    local aaazxc = function(m)
        local arglist = m.content:sub(#prefix + #name + 2):split(", ")
        func(m, arglist)
        return true
    end
    commands[name] = aaazxc
    print(string.format('loaded command %s, with the help message "%s"\n', name, help))
end

function callCommand(m)
    local ending = string.find(m.content, " ")
    local command = string.sub(m.content, #prefix + 1, (ending and ending - 1) or nil)
    if string.sub(m.content, 1, #prefix) ~= prefix then return end

    if command == "authenticate" then
        if not canExecuteRiskyCommands(m.author) then m.channel:send("unauthorized")return end
        local __uid = m.author.id
        _G.__whitelist = {}
        local __file = io.open("whitelist.txt", "r")

        if __file then
            for line in __file:lines() do
                __whitelist[line] = true
            end
            __file:close()
        end

        if __whitelist[__uid] then
            m.channel:send("he already in wl")
            return
        end

        local key = string.sub(m.content, ending + 2)

        if key == "tempkey" then
            addAuthorizedUser(m.author)
            m.channel:send("wl auth success, have fun")
        else
            m.channel:send("wl auth failed")
        end
    elseif isAuthorized(m.author) then
        commands[command](m) 
    end
end

client:on("messageCreate", function(m)
    callCommand(m)
end)

local f = io.popen("dir /b commands", "r")
for command in f:lines() do
    local f, e = loadfile("commands/" .. command)
    if not f then
        print("error loading " .. command .. ": " .. e)
    else
        setfenv(f, _G)
        local func, err = pcall(f)
        if not func then
            print("error! " .. err)
        end
    end
end

client:run(getKey(), {afk = true})

client:once("ready", function()
    print("ready!\nlogged in as " .. client.user.username .. " bot")
end)
