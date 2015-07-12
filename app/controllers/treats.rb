get '/treats' do
  erb :"/treats/show"
end

post '/treats' do
  redirect "/"
end

patch '/treats' do
  redirect "/"
end

delete '/treats/delete' do
  redirect "/"
end
