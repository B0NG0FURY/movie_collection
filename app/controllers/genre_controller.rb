class GenreController < ApplicationController

    get '/genres' do
        @user = current_user
        if @user
            @genres = get_genres.sort_by {|genre| genre.name}
            erb :"/genres/index"
        else
            erb :"/users/error"
        end
    end

    get '/genres/:name' do
        @user = current_user
        if @user
            @genre = Genre.find_by(name: params[:name])
            @list = @user.movies.select {|movie| movie.genres.include?(@genre)}.sort_by {|movie| movie.name}
            erb :"/genres/show"
        else
            erb :"/users/error"
        end
    end

    helpers do
        def get_genres
            current_user.genres.uniq
        end
    end


end