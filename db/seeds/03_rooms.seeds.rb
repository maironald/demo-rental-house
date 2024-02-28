# frozen_string_literal: true

puts '~> Create rooms'

users = User.with_role_user
users.each do |user|
  3.times do
    room = FactoryBot.create(:room, user:, name: Faker::Company.name)
    room.save
  end
end
