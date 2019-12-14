class CreateDestinationsTable < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :restaurants
      t.string :nightlife
      t.string :nature_and_parks
      t.string :landmarks_and_monuments
      t.string :museums
      t.string :city 
      t.string :country
      t.string :year_visited

      t.integer :user_id  
    end
  end
end
