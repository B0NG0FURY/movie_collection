class Movie < ActiveRecord::Base
    belongs_to :user
    belongs_to :director
    has_many :movie_genres
    has_many :genres, through: :movie_genres
    has_many :movie_formats
    has_many :formats, through: :movie_formats

    def slug
        self.name.downcase.split(" ").join("-")
    end

    def self.find_by_slug(slug, user_id)
        slug = slug.split("-").map {|a| a.capitalize}
        title = slug.join(" ")
        Movie.find_by(name: title, user_id: user_id)
    end
end