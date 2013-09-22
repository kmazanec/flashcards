class Card < ActiveRecord::Base

	validates :question, :answer, presence: true
	validates :question, uniqueness: true

  belongs_to :deck
  has_many :responses 
  has_many :games, through: :responses
end
