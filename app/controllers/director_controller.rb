class DirectorController < ApplicationController

    get '/directors' do
        @user = User.find_by_id(session[:user_id])
        if @user
            @directors = get_directors(@user)
            @directors = alphabetize(@directors)
            erb :"directors/index"
        else
            erb :"users/error"
        end
    end

    get '/directors/:slug' do
        @user = User.find_by_id(session[:user_id])
        if @user
            @director = find_by_slug(params[:slug], User.find_by_id(session[:user_id]))
            @director_movies = @user.movies.select {|movie| movie.director == @director}
            @director_movies = @director_movies.sort_by {|movie| movie.name}
            erb :"/directors/show"
        else
            erb :"/users/error"
        end
        
    end

    helpers do
        def alphabetize(array)
            array.sort_by {|d| d.name.split(" ").last}
        end

        def find_by_slug(slug, user)
            slug = slug.split("-").map {|a| a.capitalize}
            name = slug.join(" ")
            user.directors.find_by(name: name)
        end

        def get_directors(user)
            directors = []
            user.directors.each do |director|
                if !directors.include?(director)
                    directors << director
                end
            end
            directors
        end
    end
end