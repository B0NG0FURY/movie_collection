class MovieController < ApplicationController

    get '/movies' do
        @user = current_user
        if @user
            @movies = @user.movies.sort_by {|movie| movie.name}
            erb :"/movies/index"
        else
            erb :"/users/error"
        end
    end

    post '/movies' do
        if !params[:movie][:name].empty? && !in_collection?(params[:movie][:name])
            movie = Movie.create(params[:movie])
            movie.name = capitalize_name(params[:movie][:name])
            movie.user_id = session[:user_id]
            director_name = capitalize_name(params[:director][:name])
            movie.director = Director.find_or_create_by(name: director_name)
            movie.save
            flash[:movie] = "Movie successfully added to collection."
            redirect "/movies/#{movie.slug}"
        elsif !params[:movie][:name].empty? && in_collection?(params[:movie][:name])
            flash[:movie] = "Movie is already in your collection."
            redirect "/movies/new"
        elsif params[:movie][:name].empty?
            flash[:movie] = "You need to enter a name for the movie you want to add."
            redirect "/movies/new"
        end
    end

    get '/movies/new' do
        @genres = Genre.all
        @formats = Format.all
        erb :"/movies/new"
    end

    get '/movies/:slug' do
        @user = current_user
        @movie = find_by_slug(params[:slug])
        if @user && @movie
            erb :"/movies/show"
        else
            erb :"/users/error"
        end
    end

    get '/movies/:slug/edit' do
        @user = current_user
        @genres = Genre.all
        @formats = Format.all
        @movie = find_by_slug(params[:slug])
        if @user && @movie
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
        @user = current_user
        @movie = find_by_slug(params[:slug])

        if !params[:movie][:name].empty?
            @movie.update(params[:movie])
            @movie.name = capitalize_name(params[:movie][:name])
            @movie.save
        else
            flash[:movie] = "You need to enter a name for your movie!"
            redirect "/movies/#{@movie.slug}/edit"
        end

        if !params[:director][:name].empty?
            @movie.director = Director.find_or_create_by(name: capitalize_name(params[:director][:name]))
            @movie.save
        end

        flash[:movie] = "Movie updated."
        redirect "/movies/#{@movie.slug}"
    end

    delete '/movies/:slug' do
        @movie = find_by_slug(params[:slug])
        @movie.delete
        flash[:delete] = "Movie successfully removed from collection."
        redirect "/movies"
    end

    helpers do
       def find_by_slug(slug)
        slug = slug.split("-").map {|a| a.capitalize}
        title = slug.join(" ")
        current_user.movies.find_by(name: title)
       end

       def in_collection?(name)
        name = capitalize_name(name)
        Movie.find_by(name: name)
       end
    end

end