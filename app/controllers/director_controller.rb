class DirectorController < ApplicationController

    get '/directors' do
        @user = current_user
        if @user
            @directors = alphabetize(get_directors)
            erb :"directors/index"
        else
            erb :"users/error"
        end
    end

    get '/directors/:slug' do
        @user = current_user
        if @user
            @director = find_by_slug(params[:slug])
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

        def find_by_slug(slug)
            slug = slug.split("-").map {|a| a.capitalize}
            name = slug.join(" ")
            current_user.directors.find_by(name: name)
        end

        def get_directors
            directors = []
            current_user.directors.each do |director|
                if !directors.include?(director)
                    directors << director
                end
            end
            directors
        end
    end
end