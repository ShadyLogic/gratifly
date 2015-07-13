require "faker"

10.times do
  new_user = User.create(username: Faker::Internet.user_name, email: Faker::Internet.email)
  new_user.password = "1234swag"
  new_user.save
  5.times do
    new_user.treats << Treat.create(title: "#{Faker::Hacker.verb.capitalize} #{Faker::Hacker.noun}", ready: false, time_start: Time.now, interval_in_seconds: 300)
  end
end
