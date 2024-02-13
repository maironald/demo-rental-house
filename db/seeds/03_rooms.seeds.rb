# frozen_string_literal: true

puts 'Create rooms'

4.times do
  room = FactoryBot.create(:room)
  room.save
end
