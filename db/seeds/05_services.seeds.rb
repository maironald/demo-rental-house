# frozen_string_literal: true

users = User.with_role_user
users.each do |user|
  5.times do
    FactoryBot.create(:service, user:)
  end
end
