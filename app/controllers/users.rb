get '/users' do
  erb :"/users/show"
end

post '/users' do
  redirect "/"
end

patch '/users' do
  redirect "/"
end

delete '/users/delete' do
  redirect "/"
end
