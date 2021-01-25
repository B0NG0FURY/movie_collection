class Genre < ActiveRecord::Base
    has_many :movie_genres
    has_many :movies, through: :movie_genres
    has_many :directors, through: :movies
end