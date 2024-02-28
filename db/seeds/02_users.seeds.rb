# frozen_string_literal: true

puts '~> Create users'

10.times do |i|
  user = FactoryBot.create(:user, password: '12345678', password_confirmation: '12345678')
  user.add_role(:user) unless i.zero?
  user.skip_confirmation!
  user = User.find_by(email: 'admin@trung.com')
  user.roles.delete(Role.find_by(name: 'user'))

  user.save
end

Setting.destroy_by(user_id: 1)
