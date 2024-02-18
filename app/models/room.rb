# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id                  :bigint           not null, primary key
#  deleted_at          :datetime
#  description         :text
#  electric_amount_new :integer
#  electric_amount_old :integer
#  length              :integer
#  limit_residents     :integer
#  name                :string
#  price_room          :bigint
#  rental_speriod      :datetime
#  water_amout_new     :integer
#  water_amout_old     :integer
#  width               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  renter_id           :bigint
#  user_id             :bigint
#
# Indexes
#
#  index_rooms_on_deleted_at  (deleted_at)
#  index_rooms_on_renter_id   (renter_id)
#  index_rooms_on_user_id     (user_id)
#
class Room < ApplicationRecord
  acts_as_paranoid
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

  # scope
  scope :search_by_name, ->(key) { where('name ILIKE ?', "%#{key}%") }
  scope :filter_room_rented, ->(room_ids) { where(id: room_ids) }
  scope :filter_room_empty, ->(room_ids) { where.not(id: room_ids) }

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
