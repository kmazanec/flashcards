class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :cards, through: :decks
  has_many :responses

end
