require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_MOVIE'] { SecureRandom.hex(64) }
  end

  require 'rack-flash'
  use Rack::Flash

  get "/" do
    erb :index
  end

end
