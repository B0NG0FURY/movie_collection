class UserController < ApplicationController

    get '/user' do
        @user = current_user
        if @user
            erb :'/users/home'
        else
            erb :'/users/error'
        end
    end

    get '/user/login' do
        if logged_in?
            redirect '/user'
        end
        erb :'/users/login'
    end

    post '/user' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/user'
        else
            redirect '/user/login'
        end

    end

    get '/user/new' do
        erb :'/users/new'
    end

    post '/user/new' do
        if form_completed? && password_verified?
            user = User.create(params[:user])
            session[:user_id] = user.id
            redirect '/user'
        else
            redirect '/user/new'
        end
    end

    get '/user/logout' do
        session.clear
        redirect '/user/login'
    end

    helpers do
        def logged_in?
            !!session[:user_id]
        end

        def current_user
            User.find_by_id(session[:user_id])
        end

        def form_completed?
            !params[:user][:name].empty? && !params[:user][:username].empty? && !params[:user][:password].empty? && !params[:password_verify].empty?
        end

        def password_verified?
            params[:user][:password] == params[:password_verify]
        end
    end
end