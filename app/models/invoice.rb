# == Schema Information
#
# Table name: invoices
#
#  id          :bigint           not null, primary key
#  name        :string
#  paid_money  :decimal(10, 2)   default(0.0)
#  total_price :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  room_id     :bigint
#
# Indexes
#
#  index_invoices_on_room_id  (room_id)
#
class Invoice < ApplicationRecord
  belongs_to :room
end
