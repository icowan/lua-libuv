function main()
	local server = uv.createServer()
	print(server)
	local count = 1
	server:listen('0.0.0.0', 8080, 
		function (socket, err) 
			if socket then
				print(count .. ': ')
				count = count + 1
				print(socket)
				
				socket:onData(
					function(socket, nread, data)
						if (nread >= 0) then
							print('received: ' .. data)
							socket:write('HTTP/1.1 200 OK\r\n')
							socket:write('Content-Type: text/plain\r\n')
							socket:write('\r\n')
							socket:write('Hello')
							socket:close()
							
						else
							print('error: ' .. socket .. ': ' .. data)
						end

						
					end
				)
			else
				print('got nil' .. err)
			end
			
		end
	)
	
	uv.loop()
	
end

function unittest1()
	local server = uv.createServer()
	server['listen']()
	
end
function unittest2()
	local server = uv.createServer()
	server['listen'](server)
	
end
function unittest3()
	local server = uv.createServer()
	server['listen'](server, '')
	
end
function unittest4()
	local server = uv.createServer()
	server['listen'](server, '', 8080)
	
end
function unittest5()
	local server = uv.createServer()
	server['listen'](server, '0.0.0.0', 8080)
	
end

print(pcall(unittest1))
print(pcall(unittest2))
print(pcall(unittest3))
print(pcall(unittest4))
print(pcall(unittest5))

main()
