#!/usr/bin/ruby

require 'openssl'

class DHEncryptor
    def encrypt(data, mode, key)
        cipher = OpenSSL::Cipher.new(mode)
        cipher.encrypt
        cipher.key = key
        @iv = cipher.random_iv
        @encrypted = cipher.update(data) + cipher.final
        puts "Encrypted message:"
        puts @encrypted
    end
    def decrypt(encrypted, mode, iv, key)
        decipher = OpenSSL::Cipher.new(mode)
        decipher.decrypt
        decipher.key = key
        decipher.iv = iv
        @plain = decipher.update(encrypted) + decipher.final
        puts "Decrypted message:"
        puts @plain
    end
    attr_reader :key
    attr_reader :iv
    attr_reader :encrypted
    attr_reader :plain
end