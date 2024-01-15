# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id                  :bigint           not null, primary key
#  description         :text
#  electric_amount_new :integer
#  electric_amount_old :integer
#  length              :integer
#  limit_residents     :integer
#  name                :string
#  price_room          :bigint
#  rental_period       :datetime
#  water_amout_new     :integer
#  water_amout_old     :integer
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
  has_one :renter, dependent: nil
  has_many :room_services, dependent: :destroy
  has_many :services, through: :room_services
end
