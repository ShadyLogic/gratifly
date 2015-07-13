get '/users' do
  erb :"/users/show"
end

post '/users' do
  unless User.find_by(username: params[:username]) || User.find_by(email: params[:email])
    signup(params[:username], params[:password], params[:email])
    redirect "/"
  else
    return "THERE IS ALREADY A USER WITH THAT INFORMATION"
  end
end

patch '/users' do
  redirect "/"
end

delete '/users' do
  redirect "/"
end

post '/users/login' do
  unless user = User.find_by(username: params[:username])
    redirect "/?error=NO+USER+BY+THAT+NAME"
  end
  if user.password == params[:password]
    login(user.username)
    redirect "/"
  else
    redirect "/?error=INCORRECT+PASSWORD"
  end
end

post '/users/logout' do
  logout
  redirect "/"
end
