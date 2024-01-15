puts 'Create rooms'

4.times.each do |n|
  Room.create! do |room|
    room.name = "Phòng #{n + 1}"
    room.length = n + 100
    room.width = n + 100
    room.price_room = n + 100
    room.limit_residents = n + 1
    room.description = 'Phòng có đầy đủ tiện nghi cùng với máy quạt'
    room.user_id = 3
    room.renter_id = 1
  end
end
