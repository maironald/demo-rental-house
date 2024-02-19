# == Schema Information
#
# Table name: invoices
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  name        :string
#  paid_money  :decimal(, )      default(0.0)
#  total_price :decimal(, )      default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  room_id     :bigint
#
# Indexes
#
#  index_invoices_on_deleted_at  (deleted_at)
#  index_invoices_on_room_id     (room_id)
#
class Invoice < ApplicationRecord
  acts_as_paranoid
  belongs_to :room

  scope :search_by_name, ->(key, room_ids) { where('name ILIKE ? AND room_id IN (?)', "%#{key}%", room_ids) }
  scope :total_price_greater_than_paid_money, -> { where('total_price > paid_money') }
  scope :total_price_equal_with_paid_money, -> { where('total_price <= paid_money') }
end
