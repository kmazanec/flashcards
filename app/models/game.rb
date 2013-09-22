class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :cards, through: :deck
  has_many :responses

  def last_card_id
    1
  end

  def next_card_id
    1
  end

end
