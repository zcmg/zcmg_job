Config = {}

Config.Jobs = {
	{steamid ="steam:11000010064f1d9", Job1 = "police", Job2 = "ambulance", Grade1 = 1, Grade2=3},
}


ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterCommand("job", function(source, args, rawCommand)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
	
	for k, v in pairs(Config.Jobs) do
		if xPlayer.identifier == v.steamid then
			if job == v.Job1 then
				xPlayer.setJob(v.Job2 , v.Grade2)	
			elseif job == v.Job2  then
				xPlayer.setJob(v.Job1, v.Grade1)
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Não tem premisões para fazer isto!"}, color = 255,255,255 })
		end
	end
end, true)

