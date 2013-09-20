class Card < ActiveRecord::Base
  belongs_to :deck
  has_many :responses 
  has_many :games, through: :responses
end
