require 'sinatra'
require 'http'
require 'omniauth'
require 'omniauth-mercadolibre'
require 'byebug'                            # Debugging
require 'sinatra/reloader' if development?  # Recarrega a aplicação a cada mudança no código


class MyApp < Sinatra::Base
  use Rack::Session::Cookie #, secret: ENV['SECRET_KEY_BASE']

  use OmniAuth::Builder do
    provider :mercadolibre,
             '6282907391852569',
             'k53k3JRTJgIliZdfiRY72eiQMgx1c3m3',
             origin_param: 'return_to'
    provider :developer, fields: [:uid], uid_field: :uid
  end

  get '/login' do
    '<a href="/auth/developer">Login with OmniAuth Developer</a>'
  end

  get '/auth/:provider/callback' do
    auth_hash = request.env['omniauth.auth']
    byebug
    provider = auth_hash['provider']
    uid = auth_hash['uid']
    name = auth_hash['info']['name']

    puts "Authenticated with #{provider} - UID: #{uid} - Name: #{name}"
    return 200
  end

  get '/auth/failure' do
    message = params[:message]
    "Authentication failed: #{message}"
  end

  # Coloque o comando run no final da classe para iniciar o servidor local e executar o aplicativo
  run! if app_file == $0
end
