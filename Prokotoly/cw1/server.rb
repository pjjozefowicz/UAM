require 'socket'                 # Get sockets from stdlib
require_relative 'encryptor'

server = TCPServer.open(2000)    # Socket to listen on port 2000
loop {                           # Servers run forever
   client = server.accept        # Wait for a client to connect
   mode = Base64.decode64(client.gets.chomp)
   puts "encryption-mode: " + mode
   
   encrypted = Base64.decode64(client.gets.chomp)
   iv = Base64.decode64(client.gets.chomp)
   key = Base64.decode64(client.gets.chomp)

   encryptor = Encryptor.new
   encryptor.decrypt(encrypted, mode, iv, key)

   client.close                  # Disconnect from the client
}