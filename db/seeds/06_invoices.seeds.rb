# frozen_string_literal: true

rooms = Room.all
users = User.with_role_user
users.each do |user|
  rooms.each do |room|
    @total_price = Invoices::GetTotalPriceService.call(room, user)[:total_invoice_price]
    2.times do
      FactoryBot.create(:invoice, room:, total_price: @total_price)
    end
  end
end
