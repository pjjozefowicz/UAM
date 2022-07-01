require 'socket'
require 'base64'
require 'openssl'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

puts 'connected!'

alice_pub_key_der = Base64.decode64(s.gets.chomp)
alice_msg = Base64.decode64(s.gets.chomp)
alice_sig = Base64.decode64(s.gets.chomp)

dsa = OpenSSL::PKey::DSA.new(alice_pub_key_der)
digest = OpenSSL::Digest::SHA1.digest(alice_msg)

puts dsa.sysverify(digest, alice_sig)

s.close
