require 'openssl'
require 'base64'
require 'socket'                 # Get sockets from stdlib
require_relative 'dh'

server = TCPServer.open(2000)    # Socket to listen on port 2000
loop {                           # Servers run forever
    puts "Waiting for connection..."
    client = server.accept        # Wait for a client to connect

    der = Base64.decode64(client.gets.chomp)
    dh2 = OpenSSL::PKey::DH.new(der)

    puts "Generating keys..."
    dh2.generate_key!

    puts "Sending public key to Bob: " + dh2.pub_key.to_s
    client.puts dh2.pub_key

    dh1_pub_key = OpenSSL::BN.new(client.gets.chomp)
    puts "Bob's public key: " + dh1_pub_key.to_s

    symm_key = dh2.compute_key(dh1_pub_key)
    puts "Symmetric key obtained!"

    mode = Base64.decode64(client.gets.chomp)
    puts "encryption-mode: " + mode

    encrypted = Base64.decode64(client.gets.chomp)
    iv = Base64.decode64(client.gets.chomp)

    encryptor = DHEncryptor.new
    encryptor.decrypt(encrypted, mode, iv, symm_key)

    client.close                  # Disconnect from the client
}

