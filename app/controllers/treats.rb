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

post '/treats/complete' do
	treat = Treat.find(params[:treat_id])
	if treat.ready?
		treat.collect
		treat.reset_time
		redirect "/"
	else
		"THIS TREAT IS NOT YET READY!"
	end
end