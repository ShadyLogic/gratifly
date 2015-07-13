class Treat < ActiveRecord::Base
  belongs_to :user

  # def set_time_start
  # 	self.time_start = Time.now
  # 	self.ready = false
  # end

  def make_ready
  	self.ready = true
  	self.save
  end

  def collect
  	self.reset_time
  	self.ready = false
  	self.save
  end

  def reset_time
  	self.time_start = Time.now
  	self.save
  end

  def time_left
  	self.interval_in_seconds - (Time.now - self.time_start)
  end

  def ready?
  	elapsed_seconds = (Time.now - self.time_start).to_i
  	time_left = self.interval_in_seconds - elapsed_seconds
  	self.ready = true if time_left < 0
  	self.save
  	self.ready
  end

end
