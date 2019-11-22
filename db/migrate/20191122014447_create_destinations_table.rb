class CreateDestinationsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |d|
      t.string :restaurants
      t.string :nightlife
      t.string :nature_and_parks
      t.string :landmarks_and_monuments
      t.string :museums
      t.string :city 
      t.string :country
      t.string :year_visited
    end
  end
end
