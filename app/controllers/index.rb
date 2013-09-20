get '/' do
  # Look in app/views/index.erb
  
  erb :index
end


get '/deck/:deck_id' do
  # this will load the correct deck and then route to the first question
  # or the question the user was last on
end

get '/deck/:deck_id/:card_id' do
  # send the user to the given question, pull the data from the databse and send to the view


end

# POST ===================================

post '/deck/:deck_id/:card_id' do
  # when the user answers the question
  # check if the answer is correct
  #   IF correct, send the user to the next question and set the message to 'correct'
  #   NOT correct, send the user back to the same question with the wrong answer field and next question button
  # ALSO update the user's current session info (stats, etc)
end

post '/login' do
  # verify the user's info
  # load their profile from the database
  # send to home screen


end

post '/signup' do

end



