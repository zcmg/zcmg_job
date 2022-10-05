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

PerformHttpRequest('https://raw.githubusercontent.com/zcmg/'..GetCurrentResourceName()..'/main/fxmanifest.lua', function(code, res, headers)
	local version = GetResourceMetadata(GetCurrentResourceName(), 'description')
	local versao = ''
	local update = ''

	if res ~= nil then
		local t = {}
		for i = 1, #res do
			t[i] = res:sub(i, i)
		end
		versao = t[73]..t[74]..t[75]..t[76]

		if versao == version then
			update = "Ultima Versão"
		else
			update = "^2Precisa de atualizar^1"
		end

	else
		update = "Impossivel verificar a versão"
	end

	

	print(([[^1--------------------------------------------------------------------------
	███████╗ ██████╗███╗   ███╗ ██████╗      ██████╗ ██████╗ ██████╗ ███████╗
	╚══███╔╝██╔════╝████╗ ████║██╔════╝     ██╔════╝██╔═══██╗██╔══██╗██╔════╝
	  ███╔╝ ██║     ██╔████╔██║██║  ███╗    ██║     ██║   ██║██████╔╝█████╗  
	 ███╔╝  ██║     ██║╚██╔╝██║██║   ██║    ██║     ██║   ██║██╔══██╗██╔══╝  
	███████╗╚██████╗██║ ╚═╝ ██║╚██████╔╝    ╚██████╗╚██████╔╝██║  ██║███████╗
	╚══════╝ ╚═════╝╚═╝     ╚═╝ ╚═════╝      ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ 
	-----------------------^0https://www.github.com/zcmg/^1----------------------- 
	
	--------------------------------------------------------------------------
	-- ESX DEVELOPER PORTUGAL (^0https://discord.gg/Qt5WraEMxf^1)
	-- Versão: %s (%s)
	--------------------------------------------------------------------------^0]]):format(versao, update))

end,'GET')


