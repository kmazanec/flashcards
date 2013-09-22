class Deck < ActiveRecord::Base

	validates :title, presence: true
	validates :title, uniqueness: true

  has_many :cards
  has_many :games
  has_many :responses, through: :games

  def get_next_card(card_id)
    self.cards.find(card_id)
  end
end
