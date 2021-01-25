class CreateFormats < ActiveRecord::Migration
  def change
    create_table :formats do |t|
      t.string :name
    end
  end
end
