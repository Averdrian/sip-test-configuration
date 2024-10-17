-- local sip_auth_username = event:getHeader("sip_auth_username")
-- local network_addr = event:getHeader("network_addr")

-- -- Aquí puedes añadir el código que desees ejecutar
-- freeswitch.consoleLog("INFO", "El usuario " .. sip_auth_username .. " se ha registrado desde " .. network_addr .. "\n")

-- -- Por ejemplo, escribir en un archivo de log
-- local file = io.open("/var/log/freeswitch/register.log", "a")
-- if file then
--   file:write("Usuario " .. sip_auth_username .. " registrado desde " .. network_addr .. "\n")
--   file:close()
-- else
--   freeswitch.consoleLog("ERR", "No se pudo abrir el archivo de log\n")
-- end


local i = 0

while i < 500 do
    -- freeswitch.consoleLog("Hola mundo")
    print("Hola mundo")
    i = i + 1
end