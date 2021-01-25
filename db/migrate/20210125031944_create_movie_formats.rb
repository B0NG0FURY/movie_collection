class CreateMovieFormats < ActiveRecord::Migration
  def change
    create_table :movie_formats do |t|
      t.integer :movie_id
      t.integer :format_id
    end
  end
end
