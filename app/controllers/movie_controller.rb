class MovieController < ApplicationController

    get '/movies' do
        @user = User.find_by_id(session[:user_id])
        if @user
            @movies = @user.movies.sort_by {|movie| movie.name}
            erb :"/movies/index"
        else
            erb :"/users/error"
        end
    end

    post '/movies' do
        if !params[:movie][:name].empty?
            movie = Movie.create(params[:movie])
            movie.user_id = session[:user_id]
            movie.director = Director.find_or_create_by(params[:director])
            movie.save
            redirect "/movies/#{movie.slug}"
        else
            redirect "/movies/new"
        end
    end

    get '/movies/new' do
        @genres = Genre.all
        @formats = Format.all
        erb :"/movies/new"
    end

    get '/movies/:slug' do
        @user = User.find_by_id(session[:user_id])

        if @user
            @movie = find_by_slug(params[:slug], @user)
            erb :"/movies/show"
        else
            erb :"/users/error"
        end
    end

    get '/movies/:slug/edit' do
        @user = User.find_by_id(session[:user_id])
        @genres = Genre.all
        @formats = Format.all
        if @user
            @movie = find_by_slug(params[:slug], @user)
            erb :"/movies/edit"
        else
            erb :"/users/error"
        end
    end

    patch '/movies/:slug' do
        if !params[:movie].keys.include?("genre_ids")
            params[:movie][:genre_ids] = []
        end

        if !params[:movie].keys.include?("format_ids")
            params[:movie][:format_ids] = []
        end
        @user = User.find_by_id(session[:user_id])
        @movie = find_by_slug(params[:slug], @user)

        if !params[:movie][:name].empty?
            @movie.update(params[:movie])
        else
            redirect "/movies/#{@movie.slug}/edit"
        end

        if !params[:director][:name].empty?
            @movie.director = Director.find_or_create_by(name: params[:director][:name])
            @movie.save
        end

        redirect "/movies/#{@movie.slug}"
    end

    delete '/movies/:slug' do
        @movie = find_by_slug(params[:slug], User.find_by_id(session[:user_id]))
        @movie.delete
        redirect "/movies"
    end

    helpers do
       def find_by_slug(slug, user)
        slug = slug.split("-").map {|a| a.capitalize}
        title = slug.join(" ")
        user.movies.find_by(name: title)
       end
    end

end