class GenreController < ApplicationController

    get '/genres' do
        @user = User.find_by_id(session[:user_id])
        if @user
            @genres = Genre.all.sort_by {|genre| genre.name}
            erb :"/genres/index"
        else
            erb :"/users/error"
        end
    end

    get '/genres/:name' do
        @user = User.find_by_id(session[:user_id])
        if @user
            @genre = Genre.find_by(name: params[:name])
            @list = @user.movies.select {|movie| movie.genres.include?(@genre)}.sort_by {|movie| movie.name}
            erb :"/genres/show"
        else
            erb :"/users/error"
        end
    end


end