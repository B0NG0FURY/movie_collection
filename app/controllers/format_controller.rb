class FormatController < ApplicationController

    get '/formats' do
        @user = User.find_by_id(session[:user_id])
        if @user
            @formats = get_formats(@user).sort_by {|format| format.name}
            erb :"/formats/index"
        else
            erb :"/users/error"
        end
    end

    get '/formats/:name' do
        @user = User.find_by_id(session[:user_id])
        if @user
            @format = Format.find_by(name: params[:name])
            @list = @user.movies.select {|movie| movie.formats.include?(@format)}.sort_by {|movie| movie.name}
            erb :"/formats/show"
        else
            erb :"/users/error"
        end
    end

    helpers do
        def get_formats(user)
            formats = []
            user.formats.each do |format|
                if !formats.include?(format)
                    formats << format
                end
            end
            formats
        end
    end

end