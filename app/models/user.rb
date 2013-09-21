

class User < ActiveRecord::Base
  require 'bcrypt'
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
