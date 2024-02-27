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
  belongs_to :room, dependent: nil

  # validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, length: { maximum: 30 }
  validates :identity, presence: true, length: { maximum: 30 }
  validates :address, :gender, presence: true
  validates :gender, inclusion: { in: GENDERS }
  validates :renter_type, inclusion: { in: TYPES }

  # validate :check_main_renter_in_room

  scope :search_by_name, ->(key) { where('renters.name LIKE ?', "%#{key}%") }
  scope :renters_main, -> { where(renter_type: 'main') }
  scope :renters_member, -> { where(renter_type: 'member') }

  # def check_main_renter_in_room(_renter, _room_id)
  #   return unless (renter_type == 'member' && room)

  #   errors.add(:base_renter, 'Main renter must exist in the room before adding a member renter') unless room.renters.exists?(renter_type: 'main')
  # end
end
