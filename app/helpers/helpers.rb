helpers do
  def signup(username, password, email)
    new_user = User.new(username: username, email: email)
    new_user.password = password
    new_user.save
    login(new_user.username)
  end

### SET SESSION AFTER VALID LOGIN ###
  def login(username)
    session[:username] = username
  end

  def logout
    session[:username] = nil
  end

  def logged_in?
    !session[:username].nil? && current_user
  end

  def current_user
    current_user = User.find_by(username: session[:username])
    if current_user.nil?
      logout
    end
    current_user
  end

  def find_user(username)
    User.find_by(username: username)
  end

  def format_time(passed_time)
    days = passed_time.split("").shift(3).join.to_i
    days -= 1
    passed_time = passed_time.reverse.chop.chop.chop.chop.reverse
    p "*********** #{passed_time} *************"
    if days > 0
      ("%03d" % days) + ":" + passed_time
    else
      passed_time
    end
  end
end
