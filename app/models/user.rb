class User < ActiveRecord::Base
    has_secure_password
    has_many :movies
    has_many :directors, through: :movies
    has_many :genres, through: :movies
    has_many :formats, through: :movies
end