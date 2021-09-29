#!/usr/bin/env ruby
require 'openssl'

key = OpenSSL::PKey::EC.new 'prime256v1'
key.generate_key

public_key = OpenSSL::PKey::EC.new key
public_key.private_key = nil

open 'private.pem', 'w' do |io| io.write key.to_pem end
open 'public.pem', 'w' do |io| io.write public_key.to_pem end
