require 'sinatra'
require 'http'

get '/auth/:provider/callback' do
  puts "provider: #{provider}"
  return 200
end
