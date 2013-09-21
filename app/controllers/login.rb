post '/login' do
  # user hash is sent 
  user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
  # create user and save it 
  if user
    session[:user_id] = user.id 
  else
    session[:error] = 'invalid login'    # should we use a session value instead? 
    redirect '/'
  end 
  # turn session on 

  redirect '/'
end

post '/signup' do


  erb :index

end
