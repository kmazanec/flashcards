class User < ActiveRecord::Base
  require 'bcrypt'

  validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates :password, presence: true

  has_secure_password
  has_many :games
  has_many :responses, through: :games

  def number_of_correct_guesses
    self.responses.where("correct = true").count
  end 

  def number_of_incorrect_guesses
    self.responses.where("correct = false").count
  end 

end
