class Deck < ActiveRecord::Base
  has_many :cards
  has_many :games
  has_many :responses, through: :games

  def get_next_card(card_id)
    self.cards.find(card_id)
  end
end
