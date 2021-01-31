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
            flash[:error] = "The username or password entered is incorrect."
            redirect '/user/login'
        end

    end

    get '/user/new' do
        erb :'/users/new'
    end

    post '/user/new' do
        if form_completed? && password_verified? && !user_exists?(params[:user][:username])
            user = User.create(params[:user])
            user.name = capitalize_name(user.name)
            user.save
            session[:user_id] = user.id
            redirect '/user'
        elsif form_completed? && !password_verified? && !user_exists?(params[:user][:username])
            flash[:error] = "The passwords do not match, please try again."
            redirect '/user/new'
        elsif form_completed? && user_exists?(params[:user][:username])
            flash[:error] = "That username already exists. Try again."
            redirect '/user/new'
        elsif !form_completed?
            flash[:error] = "One or more forms left blank. Please fill out all forms completely."
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

        def user_exists?(name)
            User.find_by(username: name)
        end

        def form_completed?
            !params[:user][:name].empty? && !params[:user][:username].empty? && !params[:user][:password].empty? && !params[:password_verify].empty?
        end

        def password_verified?
            params[:user][:password] == params[:password_verify]
        end

        def capitalize_name(name)
            name.split(" ").map {|n| n.capitalize}.join(" ")
        end
    end
end