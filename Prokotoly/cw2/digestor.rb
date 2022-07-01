#!/usr/bin/ruby

require 'openssl'

class Digestor
    def digest(data, algorithm)
        @hash = OpenSSL::Digest.digest(algorithm, data)
        puts "Computed hash value:"
        puts @hash
    end
    attr_reader :hash
end