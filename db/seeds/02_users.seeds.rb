# frozen_string_literal: true

puts 'Create users'

10.times.each do |n|
  User.create! do |user|
    user.email = "user#{n + 1}@jacky.com"
    user.password = '12345678'
    user.confirmed_at = Time.current
    user.add_role :user
  end
end
