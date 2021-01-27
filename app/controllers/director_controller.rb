class DirectorController < ApplicationController

    get '/directors' do
        @user = User.find_by_id(session[:user_id])
        if @user
            @directors = @user.directors
            @directors = alphabetize(@directors)
            erb :"directors/index"
        else
            erb :"users/error.erb"
        end
    end

    helpers do
        def alphabetize(array)
            array.sort_by {|d| d.name.split(" ").last}
        end
    end
end