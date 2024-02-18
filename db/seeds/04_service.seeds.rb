# frozen_string_literal: true

puts 'Create services'

4.times.each do |n|
  Service.create! do |service|
    service.name = "Dịch vụ #{n + 1}"
    service.price = n + 10_000
    service.note = "Ghi chú #{n + 1}"
    service.user_id = 1
  end
end
