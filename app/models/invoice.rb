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

  validates :name, presence: true
  validates :paid_money, presence: true

  scope :search_by_name, ->(key) { where('invoices.name ILIKE ? ', "%#{key}%") }
  scope :total_price_greater_than_paid_money, -> { where('total_price > paid_money') }
  scope :total_price_equal_with_paid_money, -> { where('total_price <= paid_money') }

  def self.calculate_electric_price(room, current_user)
    (room.electric_amount_new - room.electric_amount_old).to_d * current_user.setting.price_electric
  end

  def self.calculate_water_price(room, current_user)
    (room.water_amout_new - room.water_amout_old).to_d * current_user.setting.price_water
  end

  def self.calculate_total_price(room, current_user)
    calculate_electric_price(room, current_user) + calculate_water_price(room, current_user) + room.price_room + current_user.setting.price_internet + current_user.setting.price_security + current_user.setting.price_trash
  end
end
