# frozen_string_literal: true

puts 'Create users'

10.times do
  user = FactoryBot.create(:user, password: '12345678', password_confirmation: '12345678')
  user.add_role(:user)
  user.skip_confirmation!
  user.save
end
