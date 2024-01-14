# frozen_string_literal: true
puts 'Create renters'

4.times.each do |n|
  Renter.create! do |renter|
    renter.name = "Khách #{n + 1}"
    renter.phone_number = "012345678#{n + 1}"
    renter.identity = "012345678#{n + 1}"
    renter.address = "Địa chỉ #{n + 1}, HCM"
    renter.status = 1
    renter.gender = 'Nam'
    renter.deposit = n + 10_000
  end
end
