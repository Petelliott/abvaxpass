require 'sinatra'
require 'jwt'
require 'net/http'
require 'uri'
require 'json'
require 'pdf-reader'
require 'stringio'
require 'openssl'

key = OpenSSL::PKey::RSA.new File.read 'private.pem'

get '/' do
  erb :index
end

post '/register' do
  payload = { birthDate: params[:birthdate],
              doseMonth: params[:dosemonth],
              doseYear: params[:doseyear],
              phn: params[:phn] }

  result = Net::HTTP.post URI('https://northamerica-northeast1-alberta-covid-19-records.cloudfunctions.net/vaccine-immunization-card-generator'),
                          payload.to_json,
                          'Content-Type' => 'application/json'

  passport = PDF::Reader.new(StringIO.new(result.body())).pages[0].text

  cert_data = { firstname: /First Name: ([^\n]*)\n/.match(passport).captures[0],
                lastname: /Last Name: ([^\n]*)\n/.match(passport).captures[0],
                birthdate: /Birthdate:  ([^\n]*)\n/.match(passport).captures[0] }

  certificate = JWT.encode cert_data, key, 'RS256'
  redirect to("/certificate/#{certificate}"), 303
end

get '/certificate/:cert' do
  cert_data = JWT.decode(params[:cert], key, true, { algorithm: 'RS256' })[0]
  p cert_data
  erb :certificate, locals: { certificate: params[:cert],
                              firstname: cert_data['firstname'],
                              lastname: cert_data['lastname'],
                              birthdate: cert_data['birthdate'] }
end
