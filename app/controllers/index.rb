enable :sessions

get '/' do
  # Look in app/views/index.erb
  # session[:user_id] = 1
  # session.clear
  if logged_in?
    @user = current_user
    @game = current_game
    @decks = Deck.all
    erb :index
  else
    # session.clear
    erb :signup
  end
end

get '/game_complete' do
    @last_deck_id = params[:last_deck_id]
    erb :game_complete
end


get '/deck/:deck_id' do
  # this will load the correct deck and then route to the first question
  # or the question the user was last on

  # if request.xhr?
  #   puts
  #   puts "Detected ajax in the get deck method"
  #   puts
  # end

  if load_existing_game_on_this_deck(params[:deck_id])
    session[:game_id] = @existing_game.id
    session[:card_id] = @existing_game.current_card
    session[:last_guess_correct] = nil

    redirect to("/deck/#{params[:deck_id]}/#{@existing_game.current_card}")
 
  else
    current_deck = Deck.find(params[:deck_id])

    @game = Game.create(start_time: Time.now,
                        complete: false,
                        deck_id: current_deck.id)

    current_user.games << @game
    current_deck.games << @game

    @game.current_card = current_deck.cards.first.id
    @game.save

    session[:game_id] = @game.id
    session[:card_id] = @game.current_card
    session[:last_guess_correct] = nil

    redirect to("/deck/#{params[:deck_id]}/#{session[:card_id]}")
  end
end

get '/deck/:deck_id/:card_id' do

  # if request.xhr?
  #   puts
  #   puts "Detected ajax in the get card method"
  #   puts
  # end

  @card = Card.find(params[:card_id])
  @game = Game.find(session[:game_id])

  # if request.xhr?
  #   erb :game, layout: false;
  # else
    erb :game
  # end

end

# POST ===================================

post '/deck/:deck_id/:card_id' do
  # when the user answers the question
  # check if the answer is correct
  #   IF correct, send the user to the next question and set the message to 'correct'
  #   NOT correct, send the user back to the same question with the wrong answer field and next question button
  # ALSO update the user's current session info (stats, etc)
  # if request.xhr?
  #   puts
  #   puts "Detected ajax in the post method"
  #   puts
  # end

  new_response = Response.create(guess: params[:guess], game: current_game, card: current_game_card)

  new_response.update( correct: new_response.guess.downcase == new_response.card.answer.downcase )

  session[:last_guess_correct] = new_response.correct

  if new_response.correct
    session[:card_id] = next_game_card_id
    current_game.update(current_card: session[:card_id])

    if session[:card_id].nil?
      current_game.update(complete: true)
      completed_deck_id = current_game.deck.id
      session[:last_game_id] = session[:game_id]
      session[:game_id] = nil
      session[:last_guess_correct] = nil

      redirect to("/game_complete?last_deck_id=#{completed_deck_id}")
    else
      redirect to("/deck/#{params[:deck_id]}/#{session[:card_id]}")
    end
  else

    redirect to("/deck/#{params[:deck_id]}/#{session[:card_id]}")
  end


end



