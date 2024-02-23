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
#  user_id             :bigint
#
# Indexes
#
#  index_rooms_on_deleted_at  (deleted_at)
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
  validates :electric_amount_new, presence: true
  validates :electric_amount_old, presence: true, on: :update
  validates :price_room, presence: true
  validates :limit_residents, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
  validates :water_amout_new, presence: true
  validates :water_amout_old, presence: true, on: :update

  validate :check_electric_amount, on: :update
  validate :check_water_amount, on: :update

  # scope
  scope :search_by_name, ->(key) { where('name ILIKE ?', "%#{key}%") }
  scope :rooms_rented, -> { where.associated(:renters) }
  scope :rooms_empty, -> { where.missing(:renters) }

  def check_electric_amount
    return unless electric_amount_new.present? && electric_amount_old.present? && electric_amount_new <= electric_amount_old

    errors.add(:base_electric, 'The electric amount old is bigger than the new one!')
  end

  def check_water_amount
    return unless water_amout_new.present? && water_amout_old.present? && water_amout_new <= water_amout_old

    errors.add(:base_water, 'The water amount old is bigger than the new one!')
  end
end
