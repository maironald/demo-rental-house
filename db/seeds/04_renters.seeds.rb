# frozen_string_literal: true

puts '~> Create renters'

rooms = Room.all
rooms.each do |room|
  main_renter = FactoryBot.create(:renter, room:, renter_type: 'main')
  main_renter.save
  2.times do
    member_renter = FactoryBot.create(:renter, room:, renter_type: 'member')
    member_renter.save
  end
end
