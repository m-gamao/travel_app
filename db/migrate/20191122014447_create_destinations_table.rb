class CreateDestinationsTable < ActiveRecord::Migration
  def change
    create_table :destinations do |t|

      t.string :location
      t.string :name
      t.string :description

      t.integer :user_id  
    end
  end
end
