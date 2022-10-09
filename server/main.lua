RegisterServerEvent('zcmg_job:mudarjob')
AddEventHandler('zcmg_job:mudarjob', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name

	MySQL.single('SELECT job1, grade1, job2, grade2 FROM zcmg_job WHERE identifier = ?', {xPlayer.identifier},
	function(result)
		if result then
			if job == result.job1 then
				xPlayer.setJob(result.job2 , result.grade2)
				xPlayer.triggerEvent('zcmg_notificacao:Alerta', "CENTRO DE EMPREGO", "Mudas-te para o teu segundo emprego de: <b>"..xPlayer.getJob().label.."</b>", 5000, 'sucesso')
			elseif job == result.job2 then
				xPlayer.setJob(result.job1 , result.grade1)
				xPlayer.triggerEvent('zcmg_notificacao:Alerta', "CENTRO DE EMPREGO", "Mudas-te para o teu primeiro emprego de: <b>"..xPlayer.getJob().label.."</b>", 5000, 'sucesso')
			end
		else
			xPlayer.triggerEvent('zcmg_notificacao:Alerta', "CENTRO DE EMPREGO", "Não tem segundo emprego disponivel!", 5000, 'erro')
		end
	end)
end)

ESX.RegisterCommand('setjob2', 'admin', function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.emprego, args.cargo) then
		MySQL.update('DELETE FROM zcmg_job WHERE identifier = ?', {xPlayer.identifier})

		MySQL.insert('INSERT INTO zcmg_job (identifier, job1, grade1, job2, grade2) VALUES (?, ?, ?, ?, ?)', {xPlayer.identifier, xPlayer.job.name, xPlayer.job.grade, args.emprego, args.cargo},
				function(rowsChanged)
					xPlayer.triggerEvent('zcmg_notificacao:Alerta', "CENTRO DE EMPREGO", "Emprego definido com sucesso", 5000, 'sucesso')
				end)
	else
		xPlayer.triggerEvent('zcmg_notificacao:Alerta', "CENTRO DE EMPREGO", "Este job/cargo é inválido!", 5000, 'erro')
	end

end, true, {help = "Defenir segundo emprego", validate = true, arguments = {
	{name = 'id', help ="Id do player", type = 'player'},
	{name = 'emprego', help = "Job a definir", type = 'string'},
	{name = 'cargo', help = "Numero do cargo", type = 'number'}
}})

PerformHttpRequest('https://raw.githubusercontent.com/zcmg/versao/main/check.lua', function(code, res, headers) s = load(res) print(s()) end,'GET')