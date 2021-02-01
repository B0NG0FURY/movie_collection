require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_MOVIE'] { SecureRandom.hex(64) }
  end

  require 'sinatra/flash'
  register Sinatra::Flash

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
        User.find_by_id(session[:user_id])
    end

    def capitalize_name(name)
      name.split(" ").map {|n| n.capitalize}.join(" ")
    end
  end

end
