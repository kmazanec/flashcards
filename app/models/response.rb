class Response < ActiveRecord::Base
  belongs_to :card
  belongs_to :game
  has_one :user, through: :games 
  has_one :deck, through: :games
end
