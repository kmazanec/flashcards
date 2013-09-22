helpers do 
  
  def total_games_played
    Game.all.count
  end 

  def total_number_players
    User.all.count
  end

  def last_game_correct_answers
    @last_correct_count = Game.find(session[:last_game_id]).responses.where(correct: true).count
  end

  def last_game_incorrect_answers
    Game.find(session[:last_game_id]).responses.where(correct: false).count   
  end

  def last_game_length
    @last_length = Game.find(session[:last_game_id]).deck.cards.length
  end

  def last_game_score_percentage
    ( @last_correct_count / @last_length)*100
  end

  def current_card_position
    deck = current_game.deck 
    current_card = current_game_card 
    deck.cards.find_index(current_card)
  end 
end