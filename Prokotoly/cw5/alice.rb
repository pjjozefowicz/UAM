require 'socket'                 # Get sockets from stdlib
require 'securerandom'
require "base64"

server = TCPServer.open(2000)    # Socket to listen on port 2000
loop {                           # Servers run forever
    puts "Waiting for connection..."
    client = server.accept        # Wait for a client to connect
    puts "Connection established"
    # alg = client.gets.chomp
    # puts "Hashing algorithm: " + alg

    # ranb1 = client.gets.chomp
    # puts "String of random bits from Bob (base64): " + ranb1
    # ranb1 = Base64.decode64(ranb1)

    # ranb2 = SecureRandom.random_bytes
    # puts "My string of random bits (base64): " + Base64.strict_encode64(ranb2)

    # puts "Choose your bit:\n"
    # b = ""
    # while b == ""
    # case gets.strip
    #     when "0"
    #         b = "0"
    #     when "1"
    #         b = "1"
    #     else
    #         puts "Not an option"
    #     end
    # end

    # data = ranb1 + ranb2 + b

    # digestor = Digestor.new
    # digestor.digest(data, alg)

    # hash64 = Base64.strict_encode64(digestor.hash)

    # puts "hash (base64):" + hash64
    # puts "Sending hash to Bob..."
    # client.puts hash64

    # puts "Waiting for Bob to announce his choosen bit..."
    # bobsBit = client.gets.chomp
    # puts "Bob's choosen bit: " + bobsBit

    # puts "Sending my random string of bits and my choosen bit..."
    # client.puts Base64.strict_encode64(ranb2)
    # client.puts b

    # if (client.gets)
    #     result = b.to_i ^ bobsBit.to_i
    #     puts "Result: " + result.to_s
    # else
    #     puts "Something went wrong..."
    # end

    client.close                  # Disconnect from the client
}