class FormatController < ApplicationController

    get '/formats' do
        @user = current_user
        if @user
            @formats = get_formats.sort_by {|format| format.name}
            erb :"/formats/index"
        else
            erb :"/users/error"
        end
    end

    get '/formats/:name' do
        @user = current_user
        if @user
            @format = Format.find_by(name: params[:name])
            @list = @user.movies.select {|movie| movie.formats.include?(@format)}.sort_by {|movie| movie.name}
            erb :"/formats/show"
        else
            erb :"/users/error"
        end
    end

    helpers do
        def get_formats
            current_user.formats.uniq
        end
    end

end