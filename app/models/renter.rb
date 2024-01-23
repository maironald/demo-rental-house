# frozen_string_literal: true

# == Schema Information
#
# Table name: renters
#
#  id           :bigint           not null, primary key
#  address      :string
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
#  index_renters_on_room_id  (room_id)
#
class Renter < ApplicationRecord
  # constants
  GENDERS = %w[male female].freeze
  TYPES = %w[main member].freeze

  # associations
  has_one :rooms, dependent: nil

  # validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, length: { maximum: 20 }
  validates :identity, presence: true, length: { maximum: 20 }
  validates :address, :gender, presence: true
  validates :gender, inclusion: { in: GENDERS }
  validates :renter_type, inclusion: { in: TYPES }
end
