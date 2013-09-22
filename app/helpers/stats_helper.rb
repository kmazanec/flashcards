helpers do 
  
  def total_games_played
    Game.all.count
  end 

  def total_number_players
    User.all.count
  end 
end