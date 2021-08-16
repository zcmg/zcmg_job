Config = {}
Config.Steams = {  --Steam ids de quem pode mudar o job
	{id ="steam:11000010064f1d9"}, -- Steam ID zcmg
	{id ="steam:11000010067f1d8"}
}

Config.Job1 = "taxi"
Config.Job2 = "ambulance"


ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--[[
Função Job
]]
function job(source, args, rawCommand)
	 local _source = source
     	 local xPlayer = ESX.GetPlayerFromId(_source)
     	 local job = xPlayer.job.name
	 local grade = xPlayer.job.grade
	
	if job == Config.Job1 then
		xPlayer.setJob(Config.Job2 , grade)	
	else if job == Config.Job2  then
		xPlayer.setJob(Config.Job1, grade)
	end


--[[
Mudar job
]]--
RegisterCommand("job", function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local ver = false
		
		for k, v in pairs(Config.Steams) do
			if xPlayer.identifier == v.id then
				ver = true
				break
			else
				ver = false
			end
		end
		
		if ver then
			job(source, args, rawCommand)
		else
			erro(source)
		end
end, true)


