# frozen_string_literal: true

10.times do
  user = FactoryBot.create(:user, password: '12345678', password_confirmation: '12345678')
  user.skip_confirmation!
end
