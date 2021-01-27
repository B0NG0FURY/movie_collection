class GenreController < ApplicationController

    get '/genres' do
        @user = User.find_by_id(session[:user_id])
        if @user
            @genres = @user.genres.sort_by {|genre| genre.name}
            erb :"/genres/index"
        else
            erb :"/users/error"
        end
    end


end