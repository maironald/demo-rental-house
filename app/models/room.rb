# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id                  :bigint           not null, primary key
#  description         :text
#  electric_amount_new :integer          default(0)
#  electric_amount_old :integer          default(0)
#  length              :integer
#  limit_residents     :integer
#  name                :string
#  price_room          :decimal(, )
#  rental_period       :datetime
#  water_amout_new     :integer          default(0)
#  water_amout_old     :integer          default(0)
#  width               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  renter_id           :bigint
#  user_id             :bigint           not null
#
# Indexes
#
#  index_rooms_on_renter_id  (renter_id)
#  index_rooms_on_user_id    (user_id)
#
class Room < ApplicationRecord
  belongs_to :user
  has_many :renters, dependent: :destroy
  # accepts_nested_attributes_for :renter

  has_many :invoices, dependent: :destroy

  # validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :length, presence: true, numericality: { less_than_or_equal_to: 20_000 }
  validates :width, presence: true, numericality: { less_than_or_equal_to: 20_000 }
  validates :price_room, presence: true
  validates :limit_residents, presence: true, numericality: { only_integer: true }
  validates :description, presence: true

  def calculate_electric_amount
    electric_amount_new - electric_amount_old
  end

  def calculate_water_amount
    water_amout_new - water_amout_old
  end

  def check_electric_water_amount
    calculate_electric_amount.negative? || calculate_water_amount.negative?
  end
end
