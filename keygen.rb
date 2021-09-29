#!/usr/bin/env ruby
require 'openssl'

key = OpenSSL::PKey::RSA.new 2048

open 'private.pem', 'w' do |io| io.write key.to_pem end
open 'public.pem', 'w' do |io| io.write key.public_key.to_pem end
