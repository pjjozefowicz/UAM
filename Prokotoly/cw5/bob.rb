require 'socket'
require_relative 'banknote'
require 'securerandom'
require "base64"

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

banknote = Banknote.new(200)

puts banknote.amount
puts banknote.id
#puts banknote.erki
#puts banknote.elki


# puts "Choose hashing algorithm:
#       1. SHA512
#       2. SHA256
#       3. RIPEMD160
#       4. MD5"

# alg = ""
# while alg == ""
#     case gets.strip
#       when "1"
#          alg = "SHA512"
#       when "2"
#          alg = "SHA256"
#       when "3"
#          alg = "RIPEMD160"
#       when "4"
#          alg = "MD5"
#       else
#          puts "Not an option"
#       end
# end

# s.puts alg

# ranb1 = SecureRandom.random_bytes
# puts "Sending string of random bits (base64): " + Base64.strict_encode64(ranb1)
# s.puts Base64.strict_encode64(ranb1)

# herHash = s.gets.chomp
# puts "Recieved hash (base64): " + herHash
# herHash = Base64.decode64(herHash)

# puts "Choose your bit:\n"
#     b = ""
#     while b == ""
#     case gets.strip
#         when "0"
#             b = "0"
#         when "1"
#             b = "1"
#         else
#             puts "Not an option"
#         end
#     end

# s.puts b

# ranb2 = s.gets.chomp
# puts "Alices string of random bits (base64): " + ranb2
# ranb2 = Base64.decode64(ranb2)

# alicesBit = s.gets.chomp
# puts "Alices choosen bit: " + alicesBit

# data = ranb1 + ranb2 + alicesBit

# digestor = Digestor.new
# digestor.digest(data, alg)

# myHash = digestor.hash

# if (herHash == myHash)
#     puts "Hashes match!"
#     s.puts true
#     result = b.to_i ^ alicesBit.to_i
#     puts "Result: " + result.to_s
# else
#     puts "Hashes do not match!"
# end

s.close
