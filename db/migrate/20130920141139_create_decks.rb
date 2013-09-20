class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :title
      t.boolean :active
      t.timestamps
    end 
  end
end
