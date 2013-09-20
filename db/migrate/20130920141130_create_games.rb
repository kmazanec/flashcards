class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :deck_id
      t.time :start_time
      t.time :end_time
      t.integer :current_card
      t.boolean :complete
      t.timestamps
    end 
  end
end
