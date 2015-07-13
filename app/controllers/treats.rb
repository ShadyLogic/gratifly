get '/treats' do
	redirect "/"
end

get '/treats/new' do
	if logged_in? && current_user
		erb :"/treats/new"
	else
		return "YOU ARE NOT LOGGED IN"
	end
end

get '/treats/edit' do
	if logged_in? && current_user
		@treats = current_user.treats
		erb :"/treats/edit"
	else
		return "YOU ARE NOT LOGGED IN"
	end
end

get '/treats/delete' do
	if logged_in? && current_user
		@treats = current_user.treats
		erb :"/treats/delete"
	else
		return "YOU ARE NOT LOGGED IN"
	end
end

get '/treats/edit/:id' do
	if logged_in? && current_user
		if @treat = Treat.find_by(id: params[:id])
			if @treat.user_id == current_user.id
				erb :"treats/edit_form"
			else
				return "THIS TREAT DOES NOT BELONG TO YOU"
			end
		else
			return "INVALID TREAT ID"
		end
	else
		return "YOU ARE NOT LOGGED IN"
	end
end

post '/treats' do
	if logged_in? && params[:title] != ""
		interval_in_seconds = 0
		if params[:days] != "" || params[:hours] != "" || params[:minutes] != "" || params[:seconds] != ""
			if params[:days]
				interval_in_seconds += 86400 * params[:days].to_i
			end
			if params[:hours]
				interval_in_seconds += 3600 * params[:hours].to_i
			end
			if params[:minutes]
				interval_in_seconds += 60 * params[:minutes].to_i
			end
			if params[:seconds]
				interval_in_seconds += params[:seconds].to_i
			end
		else
			return "YOU MUST ENTER TIME IN AT LEAST ONE FIELD"
		end

		current_user.treats << Treat.create(title: params[:title], ready: false, time_start: Time.now, interval_in_seconds: interval_in_seconds)
		redirect "/"
	else
		return "YOU MUST ENTER A TITLE"
	end
end

put '/treats' do
	if logged_in? && current_user
		if treat = Treat.find_by(id: params[:id])
			if treat.user_id == current_user.id
				interval_in_seconds = 0
				if params[:days] != "" || params[:hours] != "" || params[:minutes] != "" || params[:seconds] != ""
					if params[:days]
						interval_in_seconds += 86400 * params[:days].to_i
					end
					if params[:hours]
						interval_in_seconds += 3600 * params[:hours].to_i
					end
					if params[:minutes]
						interval_in_seconds += 60 * params[:minutes].to_i
					end
					if params[:seconds]
						interval_in_seconds += params[:seconds].to_i
					end
				else
					return "YOU MUST ENTER TIME IN AT LEAST ONE FIELD"
				end
				treat.title 				= params[:title] 
				treat.ready 				= false
				treat.time_start			= Time.now
				treat.interval_in_seconds	= interval_in_seconds
				treat.save
				redirect "/"
			else
				return "THIS TREAT DOES NOT BELONG TO YOU"
			end
		else
			return "INVALID TREAT ID"
		end
	else
		return "YOU MUST BE LOGGED IN TO DO THAT"
	end
end

delete '/treats' do
	if logged_in? && current_user
		if treat = Treat.find_by(id: params[:id])
			if treat.user_id == current_user.id
				Treat.destroy(treat.id)
			else
				return "THIS TREAT DOES NOT BELONG TO YOU"
			end
		else
			return "INVALID TREAT ID"
		end
	else
		return "YOU ARE NOT LOGGED IN"
	end
	redirect "/"
end

post '/treats/complete' do
	if treat = Treat.find_by(id: params[:treat_id])
		if treat.ready?
			treat.collect
			treat.reset_time
			redirect "/"
		else
			return "THIS TREAT IS NOT YET READY!"
		end
	else
		return "INVALID TREAT ID"
	end
end