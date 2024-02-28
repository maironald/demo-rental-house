# frozen_string_literal: true

puts '~> Create services'

users = User.with_role_user
users.each do |user|
  5.times do
    service = FactoryBot.create(:service, user:)
    service.save
  end
end
