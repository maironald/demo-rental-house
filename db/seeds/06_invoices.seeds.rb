# frozen_string_literal: true

puts '~> Create invoices'

rooms = Room.all
users = User.with_role_user
users.each do |user|
  rooms.each do |room|
    @total_price = Invoice.calculate_total_price(room, user)
    2.times do
      invoice = FactoryBot.create(:invoice, room:, total_price: @total_price)
      invoice.save
    end
  end
end
