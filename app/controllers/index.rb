enable :sessions

get '/' do
  # Look in app/views/index.erb
  # session[:user_id] = 1

  if logged_in?
    @user = current_user
    @game = current_game
    @decks = Deck.all
    erb :index
  else
    erb :signup
  end
end

get '/game_complete' do
  erb :game_complete
end


get '/deck/:deck_id' do
  # this will load the correct deck and then route to the first question
  # or the question the user was last on

  existing_game = current_user.games.where("deck_id = #{params[:deck_id]} AND complete = false").first

  if existing_game
    session[:game_id] = existing_game.id
    session[:card_id] = existing_game.current_card

    redirect to("/deck/#{params[:deck_id]}/#{existing_game.current_card}")
 
  else
    @game = Game.create(start_time: Time.now,
                        complete: false)

    current_user.games << @game


    current_deck = Deck.find(params[:deck_id])
    current_deck.games << @game

    @game.current_card = current_deck.cards.first.id
    @game.save

    session[:game_id] = @game.id
    session[:card_id] = @game.current_card

    redirect to("/deck/#{params[:deck_id]}/#{session[:card_id]}")
  end
end

get '/deck/:deck_id/:card_id' do
  @card = Card.find(params[:card_id])

  erb :game
end

# POST ===================================

post '/deck/:deck_id/:card_id' do
  # when the user answers the question
  # check if the answer is correct
  #   IF correct, send the user to the next question and set the message to 'correct'
  #   NOT correct, send the user back to the same question with the wrong answer field and next question button
  # ALSO update the user's current session info (stats, etc)
  new_response = Response.create(guess: params[:guess])
  new_response.game = current_game
  new_response.card = current_game_card
  new_response.correct = ( new_response.guess == new_response.card.answer )

  new_response.save

  if new_response.correct
    session[:card_id] = next_game_card_id
    current_game.current_card = session[:card_id]
    session[:error] = nil

    if session[:card_id].nil?
      session[:game_id] = nil
      redirect to("/game_complete")
    else
      redirect to("/deck/#{params[:deck_id]}/#{session[:card_id]}")
    end
  else
    session[:error] = "WRONG ANSWER"

    redirect to("/deck/#{params[:deck_id]}/#{session[:card_id]}")
  end


end



