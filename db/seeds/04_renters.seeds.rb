# frozen_string_literal: true

rooms = Room.take(2)
rooms.each do |room|
  FactoryBot.create(:renter, room:, renter_type: 'main', deposit: Faker::Number.decimal)
  2.times do
    FactoryBot.create(:renter, room:, renter_type: 'member')
  end
end
