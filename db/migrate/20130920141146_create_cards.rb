class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :deck_id
      t.text :question
      t.text :answer
      t.timestamps
    end 
  end
end
