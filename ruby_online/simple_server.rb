require 'socket'
require 'json'

server = TCPServer.open(2000)
loop{
	client = server.accept
	input = client.gets
	request,body = input.split("secret123", 2)
	type = request.split[0].upcase
	path = request.split[1].downcase
	path[0] = "" if path[0] == "/"
	case type
	when "GET"
		case path
		when "index.html"
			response = "HTTP/1.0 200 OK\n"
			File.open("index.html") do |f|
				response += "Content-Length: #{f.size}"
				response += "\r\n\r\n"
				response += f.readlines.join
			end
			client.puts response
		else
			response = "HTTP/1.0 404 Not Found\r\n\r\n"
			response += "The requested page could not be found."
			client.puts response
		end
	when "POST"
		params = JSON.parse(body)
		params_parse = ""
		thanks = ""
		File.open("thanks.html") do |f|
			thanks = f.readlines.join()
		end
		params.each do |key, value|
			value.each do |inner_key, inner_value|
				params_parse += "<li>#{inner_key}: #{inner_value}</li>\n"
			end
		end
		thanks.gsub!(/<%=\s*yield\s*%>/, params_parse)
		client.puts thanks
	else
		client.puts "Closing the connection. Bye!"
	end
	client.close
}