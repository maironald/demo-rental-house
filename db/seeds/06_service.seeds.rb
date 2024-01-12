# frozen_string_literal: true

4.times.each do |n|
  Service.create! do |service|
    service.name = "Dịch vụ #{n + 1}"
    service.price_service = n + 10_000
    service.note = "Ghi chú #{n + 1}"
  end
end
