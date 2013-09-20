class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :game_id
      t.string :guess
      t.boolean :correct
      t.integer :card_id
    end 
  end
end
