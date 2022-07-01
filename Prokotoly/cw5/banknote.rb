#!/usr/bin/ruby

require 'openssl'
require 'xorcist'
require 'securerandom'
require "base64"

class Banknote
    def initialize(amount)
        @amount = amount
        @id = SecureRandom.uuid
        @erki = Array.new
        populate_erki()
        puts erki.count()
        @elki = Array.new
        populate_elki()
        puts elki.count()
        puts elki[0].bytes.to_a.count()
        # i = 0
        # loop do
        #     puts elki[i].bytes.to_a
        #     i += 1
        #     if i == 100
        #         break
        #     end
        # end
    end

    def populate_erki()
        i = 0
        loop do
            erki << SecureRandom.random_bytes(36)
            i += 1
            if i == 100
                break
            end
        end
    end

    def populate_elki()
        erki.each do |item|
            #elki << Base64.strict_encode64(Xorcist.xor(id, item))
            elki << Xorcist.xor(id, item)
        end
    end

    attr_reader :amount
    attr_reader :id
    attr_reader :erki
    attr_reader :elki
end