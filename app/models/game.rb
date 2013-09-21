class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :cards, through: :deck
  has_many :responses

end
