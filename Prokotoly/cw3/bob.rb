require 'socket'
require 'base64'
require_relative 'dh'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

puts "Choose encryption-mode:
      1. DES-ECB (64-bit key)
      2. 3DES-CBC (128-bit key)
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

puts "How long should be the key (in bits)?\n"
keylen = gets.chomp
puts "Generating Diffie-Hellman variables..."
dh1 = OpenSSL::PKey::DH.new(keylen.to_i)
der = dh1.public_key.to_der
puts der

puts "Sending public variables encoded in der..."
s.puts Base64.strict_encode64(der)

dh2_pub_key = OpenSSL::BN.new(s.gets.chomp)
puts "Alice's public key: " + dh2_pub_key.to_s

puts "Sending public key to Alice: " + dh1.pub_key.to_s 
s.puts dh1.pub_key

symm_key = dh1.compute_key(dh2_pub_key)
puts "Symmetric key obtained!"

puts "Your secret message:\n"
message = gets.chomp

encryptor = DHEncryptor.new
encryptor.encrypt(message, mode, symm_key)

s.puts Base64.strict_encode64(mode)
s.puts Base64.strict_encode64(encryptor.encrypted)
s.puts Base64.strict_encode64(encryptor.iv)

s.close
