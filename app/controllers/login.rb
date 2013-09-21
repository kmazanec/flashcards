post '/logout' do
  session.clear
  redirect '/'

end 

post '/login' do
  user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
  if user
    session[:user_id] = user.id 
  else
    session[:error] = 'invalid login'    # should we use a session value instead? 
    redirect '/'
  end
  redirect '/'
end

post '/signup' do
  user = User.create(params[:user])
  user.save
  session[:user_id] = user.id
  erb :index
end
