require 'socket'
require 'json'

host = 'localhost'   #The web server
port = 2000           							#Default HTTP port
#path = "/index.html"								#The file we want
print "What kind of request (get/post): "
type = gets.chomp.upcase
print "What path: "
path = gets.chomp.downcase
#This is the HTTP request we sent to fetch a file
request = "#{type} #{path} HTTP/1.0\r\n\r\n"
if type == "POST"
	request = request.split("\r\n\r\n")[0]
	print "name: "
	name = gets.chomp
	print "email: "
	email = gets.chomp
	post = {viking: {name: name, email: email}}.to_json
	request += " Content-Length:#{post.size}"
	request += "secret123"
	request += post
	request += "\r\n\r\n"
end

socket = TCPSocket.open(host, port) 	#Connect to the server
socket.puts(request)									#Send request (I/O stream)
response = socket.read								#Read complete response
#Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)
print response														#And display it