# frozen_string_literal: true

10.times do
  setting = FactoryBot.create(:setting)
  setting.save
end
