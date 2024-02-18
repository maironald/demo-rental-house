# frozen_string_literal: true

puts 'Create renters'

10.times.each do |n|
  Renter.create! do |renter|
    renter.name = "Nguyen #{n + 1}"
    renter.phone_number = "012345678#{n + 1}"
    renter.identity = "012345678#{n + 1}"
    renter.address = 'Ha Noi'
    renter.gender = n.even? ? 'female' : 'male'
    renter.renter_type = 'main'
    renter.deposit = n * 10_000
    renter.room_id = n + 1
  end
end
