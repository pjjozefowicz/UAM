require 'openssl'
require 'base64'
require 'socket'                 # Get sockets from stdlib
require 'openssl'

server = TCPServer.open(2000)    # Socket to listen on port 2000
loop {                           # Servers run forever
    puts "Waiting for connection..."
    client = server.accept        # Wait for a client to connect

    dsa = OpenSSL::PKey::DSA.new(2048)

    pub_key = dsa.public_key # has only the public part available
    pub_key_der = pub_key.to_der # it's safe to publish this

    client.puts Base64.strict_encode64(pub_key_der)

    puts "Your message to Bob?\n"
    msg = gets.chomp
    
    digest = OpenSSL::Digest::SHA1.digest(msg)
    sig = dsa.syssign(digest)

    client.puts Base64.strict_encode64(msg)
    client.puts Base64.strict_encode64(sig)

    client.close                  # Disconnect from the client
}

