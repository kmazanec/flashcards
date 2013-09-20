helpers do

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end


  def current_game
    if session[:game_id]
      @current_game ||= Game.find(session[:game_id])
    end
  end

  def game_in_progress?
    !current_game.nil?
  end

  def current_card
    if session[:card_id]
      @current_card ||= Card.find(session[:card_id])
    end
  end



  
end