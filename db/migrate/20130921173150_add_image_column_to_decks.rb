class AddImageColumnToDecks < ActiveRecord::Migration
  def up
    add_column :decks, :image_url, :string 
  end

  def down
    remove_column :decks, :image_url
  end 
end
