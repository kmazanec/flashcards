

class User < ActiveRecord::Base
  require 'bcrypt'
  has_secure_password
  has_many :games 

end
