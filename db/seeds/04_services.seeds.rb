# frozen_string_literal: true

4.times do
  service = FactoryBot.create(:service)
  service.save
end
