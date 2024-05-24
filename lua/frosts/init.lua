require("frosts.remap")
require("frosts.set")

local open = io.open

local function write_file(hey, text)
	local file = open(hey, "w")
	if not file then return nil end
	file:write(text)
	file.close()
end

local function read_file(hey)
    local file = open(hey, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

currentdate = os.date('%Y-%m-%d')

currentYear = os.date('%Y')
currentMonth = os.date('%m')
currentDay = os.date('%d')

lastDate = read_file("/home/frosty/.config/nvim/lua/frosts/.lastdate.txt")

lastDateArray = {}

for token in string.gmatch(lastDate, "([^-]+)") do
	table.insert(lastDateArray, token)
end


lastYear = lastDateArray[1]
lastMonth = lastDateArray[2]
lastDay = lastDateArray[3]

local function timeSince()
	daysSince = 0
	yearsSince = 0
	monthsSince = 0

	if (tonumber(currentYear) - tonumber(lastYear)) > 0 then
		months = 12-tonumber(lastMonth)
		daysSince = daysSince + months*30
		daysSince = daysSince + ((tonumber(currentYear)-tonumber(lastYear))-1)*365
		daysSince = daysSince + tonumber(currentMonth)*30
	else
		if(tonumber(currentMonth)-tonumber(lastMonth)) > 0 then
			daysSince = (tonumber(currentMonth)-tonumber(lastMonth))*30
			daysSince = daysSince + tonumber(currentDay)
		else
			daysSince = tonumber(currentDay)-tonumber(lastDay)
	end
end

	yearsSince = math.floor(daysSince/365)
	daysSince = daysSince - yearsSince*365
	monthsSince = math.floor(daysSince/30)
	daysSince = daysSince - monthsSince*30
	return {daysSince, monthsSince, yearsSince}
end


daySince = timeSince()[1]
monthsSince = timeSince()[2]
yearsSince = timeSince()[3]

local function toDo()
    agenda = read_file("/home/frosty/.agenda.txt")
    if agenda == nil or agenda == "" then
        print("\nYou have nothing on your agenda right now, frosty :)")
    else
        print("\nYou have a thing or two on your agenda today! Check it out:\n\n")
        print(agenda)
    end
end

local function Greeting()
	math.randomseed(os.time())
	comingBack = {"Wow, missed me already huh?", "Back for more today, eh frosty?", "Don't you ever do anything else??"}
	nextDay = {"A new day, a new program :)", "Hey frosty, thanks for choosing me today!", "Friendly neighborhood text editor, at your service ;)", "Heeeyyyyy didn't I see you just yesterday? I knew ya liked me..."}
	sameWeek = {"Welcome back, frosty! Have a nice break?", "Always nice to see you here, handsome :)", "Nice to C ya! Hehee...you are coding in C today, right? RIGHT???"}
	nextWeek = {"Wow, it's been a whooooole week and you haven't even dropped by to say hi. Shameful, frosty.", "A whole week. A whole FUCKING WEEK, FROSTY!! ARE YOU SEEING OTHER TEXT EDITORS?? I BET IT'S THAT SLUT, VISUAL STUDIO >:[", "Wow, just wow. A whole week. Hope you had a nice vacation you fucking degenerate"}
	sameMonth = {"You really just went over a week without touching me, didn't you? Are you ill??", "Y'know, I was mad last week, but after having some time to reflect...welcome back, frosty. I missed you <3", "I'm so glad to finally see you again!! Let's catch up and code together :))"}
	nextMonth = {"It's been a whole damn month, frosty! AT LEAST WRITE ME A LETTER NEXT TIME, I MISSED YOU!!", "Oh man this reunion was loooooooong overdue! Glad to have ya back, frosty :)", "A whole month..it's about time you found your way back, handsome :)"}
	afterThat = {"Don't you ever leave me for that long ever again or I swear to Moolenar I'll deprecate every damn library you ever even considered importing. Don't. Test. Me.", "I never thought I'd see you again...welcome home, frosty <3"}
	if yearsSince == 0 and daysSince == 0 and monthsSince == 0 then
		print(comingBack[math.random(1, #comingBack)])
	end
	if yearsSince == 0 and daysSince == 1 and monthsSince == 0 then
		print(nextDay[math.random(1, #nextDay)])
	end
	if yearsSince == 0 and daysSince > 1 and daysSince < 7 and monthsSince == 0 then
		print(sameWeek[math.random(1, #sameWeek)])
	end
	if yearsSince == 0 and daysSince >= 7 and daysSince < 14 and monthsSince == 0 then
		print(nextWeek[math.random(1, #nextWeek)])
	end
	if yearsSince == 0 and daysSince >= 14 and monthsSince == 0 then
		print(sameMonth[math.random(1, #sameMonth)])
	end
	if yearsSince == 0 and monthsSince == 1 then
		print(nextMonth[math.random(1, #nextMonth)])
	end
	if yearsSince == 0 and monthsSince > 1 then
		print(afterThat[math.random(1, #afterThat)])
	end
	if yearsSince == 1 then
		print("It's been a whole year, frosty..and I missed you a ton! \nLet's code something reunion worthy today :D")
	end
	if yearsSince > 1 then
		print("After all this time, you finally came back to me...and you look so different!! I've missed you, frosty~ \n stick around this time..pretty please?")
	end
end

Greeting()
toDo()

write_file("/home/frosty/.config/nvim/lua/frosts/.lastdate.txt", os.date('%Y-%m-%d'))

