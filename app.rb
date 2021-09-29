require 'sinatra'
require 'jwt'


get '/' do
  erb :index
end

post '/register' do
  payload = { birthDate: params[:birthdate],
              doseMonth: params[:dosemonth],
              doseYear: params[:doseyear],
              phn: params[:phn] }
  certificate = JWT.encode payload, nil, 'none'
  redirect to("/certificate/#{certificate}"), 303
end

get '/certificate/:cert' do
  erb :certificate, locals: { certificate: params[:cert] }
end
