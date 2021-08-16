Config = {}
Config.Steams = {  --Steam ids de quem pode mudar o job
	{id ="steam:11000010064f1d9"}, -- Steam ID zcmg
	{id ="steam:11000010067f1d8"}
}

ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--[[
Função Job
]]
function job(source, args, rawCommand)
		if (args[1] == nil) then
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Têm que preencher os parametros para poder gerar o código." }, color = 255,255,255 })
		elseif (args[1] ~= nil and args[2] == nil) then
			if (args[1] == "bank" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa bank 'montante'" }, color = 255,255,255 })
			elseif (args[1] == "black_money" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa black_money 'montante'" }, color = 255,255,255 })
			elseif (args[1] == "cash" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa cash 'montante'" }, color = 255,255,255 })
			elseif (args[1] == "item" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa item 'nome spawn item' 'quantidade items'" }, color = 255,255,255 })
			elseif (args[1] == "weapon" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa weapon 'nome spawn arma' 'numero_balas'" }, color = 255,255,255 })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Tipo desconhecido. Tipos possíveis: item, cash, bank, black_money, weapon" }, color = 255,255,255 })
			end	
		elseif (string.lower(args[1]) == "bank") then -- Banco
			RandomCode = RandomCodeGenerator()
			MySQL.Async.execute("INSERT INTO recompensa(code, type, data1) VALUES (@code,@type,@data1)", {
				['@code'] = RandomCode,
				['@type'] = "bank", 
				['@data1'] = args[2]
			})
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
			exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')	
			Wait(5)
			RandomCode = ""
		elseif (string.lower(args[1]) == "black_money") then -- Dinheiro Sujo
			RandomCode = RandomCodeGenerator()
			MySQL.Async.execute("INSERT INTO recompensa(code, type, data1) VALUES (@code,@type,@data1)", {
				['@code'] = RandomCode,
				['@type'] = "black_money", 
				['@data1'] = args[2]
			})
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
			exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')	
			Wait(5)
			RandomCode = ""
		elseif (string.lower(args[1]) == "cash") then -- Dinheiro
			RandomCode = RandomCodeGenerator()
			MySQL.Async.execute("INSERT INTO recompensa (code, type, data1) VALUES (@code,@type,@data1)", {
				['@code'] = RandomCode,
				['@type'] = "cash", 
				['@data1'] = args[2]
			})
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
			exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')
			Wait(5)
			RandomCode = ""
		elseif (string.lower(args[1]) == "weapon") then -- Arma
			if (args[2] == nil or args[3] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos." }, color = 255,255,255 })
			else
				--Codigo em costrução V1.1 Ainda por testar
				--[[
				if (args[3] == "weapon_dagger" or args[3] == "weapon_bat" or args[3] == "weapon_bottle" or args[3] == "weapon_crowbar" or args[3] == "weapon_flashlight" or args[3] == "weapon_golfclub"
				    or args[3] == "weapon_hammer" or args[3] == "weapon_hatchet" or args[3] == "weapon_knuckle" or args[3] == "weapon_hammer" or args[3] == "weapon_hammer" or args[3] == "weapon_hammer")
					--Gerar o código	
				else
					TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Tipo de arma não é válido." }, color = 255,255,255 })
				end
				--]]
				-- Fim V1.1
			
				RandomCode = RandomCodeGenerator()
				MySQL.Async.execute("INSERT INTO recompensa (code, type, data1, data2) VALUES (@code,@type,@data1,@data2)", {
					['@code'] = RandomCode,
					['@type'] = "weapon", 
					['@data1'] = args[2],
					['@data2'] = args[3]
				})
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
				exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')
				Wait(5)
				RandomCode = ""
			end
		elseif (string.lower(args[1]) == "item") then -- Item
			if (args[2] == nil or args[3] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos." }, color = 255,255,255 })
			else
				RandomCode = RandomCodeGenerator()
				MySQL.Async.execute("INSERT INTO recompensa (code, type, data1, data2) VALUES (@code,@type,@data1,@data2)", {
					['@code'] = RandomCode,
					['@type'] = "item", 
					['@data1'] = args[2],
					['@data2'] = args[3]
				})
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
				exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')
				Wait(5)
				RandomCode = ""
			end		
		end
end	

function erro(source)
	TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Não tem premisões para fazer isto!"}, color = 255,255,255 })
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


