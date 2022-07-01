require 'socket'
require_relative 'encryptor'
require 'base64'

hostname = '150.254.79.106'
port = 2000

s = TCPSocket.open(hostname, port)

puts "Choose encryption-mode:
      1. DES-ECB
      2. 3DES-CBC
      3. IDEA-OFB 
      4. AES192-CBC
      5. RC5-ECB"

mode = ""
while mode == ""
   case gets.strip
      when "1"
         mode = "DES-ECB"
      when "2"
         mode = "DES-EDE-CBC"
      when "3"
         mode = "IDEA-OFB"
      when "4"
         mode = "AES-192-CBC"
      when "5"
         mode = "RC5-ECB"
      else
         puts "Not an option"
      end
end

puts "Your secret message:\n"
message = gets.chomp

encryptor = Encryptor.new
encryptor.encrypt(message, mode)

s.puts Base64.strict_encode64(mode)
s.puts Base64.strict_encode64(encryptor.encrypted)
s.puts Base64.strict_encode64(encryptor.iv)
s.puts Base64.strict_encode64(encryptor.key)

s.close
