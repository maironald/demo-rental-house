# frozen_string_literal: true

users = User.with_role_user
users.each do |user|
  3.times do
    FactoryBot.create(:room, user:, name: "Phòng #{Faker::Code.ean(base: 8)}")
  end
end
