ESX = nil 
TriggerEvent(Config.ESXTrigger, function(obj) ESX = obj end)


RegisterServerEvent('zcmg_job:mudarjob')
AddEventHandler('zcmg_job:mudarjob', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
	
	for k, v in pairs(Config.Jobs) do
		if xPlayer.identifier == v.steamid then
			if job == v.Job1 then
				xPlayer.setJob(v.Job2 , v.Grade2)	
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "CENTRO DE EMPREGO", "Mudas-te de emprego para: <b>"..xPlayer.job.label.."</b>", 5000, 'sucesso')
			elseif job == v.Job2  then
				xPlayer.setJob(v.Job1, v.Grade1)
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "CENTRO DE EMPREGO", "Mudas-te de emprego para: <b>"..xPlayer.job.label.."</b>", 5000, 'sucesso')
			else
				xPlayer.setJob(v.Job1, v.Grade1)
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "CENTRO DE EMPREGO", "Mudas-te de emprego para: <b>"..xPlayer.job.label.."</b>", 5000, 'sucesso')
			end
				
		else
			TriggerClientEvent('zcmg_notificacao:Alerta', source, "CENTRO DE EMPREGO", "Não tem premisões para fazer isto!", 5000, 'erro')
		end
	end
end)

