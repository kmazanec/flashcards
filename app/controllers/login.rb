get '/logout' do
  session.clear
  redirect '/'

end 

post '/login' do
  user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
  if user
    puts "********* VALID LOGIN ***********"
    session[:user_id] = user.id 
  else
    puts "********* BAD BAD BAD LOGIN ***********"
    session[:error] = "Invalid email or Password"    # should we use a session value instead? 
    puts session[:error]
    redirect '/'
  end
  redirect '/'
end

post '/signup' do
  session.clear
  if request.xhr?
    puts "THIS IS AJAX"
    user = User.new(params[:user])
    p u_save =  user.save
    if u_save
      session[:user_id] = user.id
      return "success"
    else
      return "Invalid Data. Please try again. Quack."
    end
  else
    puts "THIS IS NOT AJAX"
    user = User.new(params[:user])
    user.save
    session[:user_id] = user.id
    erb :index
  end
end

