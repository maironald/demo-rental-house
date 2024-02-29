# frozen_string_literal: true

User.create! do |user|
  user.email = 'admin@rentalhouse.com'
  user.password = '12345678'
  user.confirmed_at = Time.current
  user.add_role(:admin)
end
