class Director < ActiveRecord::Base
    has_many :movies
    has_many :genres, through: :movies

    def slug
        self.name.downcase.split(" ").join("-")
    end
end