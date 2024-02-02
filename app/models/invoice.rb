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

  scope :search_by_name, ->(key, room_ids) { where('name ILIKE ? AND room_id IN (?)', "%#{key}%", room_ids) }
  scope :total_price_greater_than_paid_money, -> { where('total_price > paid_money') }
  scope :total_price_equal_with_paid_money, -> { where('total_price <= paid_money') }
end
