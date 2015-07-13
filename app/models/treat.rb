class Treat < ActiveRecord::Base
  belongs_to :user

  def set_time_start
  	self.set_time_start = Time.now
  	self.ready = false
  end

  def make_ready
  	self.ready = true
  end

  def ready?
  	self.ready
  end
end
