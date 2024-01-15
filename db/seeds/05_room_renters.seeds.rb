# frozen_string_literal: true

# update all the room to renter_id = 3
rooms = Room.where(user_id: 3)

puts rooms
rooms.each do |room|
  room.update(renter_id: 3)
end
