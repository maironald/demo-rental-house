# frozen_string_literal: true

# == Schema Information
#
# Table name: renters
#
#  id           :bigint           not null, primary key
#  address      :string
#  deleted_at   :datetime
#  deposit      :decimal(, )
#  gender       :string           default("f"), not null
#  identity     :string
#  name         :string
#  phone_number :string
#  renter_type  :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  room_id      :bigint
#
# Indexes
#
#  index_renters_on_deleted_at  (deleted_at)
#  index_renters_on_room_id     (room_id)
#
class Renter < ApplicationRecord
  acts_as_paranoid
  # constants
  GENDERS = %w[male female].freeze
  TYPES = %w[main member].freeze

  # associations
  has_one :room, dependent: nil

  # validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, length: { maximum: 30 }
  validates :identity, presence: true, length: { maximum: 30 }
  validates :address, :gender, presence: true
  validates :gender, inclusion: { in: GENDERS }
  validates :renter_type, inclusion: { in: TYPES }

  scope :search_by_name, ->(key, room_ids) { where('renters.name LIKE ? AND room_id IN (?)', "%#{key}%", room_ids) }
  scope :filter_renter_type, ->(key) { where(renter_type: key) }
end
